<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="root" value="<%=request.getContextPath() %>"></c:set>
<c:set var="context" value="${root }/resources"></c:set>

<div class="thumb_wrapper newBooks">
    
</div>  

<div class="thumb_wrapper newMovies">
    
</div>  

<div class="thumb_wrapper bestSellers">
    
</div>    

<div class="thumb_wrapper bestBooks">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 

<div class="thumb_wrapper booksByCat">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 

<div class="thumb_wrapper booksByCat">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 

<div class="thumb_wrapper booksByCat">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 

<div class="thumb_wrapper bestMovies">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 

<div class="thumb_wrapper moviesByGenre">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 

<div class="thumb_wrapper moviesByGenre">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 

<div class="thumb_wrapper moviesByGenre">
    <div class="thumb">
        <a class="thumbb" href="http://www.jssor.com/demos/full-width-slider.html">
            <div class="thumbi">
                <img src="http://www.jssor.com/img/demo/t-full-width-slider.jpg" alt="">
            </div>
            <div class="thumbc">Full Width Slider</div>
        </a>
    </div>
</div> 



<script type="text/javascript">

main ={}

main.list = function(pageNo) {
	
	$.getJSON('${root}/b-review/list/'+pageNo, function(data) {
		main.blistForm(data);
		
	});
	$.getJSON('${root}/movie/list/'+pageNo,function(data){
		main.mlistForm(data);
	});
	$.getJSON('${root}/book/stat/best-seller-list/',function(data){
		main.bflistForm(data);
	});
	
}


main.blistForm = function(data) {
	$('.newBooks').empty();
	
    //var size = data.list.length; 
    var div = '<h1> 가장최신목록 책</h1>'; 
	$.each(data.list,function(i){
		if(i<=2){
	    div += '<div class="thumb">';
		div += '<a class="thumbb"href="#">';
		div += '<div class="thumbi">';
		div += '<img src="${context}/bookImg/'+this.imgAddr+'" style="width: 104px; height:150px;"/>';
		div += '</div>';
		div += '<div class="thumbc">'+this.bTitle+'</div>';
		div += '</a>';
		div += '</div>';
		/* div += '</tr>'; */
		}
		
		});
	$('.newBooks').html(div);
	
}
main.mlistForm = function(data) {
	$('.newMovies').append();
	
	var div = '<h1> 가장최신목록 영화 </h1>'; 
	$.each(data.list,function(i){
		if(i<=2){
	    div += '<div class="thumb">';
		div += '<a class="thumbb"href="#">';
		div += '<div class="thumbi">';
		div += '<img src=" ${context}/image/movieimage/'+this.poster+'" style="width: 104px; height:150px;"/>';
		div += '</div>';
		div += '<div class="thumbc">'+this.title+'</div>';
		div += '</a>';
		div += '</div>';
		}
	});
	$('.newMovies').append(div);
	
}

main.bflistForm = function(data) {
	$('.bestSellers').append();
	 var div = '<h1> 가장인기있는 책</h1>'; 
	$.each(data,function(i){
		if(i<=2){
	    div += '<div class="thumb">';
		div += '<a class="thumbb"href="#">';
		div += '<div class="thumbi">';
		div += '<img src="${context}/bookImg/'+this.bookImgAddr+'" style="width: 104px; height:150px;"/>';
		div += '</div>';
		div += '<div class="thumbc">'+(i+1)+'위 '+this.bookTitle+'</div>';
		div += '</a>';
		div += '</div>';
		/* div += '</tr>'; */
		}
	});
	$('.bestSellers').append(div);
	
}

var homeController = {};

$(function(){
	main.list(1);
	
	homeController.loadFavoriteBooks();
	homeController.loadNewBooksInFavoriteCategories();
	homeController.loadFavoriteMovies();
	homeController.loadNewMoviesInFavoriteGenres();
	
});


homeController.loadFavoriteBooks = function(){
	var userName = '${user.name}';
	
	$.getJSON('${root}/book/stat/favorite-books', function(data){
		
		var $bestBooksPanel = $('.bestBooks');
		$bestBooksPanel.empty();
		
		var html = '';
		
		html += '<h1>' + userName + '님이 가장 좋아하는 책들</h1>';
		
		$.each(data, function(){
			
			html += '<div class="thumb">';
			html += '<a class="thumbb" href="#">';
			html += '<div class="thumbi">';
			html += '<img src="${context}/bookImg/' + this.bookImgAddr + '" alt="" width="300">';
			html += '</div>';
			html += '<div class="thumbc">' + this.bookTitle + '</div>';
			html += '</a>';
			html += '</div>';
			
		});
		
		$bestBooksPanel.html(html);
	});
};

homeController.loadNewBooksInFavoriteCategories = function(){
	
	$.getJSON('${root}/book/stat/new-books-in-favorite-categories', function(data){
		
		$('.booksByCat').each(function(){
			$(this).empty();
		});
		
		$.each(data.categories,function(i){
			$('.booksByCat:eq(' + i + ')').append('<h2>도서 카테고리 - ' + this.bookSmallCat + '</h2>')
			.attr('data-book-category', this.bookSmallCat);
		});
		
		var html = '';
		
		$.each(data.bookList, function(){

			html = '';
			
			html += '<div class="thumb">';
			html += '<a class="thumbb" href="#">';
			html += '<div class="thumbi">';
			html += '<img src="${context}/bookImg/' + this.bookImgAddr + '" alt="" width="300">';
			html += '</div>';
			html += '<div class="thumbc">' + this.bookTitle + '</div>';
			html += '</a>';
			html += '</div>';
			
			$('.booksByCat[data-book-category="' + this.bookSmallCat +'"]').append(html);
		});
	});
};


homeController.loadFavoriteMovies = function(){
	
	var userName = '${user.name}';
	
	$.getJSON('${root}/movie/stat/favorite-movies', function(data){
		
		var $bestMoviesPanel = $('.bestMovies');
		$bestMoviesPanel.empty();
		
		var html = '';
		
		html += '<h1>' + userName + '님이 가장 좋아하는 영화들</h1>';
		
		$.each(data, function(){
			
			html += '<div class="thumb">';
			html += '<a class="thumbb" href="#">';
			html += '<div class="thumbi">';
			html += '<img src="${context}/image/movieimage/' + this.moviePoster + '" alt="" width="300">';
			html += '</div>';
			html += '<div class="thumbc">' + this.movieTitle + '</div>';
			html += '</a>';
			html += '</div>';
			
		});
		
		$bestMoviesPanel.html(html);
	});
};


homeController.loadNewMoviesInFavoriteGenres = function(){
	
	$.getJSON('${root}/movie/stat/new-movies-in-favorite-genres', function(data){
		
		$('.moviesByGenre').each(function(){
			$(this).empty();
		});
		
		$.each(data.genres,function(i){
			$('.moviesByGenre:eq(' + i + ')').append('<h2>무비 장르 - ' + this.movieGenre + '</h2>')
			.attr('data-movie-genre', this.movieGenre);
		});
		
		var html = '';
		
		$.each(data.movieList, function(){

			html = '';
			
			html += '<div class="thumb">';
			html += '<a class="thumbb" href="#">';
			html += '<div class="thumbi">';
			html += '<img src="${context}/image/movieimage/' + this.moviePoster + '" alt="" width="300">';
			html += '</div>';
			html += '<div class="thumbc">' + this.movieTitle + '</div>';
			html += '</a>';
			html += '</div>';
			
			$('.moviesByGenre[data-movie-genre="' + this.movieGenre +'"]').append(html);
		});
	});
};


</script>


