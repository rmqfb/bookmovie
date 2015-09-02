<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath()%>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>

<div class="bobox">

</div>
<!-- <html>
  



</html> --> 


<script type="text/javascript">
/*버튼 클릭시 이벤트 발생부분  */

$(function() {
	board.list(1);
	 board.load = function(div,url) {
	 	   $(div).empty();
	 	   $(div).load(url);
	 		
	 	
	 }

});	
board = {}
board.list = function(pageNo) {
	$.getJSON('${root}/board/search/1003/'+pageNo,function(data){
		board.table(data);	
	});
}
	
	$('#writeReview').on('click',function(){
		/* 보드 인설트 부분 시작  */
		board.load('.bobox','${root}/board/path/write-review');
	});
	board.update = function(data) {
		var userId = '${member.userId}';
		$('#btnRUpdate').click(function() {
			console.log('수정 버튼 클릭'+data);
			if(userId != data.userId){
				alert("작성자가 아닙니다.");
			}
			else {
				board.updateForm(data);
			}
		});	
	}

	
	/*----------------------------------------------  */
	
	board.table = function(data) {
		$('.bobox').empty();
    var table = '<select name="bsearch" id="bsearch" style="width: 100px">';
	    table +='<option>선택하세요</option>';
	    table +='<option value="b.USER_ID">ID</option>';
		table +='<option value="b.BRD_TITLE">제목</option>';
		table +='<option value="b.BRD_CATEGORY">유형</option>';
		table +='</select>';
        table += '<input type="text" placeholder="검색어" size="50" id="word"/>';
	    table += '<button id="bsearching" style="width: 50px">검 색</button>';
        table +='<table class ="tab">';
	    table += '<tr><th>글번호</th><th>ID</th><th>이름</th><th>제목</th><th>등록일</th></tr>';
			$.each(data.list, function() {
				table += '<tr>';
				table += '<td>'+this.boardNum+'</td><td>'+this.userId+
				'</td><td>'+this.name+'</td><td><a href="#" onclick="return board.detail('+this.boardNum+')">'+this.title+'</a></td><td>'+this.boardDate+'</td>';
				table += '</tr>';
			});
			table += '<tr><td colspan="7">';
			table += '<div style="width:600px;margin:0 auto">';
			table += '<nav><ul  class="pagination">';
			/* table += '<li ><a href="#" aria-label="Previous" class="page-li"><span aria-hidden="true">&laquo;</span></a></li>'; */
			
			/* table += '<li ><a href="#" class="page-li"  aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'; */
			table += '</ul></nav></div></td></tr></div>';
			table += '</table>';
			
			$('.bobox').html(table);
			board.search();

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
				$('.pagination').append('<li ><a href="#" onclick="return board.list('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
			}
			for(var i=startPage;i<=endPage;i++){
				$('.pagination').append('<li><a href="#" onclick="return board.list('+i+')">'+i+'</a></li>');
			}
			if(endPage < pageCount){
				$('.pagination').append('<li ><a href="#" onclick="return board.list('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
			}
			
			
	}
	/* 셀렉트박스 서치 검색부분 추가  */
	board.search = function() {
		$('#bsearch').on("change",function(data){
		  var selectedOption = $(this).val();
		 $('#bsearching').click(function() {
			 var word = $('#word').val();
			 console.log("들어온 옵션종류 : " ,selectedOption);
			 console.log("들어온 검색종류 : "+word);
			 console.log("아이디 : "+'${member.userId}');
			 $.ajax({
				url : '${root}/board/bsearch/'+ selectedOption + '/'+ word+'/'+'/1',
				type : 'GET',
				data : {},
				dataType : 'json',
				contentType : 'json/application',
				success : function(data) {
					if (data.length == 0){
						board.noData();
					}else {
						board.serchVal(data);
					}
				},
				error : function(xhr, status, message) {
					alert("[통합검색]에러 발생 !!!\n" + status + " : " + message);		
				}
				
			});
		
		  });
			
		});
		
	}
	/*셀렉트박스 서치 검색후 실질적은 데이터 출력 */
	board.serchVal = function(data) {
		$('.bobox').empty();
		
		 var table = '<select name="bsearch" id="bsearch" style="width: 100px">';
		    table +='<option>선택하세요</option>';
		    table +='<option value="b.USER_ID">ID</option>';
			table +='<option value="b.BRD_TITLE">제목</option>';
			table +='<option value="b.BRD_CATEGORY">유형</option>';
			table +='</select>';
	        table += '<input type="text" placeholder="검색어" size="50" id="word"/>';
		    table += '<button id="bsearching" style="width: 50px">검 색</button>';
		
           table +='<table class ="tab">';
	       table += '<tr><th>글번호</th><th>ID</th><th>제목</th><th>등록일</th></tr>';
		$.each(data.list,function(){
			table += '<tr>';
			table += '<td>'+this.boardNum+'</td>';
			table += '<td>'+this.userId+'</td>';
			table += '<td><a href="#" onclick="return board.detail('+this.boardNum+')">'+this.title+'</a></td>';
			table += '<td>'+this.boardDate+'</td>';
			table += '</tr>';
			
			
		});
		table += '<tr><td colspan="7">';
		table += '<div style="width:600px;margin:0 auto">';
		table += '<nav><ul  class="pagination">';
		/* table += '<li ><a href="#" aria-label="Previous" class="page-li"><span aria-hidden="true">&laquo;</span></a></li>'; */
		
		/* table += '<li ><a href="#" class="page-li"  aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>'; */
		table += '</ul></nav></div></td></tr></div>';
		table += '</table>';
		$('.bobox').html(table);
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
			$('.pagination').append('<li ><a href="#" onclick="return board.list('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
		}
		for(var i=startPage;i<=endPage;i++){
			$('.pagination').append('<li><a href="#" onclick="return board.list('+i+')">'+i+'</a></li>');
		}
		if(endPage < pageCount){
			$('.pagination').append('<li ><a href="#" onclick="return board.list('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
		}
	
	
	}
	
	board.detail = function(boardNum){/*int 타입 get이 theme 이라서 seq 를 대체함   */
		alert(boardNum);
		$.ajax({
			url  : '${root}/board/detail/'+boardNum,			
			dataType : 'json',
			contentType : "application/json",
			success : function(data) {
				board.detailForm(data);
			},
			error : function(xhr,status,msg) {
				alert('상세 에러발생 !! 상태 :'+status+",내용 :"+msg);
			}
		});
	}
	board.detailForm = function(data){
		var table ='<table class="tab" style="width:80%">';
		table +='<tr><td>작성자 </td>';
		table +='<td>'+data.userId+'</td>';
		table +='<tr>';
		table +='<td>타이틀</td>';
	    table +='<td style="width: 80%" height="50px;">';
		table +='<input type="text" readonly="readonly" name="title" value="'+data.title+'"/></td></tr>';
		table +='<tr><td>카테고리</td><td><select name="bcate"><option value="">'+data.category+'</option>';
		table +='<option value="영화"> 영화 </option><option value="북"> 북 </option>';
		table +='<option value="기타"> 기타 </option>';
		table +='</select></td></tr>';
		table +='<tr>';
		table +='<td>내용</td>';
		table +='<td><textarea rows="10" cols="" readonly="readonly"  name="content">'+data.boardContent+'</textarea></td>';			
		table +='</tr><tr><td>';		
		table +='<div style="width: 200px; margin: 0 auto;">';
		table +='<button id="btnRUpdate" style="width: 100px;">수 정</button>';
		table +='<button id="btnRCancel" style="width: 100px;">취소</button>';
		table +='</div>';
		table +='</td>';
		table +='</tr>';
		table +='</table>';
		$('.bobox').empty();
		$('.bobox').html(table);
		board.update(data);
	}
	/*업데이트 부분  */
	board.updateForm = function(data) {
		$('.bobox').empty();
		$('.bobox').append('<form action="${root}/board/update/'+data.boardNum+'" id="frmRUpdate" name="frmRUpdate">');
		var table ='<input type="hidden" name="userId" value="${member.userId}" />';
		table +='<input type="hidden" name="theme" value="1003" />';
		table +='<input type="hidden" name="boardNum" value="'+data.boardNum+'"/>';
	    table +='<table class="tab" style="width: 85%;">';
	    table +='<tr>';
	    table +='<td>타이틀</td>';
	    table +='<td style="width: 80%" height="50px;">';
		table +='<input type="text" name="title" value="'+data.title+'"/></td></tr>';
		table +='<tr><td>카테고리</td><td><select name="category"><option value="">'+data.category+'</option>';
		table +='<option value="로맨스"> 로맨스 </option><option value="코미디"> 코미디 </option>';
		table +='<option value="어드벤쳐"> 어드벤쳐 </option>';
		table +='</select></td></tr>';
		table +='<tr>';
		table +='<td>내용</td>';
		table +='<td><textarea rows="10" cols="" name="boardContent">'+data.boardContent+'</textarea></td>';			
		table +='</tr><tr><td>';		
		table +='<div style="width: 200px; margin: 0 auto;">';
		table +='<button id="btnRConfirm" style="width: 100px;">수정완료</button>';
		table +='<button type="reset" id="btnRCancel" style="width: 100px;">취소 </button>';
		table +='<button type="button" id="btnRRemove" style="width: 100px;">삭제</button>';
		table +='</div>';
		table +='</td>';
		table +='</tr>';
		table +='</table>';
	 $('#frmRUpdate').html(table);
	 board.updateConfirm();
	 board.remove();	
	}
	board.updateConfirm = function() {
		$('#btnRConfirm').click(function() {
			$('#frmRUpdate').submit(function(event) {
				event.preventDefault();
				var $form = $('#frmRUpdate');
				var $data = $form.serialize();
				var $url = $form.attr('action');
				$.ajax({
					url : $url,
					type : 'GET',
					data : $data,
					dataType : 'json',
					contentType : 'application/json',
					success : function(data) {
						if(data == null){
							alert('값을 못가져옴');
							board.noData();
						}else{
							board.detailForm(data);
						}
						
					},
					error : function(xhr,status,msg) {
						alert('수정에러발생'+ status +',메세지' + msg);
					}
				});
				
			});
			
		});
		
	}
	/*보드 업데이트 부분 끝  */
	board.remove=function(){
		$('#btnRRemove').click(function() {
			var $form = $('#frmRUpdate');
			var $data = $form.serialize();
			$.ajax({
				url : '${root}/board/remove',
				type : 'GET',
				data : $data,
				dataType : "json",
				contentType : 'application/json',
				success : function(data) {
					board.table(data);
					
				},
				error : function() {
					alert('삭제에러발생'+ status +',메세지' + msg);
				}
				
			})
		});
		
	}
	
	






</script>

