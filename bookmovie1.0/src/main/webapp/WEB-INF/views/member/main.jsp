<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var='root' value='<%=request.getContextPath()%>'></c:set>
<c:set var="context" value="${root}/resources"></c:set>
<style> @IMPORT url('${context}/css/common.css'); </style>
<script src='//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>

<div class="mainoutbox center">
      <div class="mainbox">
                상영 영화
      
       <ul>
         <% int i= 1;%>
       	<c:forEach var="list" items="${mlist}">
       	 
       	  <li class="mainli">
       	  <img class="mainimg" src="${context}/image/movieImage/${list.poster}"><br /> 
       	  <span>${list.title}</span>
       	  </li>
       	 
       	 <%-- <%if((i%3) == 0){%> <li class="mainli" />  <%} %> 
       	    <%i++;%> --%>
       	</c:forEach>
        </ul>
       
       </div>
       <div class="mainbox">
       
       <iframe width="560" height="315" src="https://www.youtube.com/embed/Sg7eO6mYrc0"  allowfullscreen></iframe>
       
       
       </div>
      
       
        
     
     </div>
       
  
  
  
 <script type="text/javascript">
   $(document).ready(function() {
	  $('.mainimg').mouseover(function() {
		  imgevent.mouseevent()
	   });
   
   
   
   });
   
 var imgevent = {
		 mouseevent : function() {
			 $('.mainimg').css("cursor","pointer");
		   $('img').on({
			  
			  mouseover : function(){
				$('img').css("background-color","")
			}
			   
		   });
		 
		 }
		 
		 
 }
 
 
 </script>