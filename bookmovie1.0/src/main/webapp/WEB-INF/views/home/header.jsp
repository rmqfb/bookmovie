<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" style="margin-left: 200;" href="${root}/home/main">
      <span class="glyphicon glyphicon-home"></span></a>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="${root}/book/main" >책 정보</a></li>
        <li><a href="${root}/reservation/main" >장바구니</a></li>
        <li><a href="${root}/book/stat/mystat" >책통계<span class="sr-only">(current)</span></a></li>
        <li><a href="${root}/board/main">영화리뷰</a></li>
        <li><a href="${root}/board/main">영화정보</a></li>
        <li><a href="${root}/board/main">극장정보</a></li>
        <li><a href="${root}/movie/stat/mystat" >영화통계<span class="sr-only">(current)</span></a></li>
      </ul>
      
      <ul class="nav navbar-nav navbar-left">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
                자유게시판
          <span class="glyphicon glyphicon-user" aria-hidden="true"></span> <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
          <li><a id="boardmain" href="${root}/board/main" >자유게시판</a></li>
           <li><a href="#" id="userReview">목록</a></li>
            <li><a href="#" id="writeReview">글쓰기</a></li>
            <li><a href="${root}/book/stat/admin">책 통계 생성하기</a></li>
            <li><a href="${root}/movie/stat/admin">영화 통계 생성하기</a></li>
            
          </ul>
        </li>
      </ul>
      
      <ul class="nav navbar-nav flo-r">
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