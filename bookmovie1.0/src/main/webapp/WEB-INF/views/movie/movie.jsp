<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath()%>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>
	<div class="box"></div>
	
<script type="text/javascript">
$(function() {
	movie.inventory(1);
});
var movie = {}

// 페이징 리스트 불러오기
movie.inventory = function(pageNo) {
	console.log('넘어온 pageNo : '+pageNo);
	console.log('${root}/movie/list/'+pageNo);
	console.log('${root}');
	$.getJSON('${root}/movie/list/'+pageNo ,function(data) {
			console.log('넘어온 inventory data : '+data.list);
			movie.list(data,pageNo); 
	});

}
//영화 리스트 출력 
movie.list = function(data,pageNo) {
	console.log('list2의 pageNo:'+pageNo);
	console.log('list2의 data:'+data.list);
	$.getJSON('${root}/movie/list/'+pageNo,function(data) {
			console.log('list2의 success:'+data);
			movie.table(data);
	});
}
/*
  영화 코드 받아와서  detailForm,2 보내줌
 
 영화 상세 설명 출력 
 movie.detailForm  리뷰가 있을때
 movie.detailForm2 리뷰가 없을때
 */
movie.detail = function(movieCode) {
	$.getJSON('${root}/movie/detail/'+movieCode,function(data) {
		console.log('movie.detail data.movie:'+data.movie);
		console.log('movie.result :'+data.count);
			
				movie.detailForm2(data);
			
	});
}

//페이징된 영화리스트 폼
movie.table = function(data) {
	console.log('테이블로 넘어온 data'+data.list);
	$('.box').empty();
	var table = '<table class = "tab">';
	table +='<tr>';
	$.each(data.list,function(){
		console.log('영화코드 사용직전 : '+this.movieCode);
		table += '<td><span class="movGradeInfo"> 	<a href="#" >';
		table += '<img  src=" ${context}/image/movieimage/'+this.poster+'" /></a> <br />';
		table += '<a href="#" onclick="return movie.detail(\''+this.movieCode+'\')">'+this.title+'</a><br/>'+this.genre+' <br/> '+this.viewTime+'</span></td>';
	});
	table += '</tr>';
	table += '<tr><td colspan="5">';
	table += '<div style="width:600px;margin:0 auto">';
	table += '<nav><ul  class="pagination">';
	table += '</ul></nav></div></td></tr></table>';
	$('.box').html(table);
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
		$('.pagination').append('<li ><a href="#" onclick="return movie.inventory('+(startPage-pageSize)+')" aria-label="Previous" ><span aria-hidden="true">&laquo;</span></a></li>');
	}
	for(var i=startPage;i<=endPage;i++){
		$('.pagination').append('<li><a href="#" onclick="return movie.inventory('+i+')">'+i+'</a></li>');
	}
	if(endPage < pageCount){
		$('.pagination').append('<li ><a href="#" onclick="return movie.inventory('+(startPage+pageSize)+')" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>');
	}
}


//영화 상세 폼(리뷰가 없을경우) 리뷰쓰기 버튼
movie.detailForm2 = function(data) {
	$('.box').empty();
	var table =' <div class="movDiv" style=" background-image: url(${context}/image/movieimage/'+data.background+');" >';
	table +=' <p align="middle"> '+data.iFrame+' </p>';
	table +='<div class = "div1">';
	table +='<div class="movImg">';
	table +='<img class="img" src="${context}/image/movieimage/'+data.poster+'" />';
	table +='<input type="button" id="write" value="리뷰 작성"/> </div>';
	table +='<div3 class="textback"> <pre class="pre"> '+data.movieInfo+'</pre> </div3>';
	table +='</div></div>';
	$('.box').html(table);
	movie.writeBtn(data);
}

/* 리뷰 작성 확인*/
movie.writeBtn = function(data) {
	var userId = '${user.userId}';
	$('#write').click(function() {
		$.getJSON('${root}/m-review/write/'+data.movieCode +'/' +userId ,function(data) {
	    	  if (data.count != 0) {
					alert('리뷰는 한번만 작성할 수 있습니다.');
				} else {
					movie.writeForm(data.mReview);
				}
		  });
	});		
}

/*
 영화 리뷰 입력 폼
 유저 아이디 
 장르 =카테고리
 영화 코드
 게시판 타입
 값 히든
 */
movie.writeForm = function(data) {
	var userId = '${user.userId}';
	console.log('사용자 아이디 : '+userId);
	console.log("영화코드:"+data.movieCode+", 장르"+data.genre);
	$('.box').empty();
	var userId = '${user.userId}';
	var table =	'<form action="${root}/m-review/writeConfirm" name="frmWrite" id="frmWrite">';
	table += '<input type="hidden" name="genre" value="'+data.genre+'" />';
	table += '<input type="hidden" name="movieCode" value="'+data.movieCode+'" />';
	table += '<input type="hidden" name="userId" value="'+userId+'" />';
	table += '<input type="hidden" name="brdType" value="'+1002+'" />';
	table += '<table class="tab" style="width:700px;margin:0 auto">';
	table += '<tr><td name="title">영화제목 : '+data.title+'</td><td name="userId"> 작성자 ID : '+userId+'</td></tr>';
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
	$('.box').html(table);
	movie.write();
}


//영화리뷰 등록시 작동
movie.write= function() {
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
						location.href = '${root}/m-review/main';
					},
					error : function(xhr, status, msg) {
						alert("글작성 에러 상태 :"+status+"\n 내용 : "+msg);
					}
				});
	 		});
		 });
}

</script>
