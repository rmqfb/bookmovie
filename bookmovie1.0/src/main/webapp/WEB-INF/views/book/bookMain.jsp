<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root }/resources"></c:set>

<div id="box">
<table style="width: 100%">
	<tr>
		<td height="100px" width="20%"><a href="#" id="search-cate">카테고리 검색</a></td>
		<td id="big-cat" width="150px;"></td>
		<td id="medium-cat" width="150px;">
		</td>
		<td id="small-cat" width="150px;">
		</td>
		<td width="50%"></td>
	</tr>
	<tr>
		<td height="100px"><a href="#" id="search-book">책 검색</a></td>
		<td rowspan="3" colspan="4" id="contents"></td>	
	</tr>
	<tr>
		<td height="100px">책정보 입력</td>
	</tr>
	<tr>
		<td height="90%"></td>
	</tr>
</table>
</div>


<script type="text/javascript">
/* 책 정보를 눌렀을때 나오는 첫 페이지
   카테고리 검색이 먼저 나온다.*/
$(function() {
	$.getJSON('${root}/book/big-cat',function(data) {
		book.bigCate(data);
		book.defaultTab();
	});
	book.searchCategory();
	book.searchBook();

});

book = {}


/* 대분류 카테고리 */
book.bigCate = function(data) {
	$('#big-cat').empty();
	var sel = '<select name="bigCat" id="bigCat">';
	sel += '<option>--선택하세요--</option>';
	$.each(data,function(){
		sel += '<option class="bigCatSel" value="'+this.bigCat+'">'+this.bigCat+'</option>';
	});
	sel += '</select>';
	$('#big-cat').html(sel);
	book.mediumCate(data);
}

/* 중분류 카테고리 */
book.mediumCate = function(data) {
	$('#bigCat').on("change",function(data){
		
		var selectedOption = $(this).val();
		
		$.getJSON('${root}/book/medium-cat/' + selectedOption ,function(data) {
			$('#medium-cat').empty();
			$('#small-cat').empty();
			book.defaultTab();
			
			var sel = '<select name="mediumCat" id="mediumCat" style="margin-left:10px;">';
			sel += '<option>--선택하세요--</option>';
			$.each(data,function(){
				sel += '<option class="mediumCatSel" value="'+this.mediumCat+'">'+this.mediumCat+'</option>';
			});
			sel += '</select>';
			
			$('#medium-cat').html(sel);
			book.smallCate(data);
		});
	});
}

/* 소분류 카테고리 */
book.smallCate = function(data) {
	$('#mediumCat').on("change",function(data){
		
		var selectedOption = $(this).val();
		
		$.getJSON('${root}/book/small-cat/' + selectedOption ,function(data) {
			$('#small-cat').empty();
			
			var sel = '<select name="smallCat" id="smallCat" style="margin-left:10px;">';
			sel += '<option>--선택하세요--</option>';
			$.each(data,function(){
				sel += '<option class="smallCatSel" value="'+this.smallCat+'">'+this.smallCat+'</option>';
			});
			sel += '</select>';
			$('#small-cat').html(sel);
			book.searchList(1,data);
		});
	}); 
}

/* 카테고리 검색페이지 화면 출력 */
book.searchCategory = function() {
	$('#search-cate').click(function() {
		$('#big-cat').empty();
		$('#medium-cat').empty();
		$('#small-cat').empty();
		$('#contents').empty();
		$.getJSON('${root}/book/big-cat',function(data) {
			book.bigCate(data);
			book.defaultTab();
		});
	});
}

/* 카테고리 선택하기 전에 나오는 셀렉트 */
book.defaultTab = function() {
	var table = '<select><option>----없음----</option></select>';
	$('#medium-cat').html(table);
	$('#small-cat').html(table);
}

