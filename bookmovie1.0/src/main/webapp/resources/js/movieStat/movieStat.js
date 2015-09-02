
var movieStatController = {};



/*********************************************************
 * 클래스 변수 설정
 *********************************************************/


movieStatController.root = '';
movieStatController.context = '';
movieStatController.signedInUserName = '';




/*********************************************************
 * 클래스 메서드 설정
 *********************************************************/



movieStatController.loadMovieViewCount = function(){
	
	$.getJSON( movieStatController.root + '/movie/stat/movie-view-count', function(data){
		
		var chartCategories = [];
		var chartData = [];
		
		var chartAllData = {};
		chartAllData.name = '전체 유저';
		chartAllData.data = [];
		
		var chartUserData = {};
		chartUserData.name = movieStatController.signedInUserName + '님';
		chartUserData.data = [];
		
		$.each(data.listByAll, function(){
			chartCategories.push(this.statDate);
			chartAllData.data.push(parseInt(this.viewCnt));
		});
		
		$.each(data.listByUser, function(){
			chartUserData.data.push(parseInt(this.viewCnt));
		});
		
		chartData.push(chartUserData);
		chartData.push(chartAllData);
		
		$('#movie-view-cnt-chart').highcharts({
	        title: {
	            text: movieStatController.signedInUserName + '님의 영화 상영 횟수',
	            x: -20 //center
	        },
	        subtitle: {
	            text: '현재 달 부터 최대 12개월 전까지 보여줍니다.',
	            x: -20
	        },
	        xAxis: {
	            categories: chartCategories
	        },
	        yAxis: {
	            title: {
	                text: '영화 상영 횟수'
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'middle',
	            borderWidth: 0
	        },
	        series: chartData
	    });
	});
};

movieStatController.loadPopularMovieList = function(){
	
	$.getJSON( movieStatController.root + '/movie/stat/popular-movie-list', function(data){
		var $tbody = $('#popular-movie-list tbody');
		$tbody.empty();
		
		var html = '';
		
		$.each(data, function(){
			
			html += '<tr>';
			
			html += '<td>';
			html += '<p class="rank">' + this.rank + '</p>';
			html += '</td>';
			
			html += '<td>'; 
			html += '<p class="movie-title">' + this.movieTitle + '</p>';
			html += '<p class="movie-info">';
			html += '<span class="genre">[' + this.movieGenre + ']</span>';
			html += '<span class="viewTime">상영 시간 : ' + this.movieViewTime + '</span>';
			html += '</p>';
			html += '</td>'; 
			
			html += '<td>';
			html += '<p class="rank-info">';
			html += '<span class="title">리뷰 수 : </span>';
			html += '<span class="value">' + this.numOfReviewParticipants + '</span>';
			html += ' / ';
			html += '<span class="title">평균 평점 : </span>';
			html += '<span class="value">' +  this.movieAvgPoint + '</span>';
			html += '</p>';
			
			html += '<ul class="review-list">';
			html += '<li>' + this.reviewMsgOfParticipant1 + '</li>';
			html += '<li>' + this.reviewMsgOfParticipant2 + '</li>';
			html += '<li>' + this.reviewMsgOfParticipant3 + '</li>';
			html += '</ul>';
			html += '</td>';
			
			html+= '</tr>';
		});
		
		$tbody.html(html);
		
		$('#popular-movie-list tbody tr').hover(function(){
			$(this).find('.movie-title').addClass('hovered');
		},function(){
			$(this).find('.movie-title').removeClass('hovered');
		});
	});
};

movieStatController.loadFavoriteMovieCategoryList = function(pageNo){
	$.getJSON( movieStatController.root + '/movie/stat/favorite-movie-categories/' + pageNo, function(data){
		var $ul = $('ul#favorite-genre');
		$ul.empty();
		
		var html = '';
		
		$.each(data, function(){
			html += '<li data-genre="' + this.genre + '">' + this.genre + '(' + this.viewCnt + ')</li>';
		});
		
		$ul.append(html);
		$ul.children().first().addClass('selectedCategoryItem');
		
		movieStatController.viewMoviesByGenre(1);
		
		$('ul#favorite-genre li').each(function(){
			$(this).click(function(){
				$('ul#favorite-genre li').not(this).each(function(){
					$(this).removeClass('selectedCategoryItem');
				});
				
				$(this).addClass('selectedCategoryItem');
				movieStatController.viewMoviesByGenre(1);
			});
		});
		
	});
};

movieStatController.viewMoviesByGenre = function(pageNo){
	
	var $tableBody = $('#movie-rank tbody');
	$tableBody.empty();
	
	$.getJSON( movieStatController.root + '/movie/stat/movie-rank-by-category/' + $('ul#favorite-genre li.selectedCategoryItem').attr('data-genre') + '/' + pageNo, function(data){
		var html = '';
		
		$.each(data.movieRankByCategoryListByUser, function(idx){
			var dataRankRatio = movieStatController.getDataRankRatio(this.movieGradePoint);
			
			if(this.rank == 1)
				dataRankRatio = 'top';
			
			html += '<tr data-rank="' + this.rank + '" data-rank-ratio="' + dataRankRatio + '">';
			html += '<td>';
			html += '<ul class="rank-panel">';
			html += '<li>' + this.rank + '</li>';
			html += '<li>평점 : ' + this.movieGradePoint + '</li>';
			html += '</ul>';
			html += '</td>';
			html += '<td class="movie-info">';
			html += '<p class="movie-title">' + this.movieTitle + '</p>';
			html += '<p class="review-text">' + this.brdContent + '</p>';
			html += '</td>';
			html += '</tr>';
		});
		
		$tableBody.append(html);
		
		$('tr[data-rank-ratio="top"] .rank-panel li:eq(0)').addClass('top-ratio');
		
		$('tr[data-rank-ratio="high"]').each(function(){
			$(this).find('.rank-panel li:eq(0)').addClass('high-ratio');
		});
		
		$('tr[data-rank-ratio="middle"]').each(function(){
			$(this).find('.rank-panel li:eq(0)').addClass('middle-ratio');
		});
		
		$('tr[data-rank-ratio="low"]').each(function(){
			$(this).find('.rank-panel li:eq(0)').addClass('low-ratio');
		});
		
		var pageSize = 5; /* 페이지 블록이 5 */
		var rowPerPage = 5; /* 한 페이지당 로우 갯수 */
		var rowCount = data.size;
		var pageCount = Math.floor(rowCount / rowPerPage) + (rowCount % pageSize == 0 ? 0 : 1);
		/* Math.floor 는 소수점 이하는 무조건 생략    >> 자바스크립트에서는 소수점까지 값을 갖고오기때문에 Math.floor 를 사용함
		   Math.ceil 는 소수점 이하는 무조건 올림 */
		var currentPage = data.currentPage;
		var nmg = currentPage % pageSize;
		var startPage = 0;
		if(nmg != 0){
			startPage = currentPage - nmg + 1;
		}else{
			startPage = currentPage - (pageSize-1);
		}
		var endPage = startPage + pageSize - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		$('#pagination').empty();
		
		if (startPage > pageSize) {
			$('#pagination').append('<li><a href="#" class="button" onclick="movieStatController.viewMoviesByGenre(' + startPage-pageSize + ')")">&lt;</a></li>');
		}
		for (var i = startPage; i <= endPage; i++) {
			$('#pagination').append('<li><a href="#" class="button" onclick="movieStatController.viewMoviesByGenre('+i+')">'+i+'</a></li>');
		}
		if(endPage < pageCount){
			$('#pagination').append('<li><a href="#" class="button" onclick="movieStatController.viewMoviesByGenre('+(startPage+pageSize)+')">&gt;</a></li>');
		}
		
		$('#stat-content table#movie-rank td.movie-info').hover(function(){
			$(this).css('background-color', '#EAEAEA');
			$(this).find('.review-text').css({
				'color' : '#9FC93C',
				'font-weight' : 'bold'
			});
		}, function(){
			$(this).css('background-color', '#FFF');
			$(this).find('.review-text').css({
				'color' : '#BDBDBD',
				'font-weight' : 'normal'
			});
		});
	});
};

movieStatController.getDataRankRatio = function(movieGradePoint){
	
	if(movieGradePoint >= 7)
		return 'high';
	else if(movieGradePoint >= 5)
		return "middle";
	else
		return "low";
};

movieStatController.loadControllableStatTypes = function(){
	$.getJSON( movieStatController.root + '/movie/stat/admin/get-stat-types', function(data){
		$.each(data, function(index){
			var statTypeCode = this.statTypeCode;
			var statTypeName = this.statTypeName;
			
			$('#stat-type').append('<option value="' + statTypeCode + '">' + statTypeName + '</option>');
		});
	});
};

movieStatController.createStatTriggerButton = function(){
	
	$('#createStatTrigger').keydown(function(e){
		if(e.keyCode == 13){
			var statTypeCode = $('#create-stat-panel #stat-type').val();
			movieStatController.createStat(statTypeCode);
		}
	});
	
	$('#createStatTrigger').click(function(){
		var statTypeCode = $('#create-stat-panel #stat-type').val();
		movieStatController.createStat(statTypeCode);
	});
};

movieStatController.createStat = function(statTypeCode){
	$.ajax({
		url : movieStatController.root + '/movie/stat/admin/create/user-stat',
		type : 'POST',
		dataType : 'json',
		data : {'statTypeCode' : statTypeCode},
		success : function(data){
			
			if(data == 1){
				movieStatController.resultMsgOfCreatingStat('통계 데이터를 정상적으로 생성하였습니다.', '#9FC93C');
			}else if(data == -1){
				movieStatController.resultMsgOfCreatingStat('통계 데이터 생성에 실패하였습니다.', '#FF0000');
			}else{
				movieStatController.resultMsgOfCreatingStat('추출할 통계 데이터가 없습니다.', '#FF0000');
			}
		},
		error : function(xhr, msg, errThrown){
			alert('error msg : ' + msg + ', errThrown : ' + errThrown);
		}
	}); 
};

movieStatController.searchUserStatTriggerButton = function(){

	$('#searchUserStat').keydown(function(e){
		if(e.keyCode == 13){
			var userId = $('#searchUserStat').val();
			
			if(userId == '')
				return;
			
			movieStatController.searchUserStat(userId);
		}
	});
	
	$('#searchUserStatTrigger').click(function(){
		var userId = $('#searchUserStat').val();

		if(userId == '')
			return;
		
		movieStatController.searchUserStat(userId);
	});
};

movieStatController.searchUserStat = function(userId){
	$.getJSON( movieStatController.root + '/movie/stat/admin/user-stat/' + userId, function(data){
		
		$userStatPanel = $('#user-stat-detail');
		$userStatPanel.hide();
		
		$favoriteMovieCategoriesPanel = $('#favorite-genre');
		$readCntStatPanel = $('#read-stat');
		
		$favoriteMovieCategoriesPanel.empty();
		$readCntStatPanel.empty();
		$('#brief').empty();
		$('table#favorite-movies tbody').empty();
		
		var favoriteCategoryList = data.favoriteCategoryList;
		
		if(favoriteCategoryList.length == 0){
			movieStatController.alertFailedSearchingUserStat(userId + '님의 통계를 가져올 수 없습니다 !');
			return;
		}
		
		$.each(favoriteCategoryList, function(idx){
			$favoriteMovieCategoriesPanel.append('<li data-genre="' + this.genre + '">' + this.genre + '(' + this.viewCnt + ')</li>');
		});
		
		
		
		$('#favorite-genre li:first').addClass('selectedCategoryItem');
		
		
		
		var movieReadCntByMonth = data.movieReadCntByMonth;
		
		$.each(movieReadCntByMonth, function(idx){
			$readCntStatPanel.append('<li>' + this.statDate + '<span>' + this.viewCnt + '회</span></li>');
		});
		
		$('#brief').text(userId + '님의 도서 관련 통계입니다.');
		
		movieStatController.initMovieGenreList();
		
		var movieGenre = $('ul#favorite-genre li.selectedCategoryItem').attr('data-genre');
		movieStatController.loadMovieListByCategory(userId, movieGenre);
		
		$userStatPanel.slideDown();
	});
	
};

movieStatController.initMovieGenreList = function(){
	
	$('ul#favorite-genre li').each(function(){
		$(this).click(function(){
			
			$('ul#favorite-genre li').not(this).removeClass('selectedCategoryItem');
			$(this).addClass('selectedCategoryItem');
			
			var userId = $('#searchUserStat').val();
			var movieGenre = $('#favorite-genre li.selectedCategoryItem').attr('data-genre');
			
			movieStatController.loadMovieListByCategory(userId, movieGenre);
		});
	});
	
};

movieStatController.loadMovieListByCategory = function(userId, movieGenre){
	$.getJSON( movieStatController.root + '/movie/stat/admin/movie-rank-by-category/' + userId + '/' + movieGenre, function(data){
		$tableBody = $('table#favorite-movies tbody');
		$tableBody.empty();	
		
		var html = '';
		var gradePanel = '';
		
		$.each(data, function(idx){
			
			html += '<tr data-movie-code="' + this.movieCode + '">';
			html += '<td>' + this.movieTitle + '</td>';
			html += '<td>상영 시간 : ' + this.movieViewTime + '</td>';
			html += '</tr>';
			
			gradePanel += '<div id="movie' + this.movieCode + '" class="point-panel">';
			gradePanel += '<p>내가 매긴 이 책의 평점 : <span>' + this.movieGradePoint + '</span></p>';
			gradePanel += '<p>이 책의 평균 평점 : <span>' + this.movieAvgPoint + '</span></p>';
			gradePanel += '</div>';
		});
	
		$tableBody.append(html);
		$('#stat-content').append(gradePanel);
		
		$('table#favorite-movies tbody tr:odd').addClass('odd-line');
		$('table#favorite-movies tbody tr:even').addClass('even-line');
		$('#favorite-movies tbody tr').hover(function(){
			$(this).addClass('hovered-line');
		},function(){
			$(this).removeClass('hovered-line');
		});
		
		$('#user-stat-detail #favorite-books tbody tr').hover(function(e){
			var $movieGradePanel = $( '#movie' + $(this).attr('data-movie-code'));
			$movieGradePanel.show();
			$movieGradePanel.css({
				'left':e.clientX,
				'top':$(this).position().top + $(this).height() + 'px'
			});
		},function(){
			var $movieGradePanel = $( '#movie' + $(this).attr('data-movie-code'));
			$movieGradePanel.hide();
		}); 
	});
};

movieStatController.resultMsgOfCreatingStat = function(msg, color){
	$resultPanel = $('#create-stat-panel .result-msg');
	$resultPanel.text('');
	$resultPanel.css({
		'color' : 'orange',
		'font-weight' : 'bold'
	});
	$resultPanel.text(msg);
	$resultPanel.animate({
		'color': color,
		'font-weight' : 'normal'
	}, 200);
};

movieStatController.alertFailedSearchingUserStat = function(msg){
	$alert = $('#alert');
	$alert.text('');
	
	$alert.css({
		'color':'#FF0000',
		'font-weight':'bold',
	});
	
	$alert.text(msg);	
	
	$alert.animate({
		'color':'#CC3D3D',
	}, 600);
};
