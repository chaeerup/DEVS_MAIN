<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<!-- START :: HEADER FORM -->
	<%@ include file="../form/header.jsp"%>
	
	<%-- <jsp:include page="/WEB-INF/views/form/header.jsp"/> --%>
<!-- END :: HEADER FORM -->
<!DOCTYPE HTML>

<html>
	<head>
		<title>Devs</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/css/main.css" />
		<link rel="stylesheet" href="/resources/css/profile.css" />
		<link href="/resources/css/profilefeed.css" type="text/css" rel="stylesheet">
		<noscript><link rel="stylesheet" href="/resources/css/noscript.css" /></noscript>


	
</head>



<body class="is-preload">
	
	<div id="wrapper">
		<div id="main">
			<div class="inner">
		<!-- START :: HEADER_CONTENTS -->
			<%@ include file="../form/headercontents.jsp"%>
		<!-- START :: HEADER_CONTENTS -->
					<section class="container w-75 h-100">
						<div id="header">
							<div class="row">
								
								<!-- 멤버 프로필 이미지 -->
								<div class="col-sm-4">
									<form id="imageForm" action="/member/updateprofileimage" method="POST" enctype="multipart/form-data">
										<input type="hidden" name="member_code" value="${profile.member_code }">
										
										<div style="width:200px;height:200px; overflow:hidden;" class="rounded-circle border w-200 h-200 overflow-hidden mx-auto">
											<img 
												id="profile_image" 
												style="width:200px; height:200px; cursor:pointer;" 
												src="<c:choose>
														 <c:when test="${not empty profile.member_img_server_name}">
														 	 /resources/images/profileupload/${profile.member_img_server_name }
														 </c:when>
														 <c:otherwise>
														 	/resources/images/profile/add.png
														 </c:otherwise>
													 </c:choose>"
											>
										</div>
				
									</form>
								</div>
								
								<!-- 계정관련 -->
								<div class="col-sm-8">
									<div class="d-flex mb-2">
										<div class="my-auto mx-1">
											<h2 style="margin-right:10px; margin-bottom:0">${profile.member_id }</h2>
										</div>
										<div class="my-auto mx-1">
						                  <c:choose>
						                     <c:when test="${followCheck eq 0 || null}">
						                  <input type="button" class="follow btn btn-outline-secondary btn-sm" id="${profile.member_id }" onclick="follow();" value="팔로우">
						                     </c:when>
						                     <c:otherwise>
						                  <input type="button" class="unfollow btn btn-secondary btn-sm" id="${profile.member_id }" onclick="unfollow();" value="언팔로우">
						                     </c:otherwise>
						                  </c:choose>
						                     <input type="button" style="display: none;" id="follow" class="follow btn btn-outline-secondary btn-sm" id="${profile.member_id }" onclick="follow();" value="팔로우">
						                     <input type="button" style="display: none;" id="unfollow" class="unfollow btn btn-secondary btn-sm" id="${profile.member_id }" onclick="unfollow();" value="언팔로우">
						                  
						                  </div>
										
									</div>
									<div class="mb-2">
										<ul class="navbar-nav list-group-horizontal">
											<li class="nav-item mr-5">게시물 <b>${profile.board_count}</b></li>
											 <li class="nav-item mr-5"><a href="/member/followerList?member_code=${profile.member_code}">팔로워 <b>${profile.follower_count }</b></a></li>
						                     <li class="nav-item mr-5"><a href="/member/followList?member_code=${profile.member_code }">팔로우 <b>${profile.follow_count }</b></a></li>
						                     <li class="nav-item mr-5">성별  <b>${profile.member_gender }</b></li>
										</ul>
									</div>
									<div class="mb-2">
						                  <div>
						                     ${profile.member_name }
						                  </div>
						                  <div>
						                     ${profile.member_introduce }
						                  </div>
						                  <div>
						                     <h3><a href="${profile.member_website }">${profile.member_id }님의 웹사이트</a></h3>
						                  </div>
						             </div>
									
								</div>
							</div>
						</div>
					
					<!-- Posts -->
						<!--div class="feed"-->
				<header class="main">
					<div id="contant" class="h-150">
						<div class="row" style="margin:10px auto">
							
							<c:forEach var="list" items="${feedList }">
								<div class="contents" style="padding: auto;">
									<c:choose>
										<c:when test="${list.board_file_ext eq 'mp4'}">
						                     <div class="thumbnail" id="${list.board_code}">
						                        <c:set var="board_file_server_name" value="${list.board_file_server_name }"></c:set>
						                        <img class="fit" src="/resources/images/feedupload/${fn:substringBefore(board_file_server_name, '.')}.jpg">
						                        <img class="play-button" src="/resources/images/feedupload/playbutton.png">
						                     </div>
										</c:when>
										<c:otherwise>
											<div class="thumbnail" id="${list.board_code}">
												<c:set var="file_name" value="${list.board_file_server_name }"></c:set>
												<img class="fit" src="/resources/images/feedupload/${file_name }">
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</c:forEach>
				
			
						</div>
				<!-- 모달창 -->
					<div class="bg-modal">
						<div class="close">+</div>
							<div class="modal-box">
							
								<div class="div-left">
									<div id="media" class="remove">
										<!-- 사진 or 비디오 -->
									</div>
								</div>
								
								<div class="div-right">
									<header id="user-info" class="remove">	
										<!-- 글쓴이 프로필 -->
									</header>
									<div id="like_count" class="remove">
										<!-- 좋아요 개수 -->
									</div>
									<div id="buttons">
										<input style="width: 24px; height: 24px" type="image" src="/resources/images/social/liked_icon.png" id="unlike_button" value="좋아요 취소"onclick="unlike();">
										<input style="width: 24px; height: 24px" type="image" src="/resources/images/social/like_icon.png" id="like_button" value="좋아요" onclick="like();">
									</div>
									
									<div id="board-content" class="remove">
									
									</div>
									
									<div id="replyList" class="remove">
										
									</div>
									
									<div id="like"></div>
									
									<div class="reply-insert-box">
										<form id="replyform" action="/feed/insertReply" method="post">
											<input type="hidden" id="reply_board_code" name="board_code" value="">
											<input type="hidden" name="member_code" value="${sessionLoginMember.member_code}">
											<textarea name="reply_content" placeholder="댓글 달기"></textarea>
											<input type="button" id="replysubmitbutton" value="게시" onclick="insertReply();">
										</form>
									</div>
								</div>
								
							</div>
						</div>
	      			</div>
	      		</header>
	   		</section>
	   
	   
	   		</div>
	   </div>
   </div>
   
   
   
