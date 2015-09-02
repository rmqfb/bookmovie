<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root }/resources"></c:set>

<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<section id="stat-content">

	<article id="movie-read-cnt" class="box">
		<h1>영화 상영 횟수</h1>
	
		<div id="movie-view-cnt-chart-wrapper">
			<div id="movie-view-cnt-chart"></div>
		</div> 
	</article>

	<section class="box">
		<h1>베스트 영화</h1>
		
		<table id="popular-movie-list">
			<colgroup>
				<col width="100" />
				<col width="*" />
				<col width="600" />
			</colgroup>
			<thead>
				<tr>
				<th>순위</th>
				<th colspan="2">영화 정보</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>		
	</section>

	<section class="box">
	
		<article class="box article-panel">
			<h3>영화 장르</h3>
			
			<ul id="favorite-genre" class="category-list">
			</ul>
		</article>

		<article class="box article-panel">
			<h3>영화 순위</h3>
			
			<table id="movie-rank">
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


<script src="${context }/js/movieStat/movieStat.js"></script>
<script type="text/javascript">

$(function(){
	movieStatController.root = '${root}';
	movieStatController.context = '${context}';
	movieStatController.signedInUserName = '${user.name}';
	
	movieStatController.loadMovieViewCount();
	movieStatController.loadPopularMovieList();
	movieStatController.loadFavoriteMovieCategoryList(1);
	
	
});

</script>