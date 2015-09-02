<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>
<style> @IMPORT url("${context}/css/common.css"); </style>
<style> @IMPORT url("${context}/css/member.css"); </style>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<div class="joinDiv">
	<div class="joinTop">
		<div class="joinTitle">
			<h2>
				<p>JOIN</p>
				<span>회원가입 신청서</span>
			</h2>
			<br />
		</div>
	</div>
	
	<div class="joinSection">
		<h4 class="margin-bottom5">회원정보</h4>
		<div class="joinLine"></div>
		<p>＊ 회원가입 후 아이디, 이름은 수정하실 수 없습니다.</p>
		<form action="${root}/member/join" method="post" name="memberForm">
			<fieldset>
				<div class="inputBox">
					<dl>
						<dt><label for="name">이름</label></dt>
						<dd><input name="name" id="name" type="text" placeholder="이름을 입력하세요" required>
						</dd>
					</dl>
					<div class="joinLine2"></div>
					<dl>
						<dt><label for="birthday">생년월일</label></dt>
						<dd><input id="birthday" name="birthday" type="date" required /></dd>
						<dd>
							<input name="birthdayRadio" title="양력" class="radio-common"	id="birth_solar" type="radio" value="양력" required>
							<label for="birth_solar">양력</label>	&nbsp;&nbsp;
							<input name="birthdayRadio"	title="음력" class="radio-common" id="birth_lunar" type="radio" value="음력" required>
							<label for="birth_lunar">음력</label>
						</dd>
					</dl>
					<div class="joinLine2"></div>
					<dl>
						<dt><label for="genderRadio">성별</label>	</dt>
						<dd>
							<input name="gender" title="남성" class="radio-common" id="gender_male" type="radio" value="남자" required>
							<label for="gender_male">남성</label>	&nbsp;&nbsp;
							<input name="gender" title="여성" class="radio-common" id="gender_female" type="radio" value="여자" required>
							<label for="gender_female">여성</label>
						</dd>
					</dl>
					<div class="joinLine2"></div>
					<dl>
						<dt><label for="id">아이디</label>	</dt>
						<dd>
							<input name="userId" id="id" type="text" placeholder="아이디를 입력하세요." required>
							&nbsp;<a class="memberbtn h20 w85 white" id="userId" href="#"><b>중복확인</b></a>
						</dd>
						<dd><p>영문/숫자 혼용 20자리 이내</p></dd>
					</dl>
					<div class="joinLine2"></div>
					<dl>
						<dt><label for="userPw">비밀번호</label></dt>
						<dd>
							<input name="userPw" title="비밀번호" id="userPw" type="password" required>
						</dd>
						<dd><p>영문자, 숫자, 특수문자 모두 최소 1가지 이상 조합하여 8~12자리로 설정 가능합니다.</p></dd>
					</dl>
					<dl>
						<dt>
							<label for="userPwConf">비밀번호확인</label>
						</dt>
						<dd>
							<input name="userPwConf" title="비밀번호 확인" id="userPwConf" type="password" required>
						</dd>
					</dl>
					<div class="joinLine2"></div>
					<dl>
						<dt>
							<label for="email">이메일</label>
						</dt>
						<dd>
							<input id="email" type="email" placeholder="sample@email.com" required name="email" />
						</dd>
					</dl>
					<div class="joinLine2"></div>
					<dl>
						<dt>
							<label for="phone">휴대폰번호</label>
						</dt>
						<dd>
							<input id="phone" type="phone" placeholder="01099990000" name="phone" required />
						</dd>
					</dl>
					<div class="joinLine2"></div>
					<br />
					
					<div class="btnCenter">
						<a href="#" class="memberbtn h30 w100 pupple" title="가입완료" onclick="javascript:passChk()"><b>가입완료</b></a>
					</div>
					<!-- <input type="submit" value="가입완료" name="btn" class="button h30 w100 pupple" onclick="javascript:passChk()" /> -->
				</div>
			</fieldset>
		</form>
	</div>
</div>


<script>
function passChk(){
	    if(!(document.memberForm.userPw.value == document.memberForm.userPwConf.value)){
	      alert("비밀번호가 동일하지 않습니다.");
	      document.memberForm.userPwConf.focus();
	      event.preventDefault();
	    }else {
	      document.memberForm.submit();
	      return true;
	    }
	}
</script>