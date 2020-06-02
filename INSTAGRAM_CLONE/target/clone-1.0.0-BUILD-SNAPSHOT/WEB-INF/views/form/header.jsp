<%@ page import="org.apache.catalina.SessionListener"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Devs</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />

<!-- bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<!-- end bootstrap --!>

<!-- START :: css -->
<link rel="stylesheet" href="/resources/css/main.css" />
<!-- END :: css -->

<!-- START :: set JSTL variable -->
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
   
   <c:set var="sessionLoginMember" value="${sessionScope.user}"></c:set>
   <c:set var="sessionLoginMemberProfile" value="${sessionScope.profile}"></c:set>
   <c:set var="SERVER_PORT" value="${sessionScope.SERVER_PORT}"></c:set>
<!-- END :: set JSTL variable -->

<!-- START :: JAVASCRIPT -->
   <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
   <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
   <script type="text/javascript" src="../resources/js/autocomplete/searchAutoComplete.js"></script>
   <script type="text/javascript" src="../resources/js/dm/dm.js"></script>
   <script type="text/javascript" src="../resources/js/dm/alarm.js"></script>
   <script type="text/javascript">
      function notifyProfileImgChange(changedImg){
         $("#header_profile_image").attr("src","/resources/images/profileupload/" + changedImg);
      }
      var SERVER_PORT = ${SERVER_PORT};
   </script>
<script type="text/javascript">
   // jquery-ui 가 load 되면 autocomplete 실행
   $.getScript("https://code.jquery.com/ui/1.12.1/jquery-ui.js", function(){
   	$.getScript("../resources/js/autocomplete/searchAutoComplete.js", function(){
      searchAutoComplete();
      })   
   })
         // 소켓 객체를 담을 변수
      var ws; 
      var alarm;
      $(function (){
           console.log("헤더 소켓 메시지 준비중...")
            
           // 소켓으로부터 메시지 도착 시 
           alarm.onopen=function(e){
               
              alarm.onmessage=function(event){
                 console.log("헤더에 메시지 도착!!")
                  var data = JSON.parse(event.data);
                  
                  // 채팅 메시지 도착시 header 의 채팅 아이콘 옆에 표시
                    if (data.chat != undefined){
                       console.log("헤더에도 채팅 도착!!")
                       addChatArrived();
                       
                       setTimeout(function() {
                          removeChatArrived();
                       }, 2000);
                  }
                  
              };
            }
      })
      
      function addChatArrived() {
         var circleIcon = $("<i>").attr({"class":"arrive fa fa-circle", "style":"color: red; font-size: 8pt;"});
         $(".chatting").append(circleIcon);
      }
      
      function removeChatArrived(){
         $(".arrive").remove();
      }
</script>
<!-- END :: JAVASCRIPT -->

</head>
<body class="is-preload">

	<!-- Wrapper -->
<!-- 	<div id="wrapper"> -->
<!--       Main -->
<!-- 		<div id="main"> -->
<!-- 			<div class="inner"> -->
            
            
<!-- 		         <header id="header"> -->
<!-- 		            <a class="logo" href="/feed/feed"><strong style="color:#9400d3;"> Devs</strong></a>             -->
		   
		                      
		            
<!-- 		            nav list                   -->
<!-- 		            <ul class="icons"> -->
		
<!-- 		               <li><a class="icon solid fa-home" href="/feed/"><span class="label"></span></a></li> -->
<!-- 		               <li><a class="icon solid fa-paper-plane" href="/dm/"><span class="label"></span></a></li> -->
<!-- 		               <li><a class="icon solid fa-compass" href="/feed/randomFeed"><span class="label"></span></a></li> -->
<!-- 		               <li><a class="icon solid fa-heart" href="/feed/likeFeed"><span class="label"></span></a></li> -->
		               
