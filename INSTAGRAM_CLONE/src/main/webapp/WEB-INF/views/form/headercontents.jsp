<!-- START :: header -->
<header id="header">
   <a class="logo" href="/feed/feed" style="font-size: 2em; text-decoration: none;"><strong style="color:#2f2f2f;"> Devs</strong></a>            
   
   <!-- nav list -->                  
   <ul class="icons" style="padding-top: 12px;">

      <li><a class="icon solid fa-home" href="/feed/"><span class="label"></span></a></li>
      <li><a class="icon solid fa-paper-plane chatting" href="/dm/"><span class="label"></span></a></li>
      <li><a class="icon solid fa-compass" href="/feed/randomFeed"><span class="label"></span></a></li>
      <li><a class="icon solid fa-heart" href="/feed/likeFeed"><span class="label"></span></a></li>
      
      <li><a href="/member/profile">
            <c:choose>
               <c:when test="${not empty sessionLoginMemberProfile.member_img_server_name}">
                  <span class="label">                              
                     <img 
                        id="header_profile_image" 
                        style="width:20px; height:20px; border-radius:100%;" 
                        src="/resources/images/profileupload/${sessionLoginMemberProfile.member_img_server_name }"
                     >
                  </span>
               </c:when>
               <c:otherwise>
                  <i class="icon solid fa-user"></i>
               </c:otherwise>
            </c:choose>
         
            </a>
      </li>
      
      <li><a class="icon solid fa-sign-out-alt" href="/ssoclient/logout"><span class="label"></span></a></li>
      
    </ul>
</header>
<!-- END :: header -->