/*이거 선언하지않으면 board. 사용이 안된다*/
var board = {
		loaded : false
}
board.load = function(div,url) {
 	   $(div).empty();
 	   $(div).load(url);
 		
 	
 }

