<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root }/resources"></c:set>

<div id="sel" align="center">
<table>
	<tr>
		<td align="right">
			<select name="search-sel" id="search-sel">
			<option>--선택없음--</option>
			<option value="brd.user_id">아이디</option>
			<option value="brd.brd_title">리뷰제목</option>
			<option value="b.book_title">책제목</option></select></td>
			<td><input type="text" id="word" size="60" placeholder="검색어"/></td>
			<td><button id="searching" style="width:50px">검색</button>
		</td>
	</tr>
</table>
</div>
<br />
<div id="box" align="center"></div>

<script type="text/javascript">
$(function() {
	review.list(1);
});

review = {}

/* 리뷰 리스트 */
review.list = function(pageNo) {
	$.getJSON('${root}/b-review/list/' + pageNo, function(data) {
		review.listForm(data);
	});
}

/* 리뷰 리스트 폼*/
review.listForm = function(data) {
	$('#box').empty();
	var table = '<table id="list" style="width: 70%;" border="1px solid black">';
		table += '<td border="1px solid black" style="background-color: YELLOW">글번호</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">작성자</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW" colspan="2">책 제목</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">글 제목</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">날짜</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">조회수</td>';
	$.each(data.list,function(){
		table += '<tr border="1px solid black">';
		table += '<td border="1px solid black">'+this.brdNo+'</td>';
		table += '<td border="1px solid black">'+this.userId+'</td>';
		table += '<td style="width: 104px; height:150px;" border="1px solid black"><img src="${context}/bookImg/'+this.imgAddr+'" style="width: 104px; height:150px;" /></td>';
		table += '<td border="1px solid black">'+this.bTitle+'</td>';
		table += '<td border="1px solid black"><a href="#" onclick="review.detail(\''+this.brdNo+'\')">'+this.brdTitle+'</a></td>';
		table += '<td border="1px solid black">'+this.brdDate+'</td>';
		table += '<td border="1px solid black">'+this.brdViews+'</td>';
		table += '</tr>';
	});
	table += '<tr><td colspan="7">';
	table += '<div style="width:600px;margin:0 auto">';
	table += '<nav><ul  class="pagination">';
	/* table += '<li ><a href="#" aria-label="Previous" class="page-li"><span aria-hidden="true">&laquo;</span></a></li>'; */
	
	/* table += '<li ><a href="#" class="page-li"  aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'; */
	table += '</ul></nav></div></td></tr></table>';
	review.searching();
	$('#box').html(table);
	
	
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
		$('.pagination').append('<li ><a href="#" onclick="return review.list('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
	}
	for(var i=startPage;i<=endPage;i++){
		$('.pagination').append('<li><a href="#" onclick="return review.list('+i+')">'+i+'</a></li>');
	}
	if(endPage < pageCount){
		$('.pagination').append('<li ><a href="#" onclick="return review.list('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	}
}

/* 검색어로 검색 */
review.searching = function() {
	$('#search-sel').on("change",function(data){
		var selectedOption = $(this).val();
		console.log('검색분류 선택'+selectedOption);
		 $('#searching').click(function() {
			 var word = $('#word').val();
			$.getJSON('${root}/b-review/search/' + selectedOption + '/' + word+ '/1',function(data) {
				if (data.size == 0) {
					review.noData();
				} else {
					review.searchList(data);
				}
			});
		}); 
	});
}

/* 검색 결과가 없을때 */
review.noData = function() {
	$('#box').empty();
	$('#box').html('<td style="font-size: 30px;">검색결과가 없습니다.</td>');
}

/* 검색 결과 리스트 */
review.searchList = function(data) {
	$('#box').empty();
	var table = '<table style="width: 70%;" border="1px solid black"><div id="list">';
		table += '<td border="1px solid black" style="background-color: YELLOW">글번호</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">작성자</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW" colspan="2">책 제목</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">글 제목</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">날짜</td>';
		table += '<td border="1px solid black" style="background-color: YELLOW">조회수</td>';
	$.each(data.list,function(){
		table += '<tr border="1px solid black">';
		table += '<td border="1px solid black">'+this.brdNo+'</td>';
		table += '<td border="1px solid black">'+this.userId+'</td>';
		table += '<td style="width: 104px; height:150px;" border="1px solid black"><img src="${context}/bookImg/'+this.imgAddr+'" style="width: 104px; height:150px;" /></td>';
		table += '<td border="1px solid black">'+this.bTitle+'</td>';
		table += '<td border="1px solid black"><a href="#" onclick="review.detail(\''+this.brdNo+'\')">'+this.brdTitle+'</a></td>';
		table += '<td border="1px solid black">'+this.brdDate+'</td>';
		table += '<td border="1px solid black">'+this.brdViews+'</td>';
		table += '</tr>';
	});
	table += '<tr><td colspan="7">';
	table += '<div style="width:600px;margin:0 auto">';
	table += '<nav><ul  class="pagination">';
	/* table += '<li ><a href="#" aria-label="Previous" class="page-li"><span aria-hidden="true">&laquo;</span></a></li>'; */
	
	/* table += '<li ><a href="#" class="page-li"  aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'; */
	table += '</ul></nav></div></td></tr></div>';
	table += '</table>';
	review.searching();
	$('#box').html(table);
	
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
		$('.pagination').append('<li ><a href="#" onclick="return review.list('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
	}
	for(var i=startPage;i<=endPage;i++){
		$('.pagination').append('<li><a href="#" onclick="return review.list('+i+')">'+i+'</a></li>');
	}
	if(endPage < pageCount){
		$('.pagination').append('<li ><a href="#" onclick="return review.list('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	}
}

/* 리뷰 상세보기 */
review.detail = function(brdNo) {
	$.getJSON('${root}/b-review/detail/'+brdNo,function(data) {
			review.detailForm(data);
	});
}

/* 리뷰 상세보기 폼 */
review.detailForm = function(data) {
	var table = '<table class="tab" style="width: 700px; margin: 0 auto;">';
	table += '<tr>';
	table += '<td>책 제목 : '+data.bTitle+'&nbsp&nbsp&nbsp&nbsp 작성자 : '+data.userId+'</td></tr>';
	table += '<tr><td style="width: 100%; height: 50px;">';
	table += '<input type="text" name="brdTitle" style="width: 90%" readOnly value="'+data.brdTitle+'"/></td>';
	table += '</tr>';
	table += '<tr>';
	table += '<td><textarea readOnly rows="10" cols="100" name="brdContent">'+data.brdContent+'</textarea></td>';
	table += '</tr>';
	table += '<tr>';
	table += '<td>';
	table += '<div style="width: 300px; margin: 0 auto;">';
	table += '<button id="btnUpdate" style="width: 100px">수정</button>';
	table += '<button id="btnDel" style="width: 100px">삭제</button>';
	table += '<button id="btnCancel" style="width: 100px" onclick="return review.list(1)">취소</button>';
	table += '</div>';
	table += '</td>';
	table += '</tr>';
	table += '</table>';
	$('#box').empty();
	$('#box').html(table);
	review.btnUpdate(data);
	review.btnDel(data);
}

/* 삭제 버튼 눌렀을 때 */
review.btnDel = function(data) {
	var userId = '${user.userId}';
	$('#btnDel').click(function() {
		console.log('삭제 버튼 클릭'+data);
		if (userId == data.userId) {
			$.getJSON('${root}/b-review/del/'+data.brdNo,function() {
					alert('글이 삭제되었습니다.');
					review.list(1);
				});
		} else {
			alert('작성자가 아닙니다.');	
		}
	});
}


/* 수정 버튼 눌렀을때 */
review.btnUpdate = function(data) {
	var userId = '${user.userId}';
	$('#btnUpdate').click(function() {
		console.log('수정 버튼 클릭'+data);
		if (userId == data.userId) {
			review.updateForm(data);
		} else {
			alert('작성자가 아닙니다.');	
		}
	});
}

/* 상세정보 수정 폼 */
review.updateForm = function(data) {
	$('#box').empty();
	$('#box').append('<form action="${root}/b-review/update/'+data.brdNo+'" id="frmUpdate" name="frmUpdate" method="GET">');
	var table = '<table class="tab" style="width: 700px; margin: 0 auto;">';
	table += '<tr>';
	table += '<td>책 제목 : '+data.bTitle+'&nbsp&nbsp&nbsp&nbsp 작성자 : '+data.userId+'</td></tr>';
	table += '<tr><td style="width: 100%; height: 50px;">';
	table += '<input type="text" name="brdTitle" style="width: 90%" value="'+data.brdTitle+'"/></td>';
	table += '</tr>';
	table += '<tr>';
	table += '<td><textarea rows="10" cols="100" name="brdContent">'+data.brdContent+'</textarea></td>';
	table += '</tr>';
	table += '<tr>';
	table += '<td>';
	table += '<div style="width: 300px; margin: 0 auto;">';
	table += '<input type="button" id="btnConfirm" style="width: 100px" value="수정완료"/>';
	table += '<input type="button" id="btnCancel2" style="width: 100px" value="취 소">';
	table += '</div>';
	table += '</td>';
	table += '</tr>';
	table += '</table>';
	$('#frmUpdate').html(table);
	review.btnConfirm();
	review.btnCancel2();
}

/* 수정 폼에서 뒤로가기 버튼 */
review.btnCancel2 = function() {
	$('#btnCancel2').click(function() {
		location.href = "${root}/b-review/main";	
	});
}

/* 수정 완료 */
review.btnConfirm = function() {
	$('#btnConfirm').click(function() {
		console.log('수정확인 버튼 클릭');
		var $form = $('#frmUpdate');
		var $data = $form.serialize();
		var $url = $form.attr('action');
		console.log('수정확인버튼 누르고 url'+$url);
		$.ajax({
			url : $url,
			type : 'GET',
			data : $data,
			dataType : 'json',
			contentType : 'application/json',
			success : function(data) {
				alert('글이 수정되었습니다.');
				review.detailForm(data);
			},
			error : function(xhr, status, msg) {
				alert("수정 에러 상태 :"+status+"\n 내용 : "+msg);
			}
		});
	});
}
</script>