/* 검색어로 검색하는 기능 */
book.searching = function() {
	$('#uni-Search').on("change",function(data){
		var selectedOption = $(this).val();
		console.log('검색분류 선택'+selectedOption);
		 $('#searching').click(function() {
			 var word = $('#word').val();
			$.getJSON('${root}/book/searching/' + selectedOption + '/' + word+ '/1',function(data) {
					if (data.size == 0) {
						book.searchValNull();
					} else {
						book.searchVal2(data);
					}
			});
		}); 
	});
}


/* (제목,저자,출판사) 검색어로 검색하는 화면 출력 */
book.searchBook = function() {
	$('#search-book').click(function() {
		$('#big-cat').empty();
		$('#medium-cat').empty();
		$('#small-cat').empty();
		$('#contents').empty();
	var sel = '<select name="uni-Search" id="uni-Search" style="width: 100px">';
		sel +='<option>선택하세요</option>';
		sel +='<option value="book_title">제 목</option>';
		sel +='<option value="author">저 자</option>';
		sel +='<option value="publisher">출판사</option>';
		sel +='</select>';
	var txt = '<input type="text" placeholder="검색어" size="50" id="word"/>';
	var btn = '<button id="searching" style="width: 50px">검 색</button>';
	$('#big-cat').html(sel);
	$('#medium-cat').html(txt);
	$('#small-cat').html(btn);
	book.searching();
	});
}


/* 검색어로 검색하고 다시 되돌아간다 */
book.searchingBack = function(pageNo) {
	console.log('통합검색 다시 넘어온 pageNo : '+pageNo);
	var selectedOption =$('#uni-Search').val();;
	var word = $('#word').val();
	$.getJSON('${root}/book/searching/' + selectedOption + '/' + word+ '/' +pageNo,function(data) {
			if (data.length == 0) {
				book.searchValNull();
			} else {
				book.searchVal2(data);
			}
	});
}


/* 카테고리로 검색한 리스트 출력 */
book.searchList = function(pageNo,data) {
	console.log('카테검색 넘어온 pageNo : '+pageNo);
	console.log('카테검색 넘어온 data : '+data);
	$('#smallCat').on("change",function(data){
		var selectedOption = $(this).val();
		$.getJSON('${root}/book/search-list/' + selectedOption + '/' +pageNo,function(data) {
				if (data.size == 0) {
					book.searchValNull();
				} else {
					book.searchVal(data);
				}
		});
	});
}

/* 다시 되돌아가는 리스트 출력 */
book.backList = function(pageNo) {
	var selectedOption = $('#smallCat').val();
	console.log('카테검색 돌아가는 리스트 넘어온 카테고리 : '+selectedOption);
	console.log('카테검색 돌아가는 리스트 넘어온 pageNo : '+pageNo);
	$.getJSON('${root}/book/search-list/'+selectedOption+'/'+pageNo, function(data) {
		book.searchVal(data);
	});
}


