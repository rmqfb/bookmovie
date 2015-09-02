var bookStatController = {};


/*********************************************************
 * 클래스 변수 설정
 *********************************************************/
 
bookStatController.root = '';
bookStatController.context = '';
bookStatController.signedInUserName = '';


























/*********************************************************
 * 클래스 메서드 설정
 *********************************************************/

bookStatController.loadBookReadCount = function(){
	
	$.getJSON( bookStatController.root + '/book/stat/book-read-count', function(data){
		
		var chartCategories = [];
		var chartData = [];
		
		var chartAllData = {};
		chartAllData.name = '전체 유저';
		chartAllData.data = [];
		
		var chartUserData = {};
		chartUserData.name = bookStatController.signedInUserName + '님';
		chartUserData.data = [];
		
		$.each(data.listByAll, function(){
			chartCategories.push(this.statDate);
			chartAllData.data.push(parseInt(this.readCnt));
		});
		
		$.each(data.listByUser, function(){
			chartUserData.data.push(parseInt(this.readCnt));
		});
		
		chartData.push(chartUserData);
		chartData.push(chartAllData);
		
		$('#book-read-cnt-chart').highcharts({
	        title: {
	            text: bookStatController.signedInUserName + '님의 최근 독서량',
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
	                text: '독서량'
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
	        series : chartData
	    });
	});
};

bookStatController.loadBestSellerList = function(){
	$.getJSON( bookStatController.root + '/book/stat/best-seller-list', function(data){
		var $tbody = $('#best-sellers tbody');
		$tbody.empty();
		
		var html = '';
		
		$.each(data, function(){
			
			html += '<tr>';
			
			html += '<td>';
			html += '<p class="rank">' + this.rank + '</p>';
			html += '</td>';
			
			html += '<td>'; 
			html += '<p class="book-title">' + this.bookTitle + '</p>';
			html += '<p class="book-info">';
			html += '<span class="publisher">' + this.publisher + '</span>';
			html += ' / ';
			html += '<span class="author">' + this.author + '</span>';
			html += '<span class="category">' + this.bookBigCat + ' &gt; ' + this.bookMediumCat + ' &gt; ' + this.bookSmallCat + '</span>';
			html += '</p>';
			html += '</td>'; 
			
			html += '<td>';
			html += '<p class="rank-info">';
			html += '<span class="title">리뷰 수 : </span>';
			html += '<span class="value">' + this.numOfReviewParticipants + '</span>';
			html += ' / ';
			html += '<span class="title">평균 평점 : </span>';
			html += '<span class="value">' +  this.bookAvgPoint + '</span>';
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
		
		$('#best-sellers tbody tr').hover(function(){
			$(this).find('.book-title').addClass('hovered');
		},function(){
			$(this).find('.book-title').removeClass('hovered');
		});
	});
};

bookStatController.loadUserFavoriteBookCategoryList = function(pageNo){
	
	$.getJSON( bookStatController.root + '/book/stat/favorite-book-categories/' + pageNo, function(data){
		var $ul = $('ul#favorite-book-categories');
		$ul.empty();
		
		var html = '';
		
		$.each(data, function(){
			html += '<li data-book-category="' + this.bookSmallCat + '">' + this.bookSmallCat + '(' + this.readCnt + ')</li>';
		});
		
		$ul.append(html);
		$ul.children().first().addClass('selectedCategoryItem');
		
		bookStatController.viewBooksByCategory(pageNo);
		
		$('ul#favorite-book-categories li').each(function(){
			$(this).click(function(){
				$('ul#favorite-book-categories li').not(this).each(function(){
					$(this).removeClass('selectedCategoryItem');
				});
				
				$(this).addClass('selectedCategoryItem');
				bookStatController.viewBooksByCategory(1);
			});
		});
		
	});
};

bookStatController.viewBooksByCategory = function(pageNo){
	
	var $tableBody = $('#book-rank tbody');
	$tableBody.empty();
	
	$.getJSON( bookStatController.root + '/book/stat/book-rank-by-category/' + $('ul#favorite-book-categories li.selectedCategoryItem').attr('data-book-category') + '/' + pageNo, function(data){
		var html = '';
		
		$.each(data.bookRankByCategoryListByUser, function(idx){
			var dataRankRatio = bookStatController.getDataRankRatio(this.bookGradePoint);
			
			if(this.rank == 1)
				dataRankRatio = 'top';
			
			html += '<tr data-rank="' + this.rank + '" data-rank-ratio="' + dataRankRatio + '">';
			html += '<td>';
			html += '<ul class="rank-panel">';
			html += '<li>' + this.rank + '</li>';
			html += '<li> 평점 : ' + this.bookGradePoint + '</li>';
			html += '</ul>';
			html += '</td>';
			html += '<td class="book-info">';
			html += '<p class="book-title">' + this.bookTitle + '</p>';
			html += '<span class="additional-info">' + this.publisher + ' | ' + this.author + '</span>';
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
		
		var pageSize = 5; 
		var rowPerPage = 5; 
		var rowCount = data.size;
		var pageCount = Math.floor(rowCount / rowPerPage) + (rowCount % pageSize == 0 ? 0 : 1);
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
			$('#pagination').append('<li><a href="#book-rank" class="button" onclick="bookStatController.viewBooksByCategory(' + startPage-pageSize + ')")">&lt;</a></li>');
		}
		for (var i = startPage; i <= endPage; i++) {
			$('#pagination').append('<li><a href="#book-rank" class="button" onclick="bookStatController.viewBooksByCategory('+i+')">'+i+'</a></li>');
		}
		if(endPage < pageCount){
			$('#pagination').append('<li><a href="#book-rank" class="button" onclick="bookStatController.viewBooksByCategory('+(startPage+pageSize)+')">&gt;</a></li>');
		}
		
		$('#stat-content table#book-rank td.book-info').hover(function(){
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

bookStatController.getDataRankRatio = function(bookGradePoint){
	
	if(bookGradePoint >= 7)
		return 'high';
	else if(bookGradePoint >= 5)
		return "middle";
	else
		return "low";
};


bookStatController.loadControllableStatTypes = function(){
	$.getJSON( bookStatController.root + '/book/stat/admin/get-stat-types', function(data){
		$.each(data, function(index){
			var statTypeCode = this.statTypeCode;
			var statTypeName = this.statTypeName;
			$('#stat-type').append('<option value="' + statTypeCode + '">' + statTypeName + '</option>');
		});
	});
};

bookStatController.createStatTriggerButton = function(){
	
	$('#createStatTrigger').keydown(function(e){
		if(e.keyCode == 13){
			var statTypeCode = $('#create-stat-panel #stat-type').val();
			bookStatController.createStat(statTypeCode);
		}
	});
	
	$('#createStatTrigger').click(function(){
		var statTypeCode = $('#create-stat-panel #stat-type').val();
		bookStatController.createStat(statTypeCode);
	});
};

bookStatController.createStat = function(statTypeCode){
	
	$.ajax({
		url : bookStatController.root + '/book/stat/admin/create/user-stat',
		type : 'POST',
		dataType : 'json',
		data : {'statTypeCode' : statTypeCode},
		success : function(data){
			if(data == 1){
				bookStatController.resultMsgOfCreatingStat('통계 데이터를 정상적으로 생성하였습니다.', '#9FC93C');
			}else if(data == -1){
				bookStatController.resultMsgOfCreatingStat('통계 데이터 생성에 실패하였습니다.', '#FF0000');
			}else{
				bookStatController.resultMsgOfCreatingStat('추출할 통계 데이터가 없습니다.', '#FF0000');
			}
		},
		error : function(xhr, msg, errThrown){
			alert('error msg : ' + msg + ', errThrown : ' + errThrown);
		}
	}); 
};


bookStatController.searchUserStatTriggerButton = function(){
	
	$('#searchUserStat').keydown(function(e){
		
		if(e.keyCode == 13){
			var userId = $('#searchUserStat').val();
			
			if(userId == '')
				return;
			
			bookStatController.searchUserStat(userId);
		}
	});
	
	$('#searchUserStatTrigger').click(function(){
		var userId = $('#searchUserStat').val();
		
		if(userId == '')
			return;
		
		bookStatController.searchUserStat(userId);
	});
};

bookStatController.searchUserStat = function(userId){
	$.getJSON( bookStatController.root + '/book/stat/admin/user-stat/' + userId, function(data){
		
		$userStatPanel = $('#user-stat-detail');
		$userStatPanel.hide();
		
		$favoriteBookCategoriesPanel = $('#favorite-book-categories');
		$readCntStatPanel = $('#read-stat');
		
		$favoriteBookCategoriesPanel.empty();
		$readCntStatPanel.empty();
		$('#brief').empty();
		$('table#favorite-books tbody').empty();
		
		var favoriteCategoryList = data.favoriteCategoryList;
		
		if(favoriteCategoryList.length == 0){
			bookStatController.alertFailedSearchingUserStat(userId + '님의 통계를 가져올 수 없습니다 !');
			return;
		}
		
		$.each(favoriteCategoryList, function(idx){
			$favoriteBookCategoriesPanel.append('<li data-book-category="' + this.bookSmallCat + '">' + this.bookSmallCat + '(' + this.readCnt + ')</li>');
		});
		
		$('ul#favorite-book-categories li:first').addClass('selectedCategoryItem');
		
		
		var bookReadCntByMonth = data.bookReadCntByMonth;
		$.each(bookReadCntByMonth, function(idx){
			$readCntStatPanel.append('<li>' + this.statDate + '<span>' + this.readCnt + '회</span></li>');
		});
		
		$('#brief').text(userId + '님의 도서 관련 통계입니다.');
		
		bookStatController.loadBookRankByCategoryOfUser(userId);
		
		bookStatController.initFavoriteBookCategoryListItem(userId);
		
		$userStatPanel.slideDown();
	});
};

bookStatController.loadBookRankByCategoryOfUser = function(userId){
	
	$.getJSON( bookStatController.root + '/book/stat/admin/book-rank-by-category/' + userId + '/' + $('ul#favorite-book-categories li.selectedCategoryItem').attr('data-book-category'), function(data){
		$tableBody = $('table#favorite-books tbody');
		$tableBody.empty();	
		
		var html = '';
		var gradePanel = '';
		
		$.each(data, function(idx){
			html += '<tr data-book-serial-no="' + this.bookSerialNo + '">';
			html += '<td>' + this.bookTitle + '</td>';
			html += '<td>' + this.publisher + '</td>';
			html += '<td>' + this.author + '</td>';
			html += '</tr>';
			
			gradePanel += '<div id="book' + this.bookSerialNo + '" class="point-panel">';
			gradePanel += '<p>해당 유저가 평가한 이 책의 평점 : <span>' + this.bookGradePoint + '</span></p>';
			gradePanel += '<p>이 책의 평균 평점 : <span>' + this.bookAvgPoint + '</span></p>';
			gradePanel += '</div>';
		});
	
		$tableBody.append(html);
		$('#stat-content').append(gradePanel);
		
		$('table#favorite-books tbody tr:odd').addClass('odd-line');
		$('table#favorite-books tbody tr:even').addClass('even-line');
		$('#favorite-books tbody tr').hover(function(){
			$(this).addClass('hovered-line');
		},function(){
			$(this).removeClass('hovered-line');
		});
		
		
		$('#user-stat-detail #favorite-books tbody tr').hover(function(e){
			var $bookGradePanel = $( '#book' + $(this).attr('data-book-serial-no'));
			$bookGradePanel.show();
			$bookGradePanel.css({
				'left':e.clientX,
				'top':$(this).position().top + $(this).height() + 'px'
			});
		},function(){
			var $bookGradePanel = $( '#book' + $(this).attr('data-book-serial-no'));
			$bookGradePanel.hide();
		}); 
		

		$('#user-stat-detail #favorite-books tbody tr').hover(function(e){
			var $bookGradePanel = $( '#book' + $(this).attr('data-book-serial-no'));
			$bookGradePanel.show();
			$bookGradePanel.css({
				'left':e.clientX,
				'top':$(this).position().top + $(this).height() + 'px'
			});
		},function(){
			var $bookGradePanel = $( '#book' + $(this).attr('data-book-serial-no'));
			$bookGradePanel.hide();
		}); 
	});
};

bookStatController.initFavoriteBookCategoryListItem = function(userId){
	$('ul#favorite-book-categories li').each(function(){
		$(this).click(function(){
			$('ul#favorite-book-categories li').not(this).removeClass('selectedCategoryItem');
			$(this).addClass('selectedCategoryItem');
			bookStatController.loadBookRankByCategoryOfUser(userId);
		});
	});
};


bookStatController.resultMsgOfCreatingStat = function(msg, color){
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

bookStatController.alertFailedSearchingUserStat = function(msg){
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