<!-- 		               <li><a href="/member/profile"> -->
<%-- 		                     <c:choose> --%>
<%-- 		                        <c:when test="${not empty sessionLoginMemberProfile.member_img_server_name}"> --%>
<!-- 		                           <span class="label">                               -->
<!-- 		                              <img  -->
<!-- 		                                 id="header_profile_image"  -->
<!-- 		                                 style="width:20px; height:20px; border-radius:100%;"  -->
<%-- 		                                 src="/resources/images/profileupload/${sessionLoginMemberProfile.member_img_server_name }" --%>
<!-- 		                              > -->
<!-- 		                           </span> -->
<%-- 		                        </c:when> --%>
<%-- 		                        <c:otherwise> --%>
<!-- 		                           <i class="icon solid fa-user"></i> -->
<%-- 		                        </c:otherwise> --%>
<%-- 		                     </c:choose> --%>
		                  
<!-- 		                     </a> -->
<!-- 		               </li> -->
		               
<!-- 		               <li><a class="icon solid fa-sign-out-alt" href="/ssoclient/logout"><span class="label"></span></a></li> -->
		               
<!-- 		             </ul> -->
<!-- 		         </header>  -->
		         
<!-- 	         Content -->
<!-- 				<section> -->
<!-- 					<header class="main"> -->
<!-- 						<h2></h2> -->
<!-- 						<h2 style="color:#9400d3"></h2> -->
<!-- 					</header> -->

<!-- 					<span class="image main"><img src="/resources/images/" alt="" /></span> -->

					
<!-- 					hr
<!-- 					<hr class="major" />  -->

					

<!-- 				</section> -->
				
<!--         	</div> -->
        	
        	
        	
<!-- 		</div> -->

<!--  -->
			<!-- START :: HEADER FORM -->
<%-- 			<%@ include file="../form/sidebar.jsp"%> --%>
			<!-- END :: HEADER FORM -->
			
			
		<!-- Sidebar -->
<!-- 		<div id="sidebar"> -->
<!-- 			<div class="inner"> -->

<!-- 				Search -->
<!-- 					<section id="search" class="alt"> -->
<!-- 			            <form id="headerSearch" action="/member/headerSearch" method="post"> -->
<%-- 			                  <input id="search" class="form-control bg-light" type="text" name="search" value="${search}" placeholder="검색"> --%>
<!-- 			             </form>   -->
<!-- 					</section> -->

<!-- 				Menu -->
<!-- 					<nav id="menu"> -->
<!-- 						<header class="major"> -->
<!-- 							<h2>Menu</h2> -->
<!-- 						</header> -->
<!-- 						<ul> -->
<!-- 							<li><a href="#">Private CH.</a></li> -->
<!-- 							<li><a href="#">Collabo Ch.</a></li> -->
<!-- 							<li><a href="#">About Devs</a></li> -->
<!-- 							<li> -->
<!-- 								<span class="opener">Contact</span> -->
<!-- 								<ul> -->
<!-- 									<li><a href="#">Phone</a></li> -->
<!-- 									<li><a href="#">SNS</a></li> -->
									
<!-- 								</ul> -->
<!-- 							</li> -->
							

<!-- 						</ul> -->
<!-- 					</nav> -->

				

<!-- 				Section -->
<!-- 					<section> -->
<!-- 						<header class="major"> -->
<!-- 							<h2>Contact</h2> -->
<!-- 						</header> -->
<!-- 						<p></p> -->
<!-- 						<ul class="contact"> -->
<!-- 							<li class="icon solid fa-envelope">information@untitled.com</li> -->
<!-- 							<li class="icon solid fa-phone">(000) 000-0000</li> -->
<!-- 							<li class="icon solid fa-home">서울시 강남구 역삼동 -->
<!-- 							</li> -->
<!-- 						</ul> -->
<!-- 					</section> -->

<!-- 				Footer -->
<!-- 					<footer id="footer"> -->
<!-- 						<p class="copyright">&copy; Untitled. All rights reserved. <br>&nbsp &nbsp  Design: <b style="color: #9400d3;">Devs</b></p> -->
<!-- 					</footer> -->

<!-- 			</div> -->
<!-- 		</div> -->
		
		

<!--      </div> -->
     <!-- Scripts -->
			<script src="/resources/js/jquery.min.js"></script>
			<script src="/resources/js/browser.min.js"></script>
			<script src="/resources/js/breakpoints.min.js"></script>
			<script src="/resources/js/util.js"></script>
			<script src="/resources/js/main.js"></script>
     
</body>


</html>