<script type="text/javascript">
   
   
   
		$(".follow").click(function(){
		   var member_id = '${profile.member_id}';
		   var member_code = '${sessionLoginMember.member_code}';
		   var channel_code ='${profile.channel_code}';
		   var param = {
		         "member_code" : member_code , 
		         "member_id" : member_id , 
		         "channel_code" : channel_code
		   }
		   $.ajax({
		      type:"post",
		      url:"/member/follow",
		      data:param,
		      dataType:'json',
		      success: function(data){
		         alert("팔로우 성공");
		         if(data.res == true){
		            $(".follow").hide();
		            $(".unfollow").hide();
		            $("#follow").hide();
		            $("#unfollow").show();
		            location.reload();
		         }
		      },
		   error:function(request,status,error){
		      alert("통신실패");
		      }
		   })
		})
		
		$(".unfollow").click(function(){
		   var member_id = '${profile.member_id}';
		   var member_code = '${sessionLoginMember.member_code}';
		   var channel_code ='${profile.channel_code}';
		   var param = {
		         "member_code" : member_code , 
		         "member_id" : member_id , 
		         "channel_code" : channel_code
		   }
		   $.ajax({
		      type:"post",
		      url:"/member/unfollow",
		      data:param,
		      dataType:'json',
		      success: function(data){
		         alert("언팔로우 성공");
		         if(data.res == true){
		            $(".unfollow").hide();
		            $(".follow").hide();
		            $("#unfollow").hide();
		            $("#follow").show();
		            location.reload();
		         }
		      },
		   error:function(request,status,error){
		      alert("통신실패");
		      }
		   })
		})

		// 모달창 띄우기
		$(".thumbnail").click(function() {
			var board_code = $(this).attr('id');
			var member_code = ${sessionLoginMember.member_code};
			var param = {"board_code":board_code, "member_code":member_code};
			// 이미지, 글쓴이 프로필 출력
			$.ajax({
				type:"GET",
				url:"/feed/selectContent",
				data:{"board_code": board_code},
				success: function(vo){
					if(vo.board_file_ext == 'mp4'){
						var vid = $('<video id="video" src="" controls></video>');
						$("#media").append(vid);
						$("#video").attr('src', '/resources/images/feedupload/'+vo.board_file_server_name);
						
					}else{
						$("#media").append('<img id="image">')
						$("#image").attr('src','/resources/images/feedupload/'+vo.board_file_server_name);
					}
					$("#user-info").append($('<img id="writer_profile_image" style="margin-right:10px; src="">')).append($('<a id="board_writer" href="/member/headerSearch?search='+vo.member_id+'"></a>'));
					$("#writer_profile_image").attr('src','/resources/images/profileupload/'+vo.member_img_server_name);
					$("#board_writer").text(vo.member_id);
					$("#reply_board_code").val(board_code);
					
					
					
					if(vo.board_content == null){
		            	$("#board-content").append("<span></span>");
		            }else{
		            	$("#board-content").append("<span>"+getHashTag(vo.board_content)+"</span>");            
		            }
					
					$("#like_count").append("<span>좋아요 "+vo.board_like_count+"개</span>");
				}
			});
			
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
			            word = '<a href="/feed/searchTagBoard?hashtag='+tagtext+'">'+word+'</a>';
			            console.log(word);
			         }
			         linkedContent += word+' ';
			      }
			      
			      return linkedContent;
			   }   
			
			// 좋아요 버튼
			$.ajax({
				type:"GET",
				url: "/feed/isLiked",
				data:param,
				success: function(msg){
					if(msg.res>0){
						$("#like_button").hide();
						$("#unlike_button").show();
					}else{
						$("#unlike_button").hide();
						$("#like_button").show();
					}
				},
				error: function(){
					alert("통신실패");
				}
			})
			
			// 댓글리스트 출력
			$.ajax({
				type:"GET",
				url:"/feed/replyList",
				data:{"board_code": board_code},
				dataType:"json",
				success: function(msg){
					$.each(msg, function(key, value){
						var reply_regdate = moment(value.reply_regdate).format("YYYY-MM-DD hh:mm");
						var rep = $('<div>').attr({'class':'rep'});
						$("#replyList").append(rep);
						rep.append("<img class='re-member-pic' src='"+ '/resources/images/profileupload/'+value.member_img_server_name+"'>"+
								"<a class='re-member-id' href='/member/headerSearch?search="+value.member_id+"'>"+value.member_id+"</a>" +
								"<span class='re-reply-content'>"+value.reply_content+"</span>"+
								"<span class='re-reply-regdate'>"+reply_regdate+" 에 등록됨</span>"		
						);
					})
					
				}
			})
			
			$(".bg-modal").css("display", "flex");
			
		})
		
		
		// 댓글 등록
		function insertReply(){
			var params = $("#replyform").serialize();
			$.ajax({
				type:"POST",
				url:"/feed/insertReply",
				data:params,
				success: function(msg){
						var reply_code = msg.re_code;
						console.log(reply_code);
						$.ajax({
							type:"GET",
							url:"/feed/insertReplyView",
							data:{"reply_code":reply_code},
							dataType:"json",
							success: function(data){
								alert("댓글이 등록되었습니다.");
								console.log(data);
								
								$("#replyList").append(
										"<img class='re-member-pic' src='/resources/images/profileupload/${sessionLoginMemberProfile.member_img_server_name }'>"+
										"<span class='re-member-id'>${sessionLoginMember.member_id}</span>" +
										"<span class='re-reply-content'>"+data.reply_content+"</span>"+
										"<span class='re-reply-regdate'>"+data.reply_regdate+"</span>"
									);
								$('textarea').val("");

							},
							error: function(){
								alert("통신 실패");
							}
						})
						
					},
				
				error: function(){
					alert("통신 실패");
				}
				
			});
		}
		// 좋아요
		function like(){
			var board_code = $("#reply_board_code").val();
			var member_code = ${sessionLoginMember.member_code};
			$.ajax({
				type:"POST",
				url:"/feed/boardLike",
				data:{"board_code" : board_code, "member_code":member_code},
				success: function(msg){
					if(msg.res == 1){
						$("#like_button").hide();
						$("#unlike_button").show();
						$("#like_count").find("*").remove();
						$("#like_count").append("<span>좋아요 "+msg.board_like_count+"개</span>");
					}else{
						alert("좋아요 실패");
					}
				},
				error: function(){
					alert("통신실패");
				}
			})
		}
		// 좋아요 취소
		function unlike(){
			var board_code = $("#reply_board_code").val();
			var member_code = ${sessionLoginMember.member_code};
			$.ajax({
				type:"POST",
				url:"/feed/boardUnlike",
				data:{"board_code" : board_code, "member_code":member_code},
				success: function(msg){
					if(msg.res == 1){
						$("#unlike_button").hide();
						$("#like_button").show();
						$("#like_count").find("*").remove();
						$("#like_count").append("<span>좋아요 "+msg.board_like_count+"개</span>");
					}else{
						alert("좋아요 취소 실패");
					}
				},
				error: function(){
					alert("통신실패");
				}
			})
		}
		
		// 모달 창 닫기
		$(".close").click(function(){
			$(".remove").find("*").remove();
			$(".bg-modal").css("display", "none");
		})
</script>
</body>
</html>