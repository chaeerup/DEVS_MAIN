<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- START :: HEADER FORM -->
	<%@ include file="../form/header.jsp"%>
<!-- END :: HEADER FORM -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<title>Devs</title>
<link rel="stylesheet" href="/resources/css/feed.css" />
<link rel="stylesheet" href="/resources/css/main.css" />
<noscript><link rel="stylesheet" href="/resources/css/noscript.css" /></noscript>
<!-- START :: feed -->

<script type="text/javascript">
	// 페이지를 로드하면 바로 실행 (크롤링부분)
	onload = function() {
		var $tbody = $("#tbody")

		$.getJSON('http://localhost:8585/crawling', function(data) {
			var rank = data.rank;

			for (var i = 0; i < rank.length; i++) {

				var $tr = $('<tr>')
				var $tag = $('<td>').append(rank[i].tag)
				$tr.append($tag)
				$tbody.append($tr)

			}
		});
	}

	
		/* 무한 스크롤 eventListner */
		let isEnd = false;
		var startNo = 1;
		var searchNo = 0;
		var member_code = ${sessionLoginMember.member_code};
		
		$(function(){	
			
			$(window).scroll(function(){
				var scrollTop = $(window).scrollTop();	// 현재 브라우저 스크롤이 있는 위치
				var documentHeight = $(document).height();	// 문서의 총 높이
				var windowHeight = $(window).height();	// 브라우저에 보여지는 높이
				
				console.log(
						"documentHeight : " + $(document).height()
						+ " | scrollTop : " + $(window).scrollTop() 
						+ " | windowHeight : " + $(window).height()
						+ " | scrollTop + windowHeight = " + ($(window).scrollTop() + $(window).height())
						);
				
				if(documentHeight < scrollTop + windowHeight + 1){
					selectFeedList();	
				}
			})
			
			selectFeedList();	
		})
	
		/* feed List ajax 통신 */
		function selectFeedList(){	
			if(isEnd == true)
				return;
			
			$.ajax({
				type:"GET",
				url:"/feed/feedlist",
				data : {"startNo":startNo, "member_code":member_code},
				dataType:"json",
				async:false,
				success: function(data){
					// 가져온 데이터가 15개 이하 (막지막 sub리스트)일 경우 무한 스크롤 종료
					let length = data.length;
					if(length < 15){
						isEnd = true;
						console.log("******마지막 컨텐츠까지 다 가져옴******");
					}
					fillFeedList(data);
				}
			})
				startNo += 15;
	
		}
		
		/* feed list 뿌리기 */
		function fillFeedList(data){	
			
			$.each(data, function(key, value){
				var feed = $('<article>').attr({'class':'post featured'});
				$('#main_feed').append(feed);
				var headertag = $('<header>');
				feed.append(headertag);
				headertag.append($('<br>'));
				
				
				var board_regdate = moment(value.board_regdate).format("YYYY-MM-DD hh:mm");
				var board_code = value.board_code;
				var member_id = value.member_id;
				var member_code = ${sessionLoginMember.member_code};
				
				var profile_info = $('<div>').attr({'class':'profile_info'});
				var profile_img = $('<img>').attr({'class':'profile_img', 'src':'/resources/images/profileupload/'+value.member_img_server_name});
				var profile_id = $('<a>').attr({'class':'profile_id', 'style':'margin:10px;', 'href':"/member/headerSearch?search="+member_id}).html(member_id);
				headertag.append(profile_info);
				profile_info.append(profile_img).append(profile_id);
				headertag.append($('<br><br>'));
				var atag = $('<a>').attr('class','image main');
				headertag.append(atag);
				
				if(value.board_file_ext == 'mp4'){
					var vid = $('<video>').attr({'src':'/resources/images/feedupload/'+value.board_file_server_name, 'controls':'true'});
					var contents = $('<p>').html(value.board_content);
					atag.append(vid);
					headertag.append(contents);
				} else {
					
					var img = $('<img>').attr({'src':'/resources/images/feedupload/'+value.board_file_server_name});
					var board_contents_hashtag = getHashTag(value.board_content);
					var contents = $('<p>').attr({'class':'contents'}).html(board_contents_hashtag);
					atag.append(img);
					headertag.append(contents);
				}
				headertag.append('<p>'+ board_regdate+ ' 에 등록됨</p>');
				
				var ultag = $('<ul>').attr('class','icons');
				feed.append(ultag);
				var list_like = $('<li>').attr('class','list_like');
				var list_reply = $('<li>').attr('class','list_reply');
				var list_dm = $('<li>').attr('class','list_dm');
				
				ultag.append(list_like)
				.append(list_reply)
				.append(list_dm);
				
				var reply_location = $('<a>').attr({'href':"/feed/pickedFeed?board_code="+board_code});
				list_reply.append(reply_location.append('<span class="icon solid fa-comments" style="color: #2f2f2f;"></span>'));
				
				var dm_location = $('<a>');
				list_reply.append(dm_location.append('<span class="icon solid fa-paper-plane" style="color: #2f2f2f;"></span>'));
				
				$.ajax({
					type:"GET",
					url:"/feed/isLiked",
					data:{ "board_code":board_code, "member_code":member_code},
					cache:false,
					async:false,
					success: function(like){
						if(like.cnt){
							list_like.append("<a class='unlike' id='"+board_code+"'>").append('<span class="icon solid fa-heart""></span>');
						} else{
							list_like.append("<a class='like' id='"+board_code+"'>").append('<span class="icon solid fa-heart""></span>');
						}
					},
					error : function(){
						alert("AJAX 좋아요 버튼 출력 실패");
					}
				},1000)
				
				
				
				
				$.ajax({
					type:"GET",
					url: "/feed/feedreply",
					data: {"board_code" : board_code},
					dataType: "JSON",
					async:false,
					success: function(msg){
						
						if(msg != null){
							var reply_div = $("<div>").attr({'class':'replyContainer'});
							var rep_id_div = $('<span>').attr({'class' : 'reply_member_id_div'});
							var rep_id = $('<a>').attr({'href':"/member/headerSearch?search="+msg.member_id, 'class':'reply_member_id'});
							var rep_content = $('<span>').attr({'class':'reply_content'}).text(msg.reply_content);
							
							feed.append(reply_div);
							
							reply_div.append(rep_id_div);
							
							rep_id_div.append(rep_id);
							rep_id.text(msg.member_id);
							
							reply_div.append(rep_content);
							
							var morereply = $('<a class="more_reply" href="">댓글 더보기</a>');
							morereply.attr({'href':'location.href="/feed/pickedFeed?board_code="'+board_code});
							reply_div.append(morereply);
						}
						
					}
				})
				$('#main_feed').append('<hr class="major" />');
			})
		}
		
		// hashTag 로 바꿔주기
	    function getHashTag(content){
	       
	       var splitedArray = content.split(' ');
	       var linkedContent = '';
	       for(var word in splitedArray)
	       {
	         word = splitedArray[word];
	          if(word.indexOf('#') == 0)
	          {
		         var tagtext = word.substring(word.indexOf('#')+1);
	             word = '<a style="color: #00376b; font-weight: bolder" href="/feed/searchTagBoard?hashtag='+tagtext+'">'+word+'</a>';
	             console.log(word);
	          }
	          linkedContent += word+' ';
	       }
	       
	       return linkedContent;
	    }
		
		// 좋아요
		
		$(document).on('click', '.like', function (){
			var board_code = $(this).attr('id');
			var member_code = ${sessionLoginMember.member_code};
			$.ajax({
				type:"POST",
				url:"/feed/boardLike",
				data:{"board_code" : board_code, "member_code":member_code},
				success: function(msg){
					if(msg.res == 1){
						alert("좋아요 성공");
						// 아이콘 바뀌어야함
					}else{
						alert("좋아요 실패");
					}
				},
				error: function(){
					alert("통신실패");
				}
			})
		})
		
		// 좋아요 취소
		$(document).on('click', '.unlike', function (){
			var board_code = $(this).attr('id');
			var member_code = ${sessionLoginMember.member_code};
			$.ajax({
				type:"POST",
				url:"/feed/boardUnlike",
				data:{"board_code" : board_code, "member_code":member_code},
				success: function(msg){
					if(msg.res == 1){
						alert("좋아요 취소 성공");
						// 아이콘 바뀌어야함
					}else{
						alert("좋아요 취소 실패");
					}
				},
				error: function(){
					alert("통신실패");
				}
			})
		})
	</script>
