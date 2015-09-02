<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath()%>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>
	
<div class="box"></div>
	
<script type="text/javascript">
$(function() {
    /* 탭기능 
    $(".tab_content").hide();
    $(".tab_content:first").show();

    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#333");
        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active").css("color", "darkred");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    }); */
	theater.list();
});

var theater = {}
	
var d = new Date();
var yyyy = d.getFullYear();
var mm = d.getMonth()+1;
var dd = d.getDate();
if(dd<10) {dd='0'+dd}
if(mm<10) {mm='0'+mm} 
var date = yyyy+'-'+mm+'-'+dd;
var date2 = (yyyy)+'-'+mm+'-'+(dd+1);

theater.list = function(){
		$.ajax({
			url : '${root}/theater/list/'+date,
			type : 'GET',
			dataType : 'json',
			contentType : 'application/json',
			success : function(data){
				theater.dateTable(data);
			},
			error : function(xhr, status, msg){
				alert('[상세] 영화 상세내용 보기 에러  상태: '+ status +', 내용: ' + msg);
			}
	});
}

theater.dateTable = function(date) {
	$('.box').empty();
	$('.box').append('<div class="thBox">');
	
	var table = '<table style="width: 100%; height: 60%; margin: 0 auto" class="display" id="example">' ;
	
	/* table += '<ul class="tabs"> <li class="active" rel="tab1">날짜1</li>';
		table += ' <li rel="tab2">날짜2</li>';
		table += '</ul>';
		table += '<div class="tab_container">';
		table += '<div id="tab1" class="tab_content">';
		table += '<div class = "thOutline">'; */
		
		// 리스트 테이블 극장, 영화, 상영관, 상영시간 순으로 출력
	table += '<thead>';
	table+='<tr><td colspan="5"><b style="font-size:28px">상영정보</b></td></tr>';
	table+='<tr style="border: 1px solid black;"><td style="text-align: center; font-weight:bold">극장</td> <td style="text-align: center">영화</td>';
	table += '<td style="text-align: center">상영관</td><td style="text-align: center">상영날짜</td>';
	table += '<td style="text-align: center">상영시간</td><</tr></thead><tbody> ';
	// 이치문 사용해서 쿼리문 리스트로 출력
	$.each(date,function(){
		table += '<tr style="border: 1px solid black">';
		table += '<td style="text-align: center" class="right">'+this.mpName+'</td>';
		table += '<td style="text-align: center" class="right">'+this.title+'</td>';
		table += '<td style="text-align: center" class="right">'+this.thName+'</td>';
		table += '<td style="text-align: center" class="right">'+this.thDate+'</td>';
		table += '<td style="text-align: center">' ;
		table += '<a onclick="return theater.detail(\'' + this.thCode + '\', 1);" href="#">'+this.firstTime+'</a> &nbsp; | &nbsp;';		
		table += '<a onclick="return theater.detail(\'' + this.thCode + '\', 2);" href="#">'+this.secondTime+'</a> &nbsp; | &nbsp;';
		table += '<a onclick="return theater.detail(\'' + this.thCode + '\', 3);" href="#">'+this.thirdTime+'</a> &nbsp; | &nbsp;';
		table += '<a onclick="return theater.detail(\'' + this.thCode + '\', 4);" href="#">'+this.fourthTime+'</a> &nbsp; | &nbsp;';
		table += '<a onclick="return theater.detail(\'' + this.thCode + '\', 5);" href="#">'+this.fifthTime+'</a>';
		table += '</tr>';
	});
	table += '</tbody> </table> </div> </div>';
	
	$('.box').html(table);

}

theater.detail = function(thCode, thTime){
	console.log("thCode: "+thCode+", thTime: "+thTime);
	$.ajax({
		url: '${root}/theater/detail/'+thCode+'/'+thTime,
		type: 'GET',
		dataType: 'json',
		contentType: 'application/json',
		success: function(data) {
			theater.detailForm(data);
		},
		error: function(xhr, status, msg) {
			alert('[상세] theater.detail에러 !! 상태: '+status+', 내용: '+msg);
		}
	});
}

    
theater.detailForm = function(data) {
	$('.box').empty();
	$('.box').append('<div class="thbox">');
	var table='<table class="thbox">';
	table+='<tr><td colspan="5"><b style="font-size:28px">상영정보 상세내역</b></td></tr>';
	table+='<tr><td class="thinfo1">극장</td>';
	table+='<td class="thinfo2">'+data.mpName+'</td></tr>';
	table+='<tr><td class="thinfo1">제목</td>';
	table+='<td class="thinfo2">'+data.title+'</td></tr>';
	table+='<tr><td class="thinfo1">날짜</td>';
	table+='<td class="thinfo2">'+data.thDate+'</td><tr>';
	table+='<tr> <td class="thinfo1">상영관</td>';
	table+='<td class="thinfo2">'+data.thName+'</td></tr>';
	table+='<tr><td class="thinfo1">시간</td>';
	table+='<td class="thinfo2">'+data.thTime+'</td></tr>';
	table+='</table></br>';
	table += '<div align="center"><input type="button" id="checkOk" value="예약"> &nbsp; <input type="button" id="checkBack" value="뒤로가기"></div>';
	/* table+='<table style="width:50px; margin : 0 auto;">';
	table+='<tr> <td colspan="2"> <img src="${context}/image/theaterimage/reservation.jpg" ';
	table+='style="width: 100px; cursor: pointer; margin:0 auto"  onclick="return theater.checkOk()"/> </td>';
	table+='<td> <img src="${context}/image/theaterimage/back.jpg" style="width: 100px; cursor: pointer;" onclick="return theater.list()" class="popupClose"/> </td> </tr> </table>'; */
	$('.box').html(table); 
	theater.checkOk(data);
	theater.checkBack();
}
theater.checkBack = function() {
	$('#checkBack').click(function() {theater.list()});
}

theater.checkOk = function(data) {
	$('#checkOk').click(function() {
		console.log("checkOk를 눌럿을 때 :" +data.thCode);
		var data1 = data.thCode;
		var thTime = data.thTime;
		$.post('${root}/thRsv/result/'+data1 +'/'+thTime, {"data1":data1} );
		alert('예약이 되었습니다.');
		location.href("${root}/thRsv/my-thrsv-list/1"); 
	});
}
</script>