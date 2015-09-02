<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root}/resources"></c:set>
<style> @IMPORT url("${context}/css/common.css"); </style>
<style> @IMPORT url("${context}/css/member.css"); </style>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

<div class="loginDiv">
	<div class="loginTop">
		<div class="loginTitle">
			<h2>
				<p>JOIN</p>
				<span>회원가입</span>
			</h2>
		</div>
		<div class="agreeBox">
			<br /><h3> 개인정보수집 및 활용동의 (필수)</h3>
			<div class="private-info">
				<table class="agreeTable">
					<colgroup>
						<col width="300px">
						<col width="450px">
						<col width="150px">
					</colgroup>
					<thead>
						<tr>
							<th>항목</th>
							<th>이용목적</th>
							<th>보유기간</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>성명, 아이디, 비밀번호, 생년월일, 성별, 이메일주소</td>
							<td>
								<ul>
									<li>- 회원제 서비스 이용에 따른 본인 식별 및 실명 여부 확인</li>
									<li>- 중복 가입 여부 확인</li>
									<li>- 고지사항 전달/불만 처리 등을 위한 원활한 의사소통 경로의 확보</li>
									<li>- 고객센터 운영</li>
									<li>- 불량회원 부정이용 방지 및 비인가 사용방지</li>
									<li>- 사이트 프로그램 편성을 위한 기초자료</li>
								</ul>
							</td>
							<td>회원 탈퇴 시까지</td>
						</tr>
					</tbody>
				</table>
			</div>
			<br /><br />
			<h3>서비스 이용약관 (필수)</h3>
			<div class="service-policy">
				<table class="agreeTable">
					<tr>
						<td>
							<h3>제 1 조 (목적)</h3>
							<p>본 약관은 회원이 시네마가 제공하는 서비스를 이용함에 있어 회원의 제반 권리, 의무 및 관련 절차 등을
								규정하는데 그 목적이 있습니다. 본 약관은 오프라인 매장에서의 서비스에 관한 계약 내용으로 개인정보 취급 방침 및
								온라인(홈페이지)에 관한 서비스 약관은 당사 홈페이지에 기술되어 있습니다.</p>
							<br />
							<h3>제 2 조 (회원의 의무)</h3>
							<dl>
								<dt>①</dt>
								<dd>회원은 이 약관에서 규정하는 사항과 이용안내 또는 공지사항 등을 통하여 공지하는 사항을 준수하여야
									하며, 기타 업무에 방해되는 행위를 하여서는 안됩니다.</dd>
								<dt>②</dt>
								<dd>회원은 제공한 서비스와 혜택(포인트, 경품 등)을 이용하여 영업 활동을 할 수 없습니다.</dd>
								<dt>③</dt>
								<dd>회원은 구매한 티켓을 다른 고객에게 재 판매할 수 없으며, 위반 시에는 제공받았던 서비스가 제공한
									혜택 (포인트, 경품 등)을 반환하여야 합니다.</dd>
								<dt>④</dt>
								<dd>회원은 이용권한, 기타 이용 계약상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할
									수 없습니다.</dd>
							</dl>
							<br />
							<h3>제 3 조 (회원의 탈퇴 및 자격상실)</h3>
							<dl>
								<dt>①</dt>
								<dd>회원은 언제든지 서면, E-MAIL, 전화 및 기타 방법으로 회원탈퇴를 요청할 수 있으며, 회원의
									요청에 따라 조속히 회원 탈퇴에 필요한 제반 절차를 수행합니다.</dd>
								<dt>②</dt>
								<dd>
									회원이 다음 각 호의 사유에 해당하는 경우, 당해 회원에 대한 통보로서 회원의 자격을 상실시킬 수 있습니다.
									<dl>
										<dd>&nbsp;&nbsp;1. 회원이 서비스 가입 신청 시에 허위의 내용을 등록한 경우</dd>
										<dd>&nbsp;&nbsp;2. 회원이 서비스와 포인트를 부정한 방법으로 사용 및 적립한 경우</dd>
									</dl>
								</dd>
								<dt>③</dt>
								<dd>회원이 사망한 경우에는 별도의 통보 없이 당연히 자격이 상실됩니다.</dd>
								<dt>④</dt>
								<dd>본 조 제2항의 사유로 회원 자격이 상실된 회원은 본 조 제2항 각호의 사유가 자신의 고의 또는
									과실에 기한 것이 아님을 소명할 수 있습니다. 이 경우 회원의 소명 내용을 심사하여 회원의 주장이 타당하다고
									판단하는 경우 회원으로 하여금 정상적인 서비스를 이용할 수 있도록 합니다.</dd>
								<dt>⑤</dt>
								<dd>회원탈퇴 또는 자격의 상실이 확정될 경우, 회원에게 적립된 포인트도 함께 소멸됩니다.</dd>
							</dl>
							<br />
							<h3>제 4 조 (회원에 정보 전달)</h3>
							<dl>
								<dt>①</dt>
								<dd>이벤트 및 당첨 정보를 전달하기 위해서 회원이 등록한 E-MAIL 주소 또는 SMS등을 이용 할 수
									있습니다.</dd>
								<dt>②</dt>
								<dd>회원은 E-MAIL 주소 또는 SMS등으로 메시지를 수신 받기를 원하지 않을 경우, 홈페이지에서
									개인정보 수정을 통해 수신거부 할 수 있습니다.</dd>
								<dt>③</dt>
							</dl>
							<br />
							<h3>제 5 조 (약관개정)</h3>
							<dl>
								<dt>①</dt>
								<dd>본 약관은 수시로 개정될 수 있으며 약관을 개정하고자 할 경우 개정된 약관을 적용하고자 하는
									날(이하 "효력 발생일"이라고 합니다)로부터 7일 이전에 약관이 개정된다는 사실과 개정된 내용 등을 아래에 규정된
									방법 중 1가지 이상의 방법으로 회원에게 고지하여 드립니다. 다만 회원에게 불리하게 약관내용을 변경하는 경우에는
									최소한 30일 이상의 사전 유예 기간을 두고 공지합니다.</dd>
								<dd class="margin-top10 margin-bottom10">1.E-MAIL 통보
									2.서면 통보 3.시네마 홈페이지내 게시 4. 극장 내 게시</dd>
								<dt>②</dt>
								<dd>E-MAIL 통보 또는 서면통보의 방법으로 본 약관이 개정된 사실 및 개정된 내용을 회원에게
									고지하는 경우에는 회원이 기제공한 E-MAIL 주소나 주소지 중 가장 최근에 제공된 E-MAIL 주소나 주소지로
									통보합니다.</dd>
								<dt>③</dt>
								<dd>본 조의 규정에 의하여 개정된 약관(이하 ‘개정약관’)은 원칙적으로 그 효력 발생일로부터 장래를
									향하여 유효합니다.</dd>
								<dt>④</dt>
								<dd>회원은 개정약관에 동의하지 않을 경우 회원 탈퇴를 요청할 수 있으며, 개정약관의 효력 발생 요청을
									하지 않을 경우 약관의 변경 사항에 동의한 것으로 간주됩니다.</dd>
							</dl>
							<br />
							<h3>제 6 조 (손해배상)</h3>
							<dl>
								<dt>①</dt>
								<dd>회원이 본 약관의 규정을 위반함으로 인하여 시네마에 손해가 발생한 경우, 이 약관을 위반한 회원은
									시네마에 발생하는 모든 손해를 배상해야 합니다.</dd>
								<dt>③</dt>
								<dd>회원이 서비스를 이용함에 있어 행한 불법행위나 본 약관 위배행위로 인하여 시네마가 회원 이외의 제
									3자로부터 손해배상 청구 또는 소송을 비롯한 각종 이의 제기를 받은 경우 회원은 자신의 책임과 비용으로 시네마를
									면책시켜야 하며, 시네마가 면책되지 못한 경우 당해 회원은 그로 인하여 시네마에 발생한 모든 손해를 배상하여야
									합니다.</dd>
							</dl>
							<br />
							<h3>제 7 조 (면책사항)</h3>
							<dl>
								<dt>①</dt>
								<dd>시네마는 천재지변 또는 이에 준하는 불가항력으로 인하여 서비스를 제공할 수 없는 경우에는 서비스
									제공에 관한 책임이 면제됩니다.</dd>
								<dt>②</dt>
								<dd>시네마는 회원의 귀책사유로 인한 서비스 이용의 장애에 대하여 책임을 지지 않습니다.</dd>
								<dt>③</dt>
								<dd>시네마는 회원이 서비스를 이용하여 기대하는 수익을 상실한 것이나 서비스를 통하여 얻은 자료로 인한
									손해에 관하여 책임을 지지 않습니다.</dd>
								<dt>④</dt>
								<dd>시네마는 회원이 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관하여는 책임을
									지지 않습니다.</dd>
								<dt>⑤</dt>
								<dd>시네마는 서비스 이용과 관련하여 가입자에게 발생한 손해 가운데 가입자의 고의, 과실에 의한 손해에
									대하여 책임을 지지 않습니다.</dd>
							</dl>
							<br />
							<h3>제 8 조 (관할법원)</h3>
							<dl>
								<dd>서비스 이용으로 발생한 분쟁에 대해 소송이 제기될 경우 회사의 본사 소재지를 관할하는 법원을 전속
									관할법원으로 합니다. 다만, 협의가 이루어지지 아니한 경우에는 양 당사자는 민사소송법상의 관할법원에 소송을 제기할
									수 있습니다.</dd>
							</dl>

							<p class="margin-top25 margin-bottom5">[제정] (2015. 7. 15 개정)</p>
							<p>본 약관은 2015년 7월 15일부터 시행합니다.</p>

						</td>
					</tr>
				</table>
			</div>

			<div class="margin-top10">
				<p>
					<strong>※ 이용자는 이용약관에 대한 동의를 거부할 권리가 있으나, 미 동의시 회원가입을 하실 수
						없습니다.</strong>
				</p>
			</div>
			<div class="margin-top10 left">
				<form action="${root}/member/agree2.do" method="post">
					<p>
						<input type="radio" name="policy" value="true" checked="checked"> 
						<label>동의</label> 
						<input type="radio"	name="policy" value="false" onclick="policyNo()"> 
						<label>미동의</label>
					</p>
					<p align="center">
					<div class="margin-top15">
						<a href="${root}/member/agree2" class="memberbtn h30 w100 pupple" title="계속하기"><b>계속하기</b></a>
					</div>
				</form>
				<br />
				<br />
				<br />
			</div>
		</div>
	</div>
</div>

<script>
	function policyNo() {
		alert("약관 미동의시 회원가입을 하실 수 없습니다.", 
			"policyNo",
			"scrollbars, toolbar=no, location=no, directories=no,status=no, menubar=yes, resizable=yes, width=300, height=200, top=200, left=400" )
		location.replace("${root}/home/main") 
	}
</script>
