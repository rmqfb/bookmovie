<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root }/resources"></c:set>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.2/jquery-ui.min.js"></script>

<section id="stat-content">
	
	<article id="create-stat-panel" class="box">
	
		<h1>통계 생성</h1>
		
		<p class="info">선택된 월과 통계타입에 따라 모든 유저의 통계 정보가 생성됩니다.</p>
	
		<div>
			<select id="stat-type"></select>
			<a id="createStatTrigger" href="#" class="button">생성</a>
			<p class="result-msg" class="msg"></p>
		</div>
	</article>

	<article id="control-stat-panel" class="box">
		<h1>유저 통계 조회</h1>
		
		<div>
			<input type="text" id="searchUserStat" placeholder="유저 아이디"/>
			<a id="searchUserStatTrigger" href="#" class="button">검색</a>
			
			<p id="alert"></p>
			
			<article id="user-stat-detail" class="box">
				<h2 id="brief"></h2>
				
				<table>
					<tbody>
						<tr>
							<td>
								<h3>인기 도서 카테고리</h3>
								<ul id="favorite-book-categories" class="category-list">
								</ul>
							</td>
							
							<td>
								<div class="vertical-divider"></div>
							</td>
							
							<td>
								<h3>도서 목록</h3>
								
								<table id="favorite-books" >
									<colgroup>
										<col width="500" />
										<col width="200" />
										<col width="150" />
									</colgroup>
									<thead>
										<tr>
											<th>책이름</th>
											<th>출판사</th>
											<th>저자</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								
								<p class="info">더 많은 순위는 통계 뷰 페이지에서 확인해주세요.</p>
							</td>
							
							<td>
								<div class="vertical-divider"></div>
							</td>
							
							<td>
								<h3>월간 독서량</h3>
								<ul id="read-stat" class="category-list">
								</ul>	
							</td>
						</tr>
					</tbody>
				</table>
	
				<div style="text-align:right; padding-right:30px;">
					<a href="#" id="viewUserStat" class="button">통계 뷰 페이지에서 확인하기</a>
				</div>
					
			</article>
		</div>
	</article>
</section><!-- stat-content -->

<script src="${context }/js/bookStat/bookStat.js"></script>
<script type="text/javascript">

$(function(){
	bookStatController.root = '${root}';
	bookStatController.context = '${context}';
	
	bookStatController.loadControllableStatTypes();
	bookStatController.createStatTriggerButton();
	bookStatController.searchUserStatTriggerButton();
	
	$('#searchUserStat').focus();
});

</script>