<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>
<style> @IMPORT url("${context}/css/common.css"); </style>
<style> @IMPORT url("${context}/css/member.css"); </style>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<div class="myPageDiv">
	<div class="myPageSection">
		<h4 class="margin-bottom5">마이무비</h4>
		<div class="myPageLine"></div>
				<div class="inputBox">
					<dl>
						<dt><label>예매/취소내역</label></dt>
						<dd>&nbsp;</dd>
					</dl>
					<div class="myPageLine2"></div>
					<dl>
						<dt><label>마이무비스토리</label></dt>
						<dd>&nbsp;</dd>
					</dl>
					<div class="myPageLine2"></div>
					<dl>
						<dt><label><a href="${root}/member/update" title="MY영화관">회원정보수정</a></label></dt>
						<dd>&nbsp;</dd>
					</dl>
					<div class="myPageLine2"></div>
					<dl>
						<dt>
							<label><a href="${root}/member/del">회원탈퇴</a></label>
						</dt>
						<dd>&nbsp;</dd>
					</dl>
					<div class="myPageLine2"></div>
				</div>
	</div>
</div>

