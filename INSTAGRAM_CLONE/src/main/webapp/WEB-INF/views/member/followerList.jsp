<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../form/header.jsp"%>
<!-- Wrapper -->
<di   v id="wrapper">
   <!-- Main -->
   <div id="main">
      <div class="inner">
         <!-- START :: header -->
         <%@ include file="../form/headercontents.jsp"%>
         <h3 style="margin-left: 40%;">팔로워 리스트</h3>
         <div class="div">

            <c:forEach var="list" items="${followerList }">
               <img id="profile_image" class="img"
                  src="<c:choose>
                               <c:when test="${not empty list.member_img_server_name}">
                                  /resources/images/profileupload/${list.member_img_server_name }
                               </c:when>
                               <c:otherwise>
                                  /resources/images/profile/add.png
                               </c:otherwise>
                            </c:choose>">
                  &nbsp;
               <span class="id"><a style="vertical-align: top;"
                  href="/member/headerSearch?search=${list.member_id }">${list.member_id }</a></span>
               <br>
            </c:forEach>
         </div>
      </div>
   </div>
   <%@ include file="../form/sidebar.jsp"%>
</div>

<!-- Scripts -->
<script src="/resources/js/jquery.min.js"></script>
<script src="/resources/js/browser.min.js"></script>
<script src="/resources/js/breakpoints.min.js"></script>
<script src="/resources/js/util.js"></script>
<script src="/resources/js/main.js"></script>
<script src="/resources/js/feed.js"></script>
<style type="text/css">
.img {
   border-radius: 100px;
   height: 60px;
   width: 60px;
}

.id {
   font-size: xx-large;
   font-weight: bold;
}

.div {
   width: 300px;
   margin: 0 auto;
}
</style>
</head>
<body>
</body>
</html>