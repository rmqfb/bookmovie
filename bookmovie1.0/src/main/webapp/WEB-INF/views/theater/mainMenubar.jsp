<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var='root' value='<%=request.getContextPath()%>'></c:set>
<c:set var="context" value="${root}/resources"></c:set>
<style> @IMPORT url("${context}/css/theatercss/common.css"); </style>
<script src='//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>

<body>
	<!-- 극장관리의 메뉴바 -->
<div class="box" >
		<ul class="mainMenu">
			<li>상영관정보</li>
			<li class="active" >
				<a href="timeTable.jsp">시간표</a>
			</li>
			<li>오시는길</li>
		</ul>
</div> 
<!-- 극장관리 메뉴바 종료 -->
</body>
</html>