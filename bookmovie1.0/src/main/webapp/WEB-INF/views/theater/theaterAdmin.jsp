<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<%@ taglib prefix='fn' uri='http://java.sun.com/jsp/jstl/functions'%>
<c:set var='root' value='<%=request.getContextPath()%>'></c:set>
<c:set var="context" value="${root}/resources"></c:set>
<style> @IMPORT url("${context}/css/theatercss/common.css"); </style>
<script src='//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'></script>

<div>
<form action="${root}/theaterDate">
<%=request.getParameter("code") %>
     <table class="tableClass">
          <tr class="trClass">
               <td class="tdClass">필   드 </td>
               <td class="tdClass">입력값 </td>
          </tr>
          <tr class="trClass">
               <td class="tdClass2" >상영날짜</td>
               <td class="tdClass2">
                    <input type="text" style="width: 350px" id="age" name="age">
               </td>
          </tr>
         
          <tr class="trClass">
               <td class= "tdClass2">상영관</td>
               <td class= "tdClass2">
                    <input type="text" style="width: 350px" id="theater" name="theater">
               </td>
          </tr>
          <tr class="trClass">
               <td class= "tdClass2">상영시간</td>
               <td class= "tdClass2">
                    <input type="text" style="width: 350px" id="seat" name="seat">
               </td>
          </tr>
     </table>
     <input type="image"  src="{context}/image/theaterimage/click.jpg" width="70">
     </form>
</div>