<!-- END :: feed -->
</head>

<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">
      <!-- Main -->
		<div id="main">
			<div class="inner">
            
				<!-- START :: header -->
					<%@ include file="../form/headercontents.jsp"%>
				
		         <%-- <header id="header">
		            <a class="logo" href="/feed/feed"><strong style="color:#9400d3;"> Devs</strong></a>            
		            
		            <!-- nav list -->                  
		            <ul class="icons">
		
		               <li><a class="icon solid fa-home" href="/feed/"><span class="label"></span></a></li>
		               <li><a class="icon solid fa-paper-plane" href="/dm/"><span class="label"></span></a></li>
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
		         </header> --%>
		         <!-- END :: header -->
				
				<!-- START :: main feed contents -->
				<section>
					<header class="main">
		     			<section id="banner">
							<div class="content">
								<!-- board contents -->	
								<div id="main_feed"></div>
							</div>
							
							<!-- crawling contents -->
							<div class="table object" id="tab">
								<table class="table table-striped table-hover">
									<tbody id="tbody"></tbody>
								</table>
							</div>
						</section>
					</header>
				</section>
				<!-- END :: main feed contents -->
        	
        	</div>
        	
		</div>
		<!-- END Main -->
			
		<!-- START :: Sidebar -->
		
			<%@ include file="../form/sidebar.jsp"%>
		
		
