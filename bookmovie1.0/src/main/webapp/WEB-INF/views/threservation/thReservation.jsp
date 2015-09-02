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
		threservation.inventory(1);
});
var threservation = {}

threservation.inventory = function(pageNo) {
	console.log('pageNo ='+pageNo);
	console.log('${root}/thRsv/my-thrsv-list/'+pageNo);
	$.getJSON('${root}/thRsv/my-thrsv-list/'+pageNo, function(data) {
		console.log('data :'+data);
		$('.box').empty();
		console.log('넘어온 inventory data : '+data.list);
		threservation.list(data,pageNo);
	});
}

threservation.list=function(data,pageNo){
	console.log('list2의 pageNo:'+pageNo);
	console.log('list2의 data:'+data.list);
	$.getJSON('${root}/thRsv/my-thrsv-list/'+pageNo, function(data) {
		console.log('list success data: '+data);
		threservation.table(data);
	});
}

threservation.table = function(data) {
	var thTime="";
	var form = "<form action='${root}/thRsv/del' method='post' id='frm'>";
	var table = "<table>"
	+"<tr><td colspan='3'><b style='font-size:32px'>영화 예매 확인</b></td></tr>"
	+"<td align='center' style='border:1px solid black;'>아이디</td>"
	+"<td align='center' style='border:1px solid black;'>예매번호</td>"
	+"<td align='center' style='border:1px solid black;'>예매날짜</td>"
	+"<td align='center' style='border:1px solid black;'>포스터</td>"
	+"<td align='center' style='border:1px solid black;'>영화제목</td>"
	+"<td align='center' style='border:1px solid black;'>상영날짜</td>"
	+"<td align='center' style='border:1px solid black;'>지역 / 상영관</td>"
	+"<td align='center' style='border:1px solid black;'>상영시간</td>"
	+"<td align='center' style='border:1px solid black;'>선택</td>"
	$.each(data.list, function() {
		if(this.firstTime){
			alert('firstTime'+firstTime)
			thTime=this.firstTime
		}
		table +="<tr><td align='center' style='border:1px solid black;'> "+this.id+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.thRsvNo+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.rsvDate+"</td>"
		+"<td align='center' style='border:1px solid black;'><img src='${context}/image/movieimage/"+this.poster+"'/></td>"
		+"<td align='center' style='border:1px solid black;'> "+this.mTitle+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.thDate+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.mpName+' / '+this.thName+"</td>"
		+"<td align='center' style='border:1px solid black;'>"+this.thTime+"</td>"
		+"<td align='center' colspan='2'  style='border:1px solid black;'>"
		+"<input type='checkbox' name='thRsvNo' value='"+this.thRsvNo+"'/></td></tr>"
	});
	table += '<tr><td colspan="5">';
	table += '<div style="width:600px;margin:0 auto">';
	table += '<nav><ul  class="pagination">';
	table += '</ul></nav></div></td></tr></table>';
	table += "<input type='submit' id='del' value='예매취소'>";
	$('.box').append(form);
	$('#frm').html(table);
	threservation.del();
	
	var pageSize = 5; 
	var rowPerPage = 5; 
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
		$('.pagination').append('<li ><a href="#" onclick="return threservation.inventory('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
	}
	for(var i=startPage;i<=endPage;i++){
		$('.pagination').append('<li><a href="#" onclick="return threservation.inventory('+i+')">'+i+'</a></li>');
	}
	if(endPage < pageCount){
		$('.pagination').append('<li ><a href="#" onclick="return trreservation.inventory('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	}
}

threservation.del = function() {
	$('#frm').submit(function(event){
		var checkbox = [];
		$("input[name='thRsvNo']:checked").each(function(i) {
			checkbox.push($(this).val());
		});
		var postData= {"checkbox":checkbox};
		console.log('postData: '+postData);
		console.log('선택된 개수 : '+$('input:checkbox[name="thRsvNo"]:checked').length);
		$.each(checkbox, function(index, value) {
			console.log(index + " : " + value);
		});
		$.post("${root}/thRsv/del", {"thRsvNo":checkbox} );
	});
}
</script>

