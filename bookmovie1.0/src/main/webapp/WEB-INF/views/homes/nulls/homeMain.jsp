<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<div class="thumb_wrapper newBooks">
    
</div>  

<div class="thumb_wrapper newMovies">
    
</div>  

<div class="thumb_wrapper bestSellers">
    
</div>     


<jsp:include page="sidebar.jsp"></jsp:include>
<script type="text/javascript">


$(function() {
	main.list(1);
    
       $('#bookmain').click(function() {
            alert("로그인 하세요.");    
            
        });
       $('#resmain').click(function() {
        alert("로그인 하세요.");    
        
    });
       $('#statmain').click(function() {
        alert("로그인 하세요.");    
        
    });
       $('#mbmain').click(function() {
        alert("로그인 하세요.");    
        
    });
       $('#mmain').click(function() {
        alert("로그인 하세요.");    
        
    });
       $('#tmain').click(function() {
        alert("로그인 하세요.");    
        
    });
       $('#boardmain').click(function() {
        alert("로그인 하세요.");    
        
    });
});

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


 
</script>