<%-- 		<div id="sidebar">
			<div class="inner">

				<!-- Search -->
				<section id="search" class="alt">
		            <form id="headerSearch" action="/member/headerSearch" method="post">
		                  <input id="search" class="form-control bg-light" type="text" name="search" value="${search}" placeholder="검색">
		             </form>  
				</section>

				<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<h2>Menu</h2>
					</header>
					<ul>
						<li><a href="#">Private CH.</a></li>
						<li><a href="www.devsgroup.ml/">Collabo CH.</a></li>
						<li><a href="#">About Devs</a></li>
						<li>
							<span class="opener">Contact</span>
							<ul>
								<li><a href="#">Phone</a></li>
								<li><a href="#">SNS</a></li>
								
							</ul>
						</li>
					</ul>
				</nav>

				<!-- Section -->
				<section>
					<header class="major">
						<h2>Contact</h2>
					</header>
					<p></p>
					<ul class="contact">
						<li class="icon solid fa-envelope">information@untitled.com</li>
						<li class="icon solid fa-phone">(000) 000-0000</li>
						<li class="icon solid fa-home">서울시 강남구 역삼동
						</li>
					</ul>
				</section>

				<!-- Footer -->
				<footer id="footer">
					<p class="copyright">&copy; Untitled. All rights reserved. <br>&nbsp &nbsp  Design: <b style="color: #9400d3;">Devs</b></p>
				</footer>

			</div>
		</div> --%>
		<!-- END :: Sidebar -->

     </div>
	
	<!-- Scripts -->
	<script src="/resources/js/jquery.min.js"></script>
	<script src="/resources/js/browser.min.js"></script>
	<script src="/resources/js/breakpoints.min.js"></script>
	<script src="/resources/js/util.js"></script>
	<script src="/resources/js/main.js"></script>
	<script src="/resources/js/feed.js"></script>
	
</body>
</html>