/* 카테 검색한 리스트 값들 출력하는 테이블 */
book.searchVal = function(data) {
	console.log('데이터의 갯수' + data.size);
	console.log('현재페이지 '+ data.currentPage);
	$('#contents').empty();
	
	var table = '<table style="width: 70%;" border="1px solid black">';
		table += '<td border="1px solid black" colspan="2">제목</td>';
		table += '<td border="1px solid black">저자</td>';
		table += '<td border="1px solid black">출판일</td>';
		table += '<td border="1px solid black">출판사</td>';
	$.each(data.list,function(){
		table += '<tr border="1px solid black">';
		table += '<td style="width: 104px; height:150px;" border="1px solid black"><a href="#" onclick="book.detail(\''+this.serialNo+'\')"><img src="${context}/bookImg/'+this.imgAddr+'" style="width: 104px; height:150px;" /></a></td>';
		table += '<td border="1px solid black">'+this.bTitle+'</td>';
		table += '<td border="1px solid black">'+this.author+'</td>';
		table += '<td border="1px solid black">'+this.pressDay+'</td>';
		table += '<td border="1px solid black">'+this.publisher+'</td>';
		table += '</tr>';
	});
	table += '<tr><td colspan="5">';
	table += '<div style="width:600px;margin:0 auto">';
	table += '<nav><ul  class="pagination">';
	/* table += '<li ><a href="#" aria-label="Previous" class="page-li"><span aria-hidden="true">&laquo;</span></a></li>'; */
	
	/* table += '<li ><a href="#" class="page-li"  aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'; */
	table += '</ul></nav></div></td></tr>';
	table += '</table>';
	$('#contents').html(table);
	
	var pageSize = 5; /*페이지 블록이 5*/
	var rowPerPage = 5; /* 한 페이지당 로우 갯수 */
	var rowCount = data.size;
	var pageCount = Math.floor(rowCount / rowPerPage) + (rowCount % pageSize == 0 ? 0 : 1); 
	var currentPage = data.currentPage;
	var nmg = currentPage % pageSize;
	var startPage = 0;
	if(nmg != 0){
		startPage = currentPage - nmg + 1;	
	}else{
		startPage = currentPage - (pageSize-1);
	}
	
	var endPage = startPage + pageSize - 1;
	if(endPage > pageCount){
		endPage = pageCount;
	}
	console.log('시작페이지 :' + startPage + ' 현재페이지 :' + currentPage + ' 끝페이지 :' + endPage + ' 페이지카운트 : '+ pageCount);
	if(startPage > pageSize){
		$('.pagination').append('<li ><a href="#" onclick="return book.backList('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
	}
	for(var i=startPage;i<=endPage;i++){
		$('.pagination').append('<li><a href="#" onclick="return book.backList('+i+')">'+i+'</a></li>');
	}
	if(endPage < pageCount){
		$('.pagination').append('<li ><a href="#" onclick="return book.backList('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	}
}

/* 통합검색한 리스트 값들 출력하는 테이블 */
book.searchVal2 = function(data) {
	$('#contents').empty();
	var table = '<table style="width: 70%;" border="1px solid black">';
		table += '<td border="1px solid black" colspan="2">제목</td>';
		table += '<td border="1px solid black">저자</td>';
		table += '<td border="1px solid black">출판일</td>';
		table += '<td border="1px solid black">출판사</td>';
	$.each(data.list,function(){
		table += '<tr border="1px solid black">';
		table += '<td style="width: 104px; height:150px;" border="1px solid black"><a href="#" onclick="book.detail2(\''+this.serialNo+'\')"><img src="${context}/bookImg/'+this.imgAddr+'" style="width: 104px; height:150px;" /></a></td>';
		table += '<td border="1px solid black">'+this.bTitle+'</td>';
		table += '<td border="1px solid black">'+this.author+'</td>';
		table += '<td border="1px solid black">'+this.pressDay+'</td>';
		table += '<td border="1px solid black">'+this.publisher+'</td>';
		table += '</tr>';
	});
	table += '<tr><td colspan="5">';
	table += '<div style="width:600px;margin:0 auto">';
	table += '<nav><ul  class="pagination">';
	/* table += '<li ><a href="#" aria-label="Previous" class="page-li"><span aria-hidden="true">&laquo;</span></a></li>'; */
	
	/* table += '<li ><a href="#" class="page-li"  aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'; */
	table += '</ul></nav></div></td></tr>';
	table += '</table>';
	$('#contents').html(table);

	var pageSize = 5; /*페이지 블록이 5*/
	var rowPerPage = 5; /* 한 페이지당 로우 갯수 */
	var rowCount = data.size;
	var pageCount = Math.floor(rowCount / rowPerPage) + (rowCount % pageSize == 0 ? 0 : 1); 
	var currentPage = data.currentPage;
	var nmg = currentPage % pageSize;
	var startPage = 0;
	if(nmg != 0){
		startPage = currentPage - nmg + 1;	
	}else{
		startPage = currentPage - (pageSize-1);
	}
	
	var endPage = startPage + pageSize - 1;
	if(endPage > pageCount){
		endPage = pageCount;
	}
	console.log('시작페이지 :' + startPage + ' 현재페이지 :' + currentPage + ' 끝페이지 :' + endPage + ' 페이지카운트 : '+ pageCount);
	if(startPage > pageSize){
		$('.pagination').append('<li ><a href="#" onclick="return book.searchingBack('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
	}
	for(var i=startPage;i<=endPage;i++){
		$('.pagination').append('<li><a href="#" onclick="return book.searchingBack('+i+')">'+i+'</a></li>');
	}
	if(endPage < pageCount){
		$('.pagination').append('<li ><a href="#" onclick="return book.searchingBack('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	}
}


/* 검색시 검색 값이 없을 때 출력하는 테이블 */
book.searchValNull = function() {
	$('#contents').empty();
	
	var table = '<table>';
	table += '<tr>';
	table += '<td style="font-size: 30px;">검색결과가 없습니다.</td>';
	table += '</tr>';
	table += '</table>';
	
	$('#contents').html(table);
}

/* 카테 검색 후 책 선택시 상세정보 출력 */
book.detail = function(serialNo) {
	   $.getJSON('${root}/book/detail/'+serialNo ,function(data) {
				 book.detailForm(data);
      });
}

/* 통합검색 후 책 선택시 상세정보 출력 */
book.detail2 = function(serialNo) {
	   $.getJSON('${root}/book/detail/'+serialNo ,function(data) {
				 book.detailForm2(data);
      });
}


/* 카테검색에서 책 선택시 상세정보 출력하는 테이블 */
book.detailForm = function(data) {
	$('#contents').empty();
	var table = '<table border="1px solid black">';
		table += '<tr border="1px solid black"><td border="1px solid black" style="width:100px">';
		table += '<img src="${context}/bookImg/'+data.imgAddr+'"  style="width:100px"/></td>';
		table += '<td border="1px solid black">'+data.detail+'</td></tr>';
		table += '<tr><td colspan="2" style="height:50px;"><div align="center"><button id="backBtn">확인</button>';
		table += '<button id="re-write">리뷰작성</button>&nbsp;<button id="jang">장바구니 담기</button></div></td></tr>'
		table += '</table>';
	$('#contents').html(table);
	book.backBtn(1);
	book.reviewWrite(data);
	book.jang(data);//장바구니 예약 추가내용
}

/* 통합검색에서 책 선택시 상세정보 출력하는 테이블 */
book.detailForm2 = function(data) {
	$('#contents').empty();
	var table = '<table border="1px solid black">';
		table += '<tr border="1px solid black"><td border="1px solid black" style="width:100px">';
		table += '<img src="${context}/bookImg/'+data.imgAddr+'" style="width:100px"/></td>';
		table += '<td border="1px solid black">'+data.detail+'</td></tr>';
		table += '<tr><td colspan="2" style="height:50px;"><div align="center"><button id="backBtn2">확인</button>';
		table += '<button id="re-write">리뷰작성</button>&nbsp;<button id="jang">장바구니 담기</button></div></td></tr>'
		table += '</table>';
	$('#contents').html(table);
	book.backBtn2(1);
	book.reviewWrite(data);
	book.jang(data); //장바구니에 예약 추가내용
}

/* 리뷰 작성 하기 */
book.reviewWrite = function(data) {
	var userId = '${user.userId}';
	$('#re-write').click(function() {
		$.getJSON('${root}/b-review/write/'+data.serialNo +'/' +userId ,function(data) {
	    	  if (data.count != 0) {
					alert('리뷰는 한번만 작성할 수 있습니다.');
				} else {
					book.reviewWriteForm(data.bReview);
				}
		  });
	});		
}

/* 리뷰 작성하는 폼 */
book.reviewWriteForm = function(data) {
	$('#box').empty();
	console.log('데이타폼에 넘오는 시리얼넘버 = '+data.serialNo);
	var userId = '${user.userId}';
	var table =	'<form action="${root}/b-review/writeConfirm" name="frmWrite" id="frmWrite">';
	table += '<input type="hidden" name="bookCat" value="'+data.bookCat+'" />';
	table += '<input type="hidden" name="serialNo" value="'+data.serialNo+'" />';
	table += '<input type="hidden" name="userId" value="'+userId+'" />';
	table += '<table class="tab" style="width:700px;margin:0 auto">';
	table += '<tr><td name="bTitle">책제목 : '+data.bTitle+'</td><td name="userId"> 작성자 ID : '+userId+'</td></tr>';
	table += '<tr><td style="width:100%;height:50px" colspan="2">';
	table += '<input type="text" name="brdTitle" style="width:90%" placeholder="제 목" />';
	table += '</td></tr><tr><td colspan="2"><textarea rows="10" cols="100" name="brdContent"></textarea>';
	table += '</td></tr><tr><td><div style="width:300px;margin:0 auto">';
	table += '<select name="gPoint" id="gPoint">';
	table += '<option value="11" selected="selected">평점선택</option>';
	table += '<option value="1">1</option>';
	table += '<option value="2">2</option>';
	table += '<option value="3">3</option>';
	table += '<option value="4">4</option>';
	table += '<option value="5">5</option>';
	table += '<option value="6">6</option>';
	table += '<option value="7">7</option>';
	table += '<option value="8">8</option>';
	table += '<option value="9">9</option>';
	table += '<option value="10">10</option>';
	table += '</select>';
	table += '<input type="button" id="btnWrite" style="width:100px" value="전 송"/>';
	table += '<input type="button" id="btnCancel" style="width:100px" value="취 소"></button>';
	table += '</div></td></tr></table></form>';
	$('#box').html(table);
	console.log('카테고리 = '+ data.bookCat);
	book.btnWrite();
	book.btnCancel();
}

/* 리뷰 작성 버튼 눌렀을대 글 작성 */
 book.btnWrite = function() {
	 $('#gPoint').on("change",function(event){
		 event.preventDefault();
	 	var gPoint = $(this).find('option:selected');
	 	var valueSelected = gPoint.val();
	 	var valueSelected2 = $('select :selected').text();
	 	console.log('valueSelected' + valueSelected);
	 	$('#btnWrite').click(function() {
	 		console.log('글 작성 버튼 클릭');
	 		console.log('gPoint :'+gPoint+', value :'+valueSelected); 
			var $form = $('#frmWrite');
			var $data = $form.serialize();
			console.log('평점 = '+gPoint);
			var $url = $form.attr('action');
				$.ajax({
					url : $url,
					type : 'GET',
					data : $data,
					dataType : 'json',
					contentType : 'application/json',
					success : function(data) {
						alert('글이 작성 되었습니다.');
						location.href = '${root}/b-review/main';
					},
					error : function(xhr, status, msg) {
						alert("글작성 에러 상태 :"+status+"\n 내용 : "+msg);
					}
				});
	 		});
		 });
}
 
/* 카테검색에서 책 선택시 리스트로 되돌아가는 버튼 */
book.backBtn = function() {
	$('#backBtn').click(function() {book.backList(1)});
}

/* 통합검색에서 책 선택시 리스트로 되돌아가는 버튼 */
book.backBtn2 = function() {
	$('#backBtn2').click(function() {book.searchingBack(1)});
}

/* 글쓰기 취소시에 */
book.btnCancel = function() {
	$('#btnCancel').click(function() {
		location.href = '${root}/book/main';
	});
}
/* 클릭시 장바구니 메뉴로 이동하는 코드 */
book.jang = function(data) {
	$('#jang').click(function() {
		alert('장바구니에 담았다.');
		var data1 = data.serialNo;
		$.post("${root}/res/result", {"data1":data1} );
	});
}

</script>