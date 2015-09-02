<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root }/resources"></c:set>

<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<section id="stat-content">

	<article id="book-read-cnt" class="box">
		<h1>월간 독서량</h1>

		<div id="book-read-cnt-chart-wrapper">
			<div id="book-read-cnt-chart"></div>
		</div> 
	</article>

	<section class="box">
		<h1>베스트 셀러</h1>
		
		<table id="best-sellers">
			<colgroup>
				<col width="100" />
				<col width="*" />
				<col width="600" />
			</colgroup>
			<thead>
				<tr>
					<th>순위</th>
					<th colspan="2">책 정보</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>		
	</section>

	<section class="box">
	
		<article class="box article-panel">
		
			<h3>도서 카테고리</h3>
			
			<ul id="favorite-book-categories" class="category-list">
			</ul>
		
		</article>

		<article class="box article-panel">

			<h3>${user.name }님이 좋아하는 도서 순위</h3>
			
			<table id="book-rank">
				<colgroup>
					<col width="100" />
					<col width="*" />
				</colgroup>
				<tbody>
				</tbody>
			</table>
		
			<ul id="pagination">
			</ul>			

		</article>	
	
	</section>	

</section>

<script src="${context}/js/bookStat/bookStat.js"></script>
<script type="text/javascript">

$(function(){
	
	bookStatController.root = '${root}';
	bookStatController.context = '${context}';
	bookStatController.signedInUserName = '${user.name}';

	bookStatController.loadBookReadCount();
	bookStatController.loadBestSellerList();
	bookStatController.loadUserFavoriteBookCategoryList(1);
});

</script>