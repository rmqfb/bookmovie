<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>
<div class="box">
</div>
<script type='text/javascript'>
$(function() {
		
		reservation.inventory(1);
});
var reservation = {}


reservation.inventory = function(pageNo) {
	console.log('넘어온 pageNo : '+pageNo);
	console.log('${root}/res/my-res-list/'+pageNo);
	$.getJSON('${root}/res/my-res-list/'+pageNo, function(data) {
		
		$('.box').empty();
		console.log('넘어온 inventory data : '+data.list);
		reservation.list2(data,pageNo);
	});

}

reservation.list2 = function(data,pageNo) {
	console.log('list2의 pageNo:'+pageNo);
	console.log('list2의 data:'+data.list);
	$.getJSON('${root}/res/my-res-list/'+pageNo, function(data) {
		console.log('list2의 success:'+data);
		reservation.table(data);
	});
}



/* reservation.select = function($reservURL,$data) {
	console.log('select',$reservURL);
	console.log('select',$data);
	$.ajax({
		url : '${root}/res/my-res-list',
		type : 'get',
		dataType : 'json',
		contentType : 'applicatino/json',
		success : function(data) {  // 여기 파라미터에 있는 data는 Controller에서 @ResponseBody 애노테이션이 붙은 메소드의 리턴값입니다.
				
			alert('data :'+data);
			$('.box').empty();
			reservation.table(data);		
			
		
		},
		error : function(xhr, status, msg) {
			alert('예약 리스트 에러 상태 : ' + status + ' 내용 : ' + msg);
		}
	
		
	});
	
} */
reservation.table = function(data) {
	 console.log('테이블로 넘어온 data'+data.list); 
	var form = "<form action='${root}/res/del' method='post' id='frm'>";
	var table = "<table>"
	+"<tr><td colspan='2'><b style='font-size:32px'>장바구니 목록</b></td></tr>"
	+"<td align='center' style='border:1px solid black;'>예약 번호</td>"
	+"<td align='center' style='border:1px solid black;'>이미지</td>"
	+"<td align='center' style='border:1px solid black;'>책제목</td>"
	+"<td align='center' style='border:1px solid black;'>저자</td>"
	+"<td align='center' style='border:1px solid black;'>출판일</td>"
	+"<td align='center' style='border:1px solid black;'>출판사</td>"
	+"<td align='center' style='border:1px solid black;'>선택</td>";
	
	$.each(data.list, function() {
		table +="<tr><td align='center' style='border:1px solid black;'>"+this.resNo+"</td>"
		+"<td align='center' style='border:1px solid black;'><img src='${context}/bookImg/"+this.imgAddr+"'/></td>"
		+"<td align='center' style='border:1px solid black;'> "+this.bTitle+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.author+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.pressDay+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.publisher+"</td>"
		+"<td align='center' colspan='2'  style='border:1px solid black;'><input type='checkbox' name='resNo' value='"+this.resNo+"'/></td></tr>"
	});
	
	table += '<tr><td colspan="5">';
	table += '<div style="width:600px;margin:0 auto">';
	table += '<nav><ul  class="pagination">';
	table += '</ul></nav></div></td></tr></table>';
	table += "<button type='submit' id='del'>삭제</button>";
	$('.box').append(form);
	$('#frm').html(table);
	reservation.del();
	
	 var pageSize = 5; 
		var rowPerPage = 10; 
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
		console.log('시작페이지 :' + startPage + ' 현재페이지 :' + currentPage + ' 끝페이지 :' + endPage + ' 페이지카운트 : '+ pageCount+'data.size:'+pageSize);
		if(startPage > pageSize){
			$('.pagination').append('<li ><a href="#" onclick="return reservation.inventory('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
		}
		for(var i=startPage;i<=endPage;i++){
			$('.pagination').append('<li><a href="#" onclick="return reservation.inventory('+i+')">'+i+'</a></li>');
		}
		if(endPage < pageCount){
			$('.pagination').append('<li ><a href="#" onclick="return reservation.inventory('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
		}
		 
	}

	

reservation.del = function() {
	$('#frm').submit(function(event) {
		
		var checkbox = [];
		$("input[name='resNo']:checked").each(function(i) {
			checkbox.push($(this).val());
		});
		var postData= {"checkbox":checkbox};
		
		alert('선택된 개수 : '+$('input:checkbox[name="resNo"]:checked').length);
		$.each(checkbox, function(index, value) {
			alert(index + " : " + value);
		});
		/* $.ajax({
			url : '${root}/res/del',
			type : 'POST',
			data : {"checkbox":checkbox},
			dataType : 'json',
			contentType : 'application/json',
			success : function(data) {
				alert("완료!");
				$('.box').empty();
				reservation.table(data);
			},
			error : function(xhr, status, msg) {
				alert('삭제 리스트 에러 상태 : ' + status + ' 내용 : ' + msg);
			}
		}); */
		$.post("${root}/res/del", {"checkbox":checkbox} );
	});
	
	
}
	 /* var seat = {
			changeNo : function (seatNoParam){
				console.log(seatNoParam);
				$('#seatNo').val(seatNoParam);  
				//alert('data :'+data);
			}		
		}  */
</script>

