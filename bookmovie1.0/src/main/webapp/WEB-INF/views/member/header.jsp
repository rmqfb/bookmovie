<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>


<nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" style="margin-left: 200;" href="${root}/home/main"><span class="glyphicon glyphicon-home"></span></a>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="${root}/book/main" style="font-size: 20px">책 정보</a></li>
        <li><a href="${root}/reservation/main" style="font-size: 20px">장바구니</a></li>
        <li class="active"><a href="${root}/stat/main" style="font-size: 22px">책통계<span class="sr-only">(current)</span></a></li>
        <li><a href="${root}/board/main" style="font-size: 20px">영화리뷰</a></li>
        <li><a href="${root}/board/main" style="font-size: 20px">영화정보</a></li>
        <li><a href="${root}/board/main" style="font-size: 20px">극장정보</a></li>
        <li class="active"><a href="${root}/stat/main" style="font-size: 22px">영화통계<span class="sr-only">(current)</span></a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
          ${member.name} 님 환영합니다.
          <span class="caret"></span>
          </a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="${root}/member/myMovie">마이페이지</a></li>
            <li><a href="${root}/member/logout">로그아웃</a></li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>

