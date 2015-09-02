<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
 
<nav class="navbar navbar-inverse pos-f w-100p z-100">
  <div class="container-fluid navbar-left w-100p">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" style="margin-left: 200;" href="${root}/homes/null/main"><span class="glyphicon glyphicon-home"></span></a>
    </div>
    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav navbar-left">
        <li><a id="bookmain" href="#">책 정보</a></li>
        <li><a id="resmain" href="#" >장바구니</a></li>
        <li><a id="mbmain" href="#" >영화리뷰</a></li>
        <li><a id="mmain" href="#">영화정보</a></li>
        <li><a id="tmain" href="#">극장정보</a></li>
      </ul>
      
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
          <span class="glyphicon glyphicon-user" >회원</span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="${root}/member/agree">회원가입</a></li>
            <li>
            <a href="#loginForm" class="popupOpen">로그인</a>
           </li>
            <%-- <a href="${root}/home/login">로그인</a> --%>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>
<div id="joinForm" class="white-popup-block mfp-hide auto bg-white w-500 h-500">
    
    
    <%-- <jsp:include page="join.jsp"></jsp:include>  --%>
 
</div>
<div id="loginForm" class="white-popup-block mfp-hide bg-white w-500 h-300 auto">
    
     <jsp:include page="login.jsp"></jsp:include> 
 
</div>
<script type="text/javascript">
    $(function() {
        $('.popupOpen').magnificPopup({
            type : 'inline',
            preloader : false,
            /* focus : '#username', */
            modal : true,
            closeContentPos : true,
            fixedContentPos: true,
            alignTop: false, /* 최상단위치 */
            showCloseBtn: true
        });
        $('.popupClose').click(function(e) {
            e.preventDefault();
            $.magnificPopup.close();
        });
        $('document').click(function(e) {
            e.preventDefault();
            $.magnificPopup.close();
        });
    });
</script>
