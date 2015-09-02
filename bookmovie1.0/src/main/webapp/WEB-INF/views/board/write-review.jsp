<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath()%>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>


<div class="bobox">
<form action="${root}/board/write/review" name="frmrWrite" id="frmrWrite">
<input type="hidden" name="userId" value="${member.userId}" />
<input type="hidden" name="boardtype" value="1003" />

<table class="tab">
<tr>
    <td>제목 </td>
    <td style="width: 100%;height: 50px;">
    <input type="text" name="title" placeholder="제  목" /></td>
   
</tr>
  <tr> 
    <td> 장르 </td>
    <td><select name="bcate">
        <option value=""> 장르선택 </option>
        <option value="영화"> 영화 </option>
        <option value="북"> 북 </option>
        <option value="기타"> 기타 </option>
      </select> </td>
  </tr>
<tr>
    <td> 내용 </td>
	<td>
	<textarea style="width :50% ;height: 300px;" rows="10" cols="" name="content"></textarea>
	</td>
</tr>

<tr>
   <td>
    <div style="width: 200px; margin: 0 auto;">
     <button id="btnrWrite" style="width: 100px;">작 성</button>
     <button id="btnrCancel" style="width: 100px;">취  소</button>
    </div> 
     
   </td>
</tr>
</table>
</form>
</div>
<script type="text/javascript">
 $(function() {
	 board.load = function(div,url) {
	 	   $(div).empty();
	 	   $(div).load(url);
	 		
	 	
	 }
	 
	  $('#btnrWrite').click(function(event) {
		  event.preventDefault();
		  /*  한 이벤트를 실행중에 이벤트가 초기화로 돌아가는 것을 방지 */
		  /* 따라서 얘는 submit과 짝궁이다 */
	   var $form = $('#frmrWrite')
	   var $data = $form.serialize();
	   var $url = $form.attr('action');
	   board.write($url,$data);
	   alert('전송후에'+$data);
	});
 
 
 });
 
 board ={}
	  
	board.write = function($url,$data) {
		$.ajax({
			type : 'GET',
			url : $url,
			data : $data,
			dataType : 'json',
			contentType : 'application/json',
			success : function(data) {
				if (data == null){
					board.noData();
				} else {
					alert('여기까지 온건가');
					board.list = function(pageNo) {
					  pageNo = 1;
					  $.getJSON('${root}/board/search/1003/'+pageNo,function(data){
						board.table(data);
					  });
					}
				}
				
			}
			
		});	
	}
	//데이터가 입력된후 다시 게시판 목록페이지로 보이게끔하다..
	board.table = function(data) {
		var table = '<select name="bsearch" id="bsearch" style="width: 100px">';
	        table +='<option>선택하세요</option>';
		    table +='<option value="b.BRD_TITLE">제목</option>';
		    table +='<option value="b.BRD_CATEGORY">유형</option>';
		    table +='</select>';
            table += '<input type="text" placeholder="검색어" size="50" id="word"/>';
	        table += '<button id="bsearching" style="width: 50px">검 색</button>';
		    table +='<table class ="tab">';
			table += '<tr><th>글번호</th><th>ID</th><th>이름</th><th>제목</th><th>등록일</th></tr>'
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
			board.search();
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
	/*데이터 가 있지 않을 경우에 대한 변수  */
	board.noData = function() {
		
		var table ='<table class ="tab">';
		table += '<tr><th>글번호</th><th>ID</th><th>이름</th><th>제목</th><th>등록일</th></tr>'
		
			table += '<tr>';
			table += '<td colspan ="5"><p> 등록된 데이터가 없습니다 </p></td>';
			table += '</tr>';
	
		table += '</table>';
		$('.bobox').html(table);
	}
	
	
	//상세페이지를 보이게끔하는것!
	board.detail = function(boardNum){/*int 타입 get이 theme 이라서 seq 를 대체함   */
		alert(boardNum);
		$.ajax({
			url  : '${root}/board/detail/${member.userId}/'+boardNum,			
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
		$('.bobox').append('<form action="${root}/board/update" id="frmRUpdate" name="frmRUpdate">');
		var table ='<input type="hidden" name="userId" value="${member.userId}" />';
		table +='<input type="hidden" name="boardType" value="1003" />';
		table +='<input type="hidden" name="boardNum" value="'+data.boardNum+'"/>';
	    table +='<table class="tab" style="width: 85%;">';
	    table +='<tr>';
	    table +='<td>타이틀</td>';
	    table +='<td style="width: 80%" height="50px;">';
		table +='<input type="text" name="title" value="'+data.title+'"/></td></tr>';
		table +='<tr><td>카테고리</td><td><select name="category"><option value="">'+data.category+'</option>';
		table +='<option value="영화"> 영화 </option><option value="북"> 북 </option>';
		table +='<option value="기타"> 기타 </option>';
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