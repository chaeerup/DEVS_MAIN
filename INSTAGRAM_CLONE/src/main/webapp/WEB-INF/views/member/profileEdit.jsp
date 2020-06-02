<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link rel="stylesheet" href="/resources/css/main.css" />

		<link rel="icon" type="image/png" href="/resources/icons/favicon.ico"/>
		
		<link rel="stylesheet" type="text/css" href="/resources/fonts/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="/resources/fonts/material-design-iconic-font.min.css">

		<link rel="stylesheet" type="text/css" href="/resources/css/util.css">
		<link rel="stylesheet" type="text/css" href="/resources/css/profileEdit.css">

<!-- START :: HEADER FORM -->
<%@ include file="../form/header.jsp"%>
<!-- END :: HEADER FORM -->

<!-- START :: board -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#joinchk").hide();

		$("#profile_image").click(function() {
			$("#member_img_original_name").click();
		})

		$("#member_img_original_name").change(function(e) {
			
			var form = $("#imageForm")[0];
			var formData = new FormData(form);

			$.ajax({
				type : "POST",
				enctype : "multipart/form-data",
				url : "/member/updateprofileimage",
				processData : false,
				contentType : false,
				data : formData,
				dataType : "JSON",
				success : function(msg) {
					$("#profile_image").attr(
							"src",
							"/resources/images/profileupload/"
									+ msg.img);
				},
				error : function() {
					alert("통신 실패");
				}
			})
			
		})

		$("#member_email").keyup(function() {
			var member_email = $("#member_email").val().trim();
			console.log(member_email)
			var joinVal = {
				"member_email" : member_email
			}

			/*  */
			$.ajax({
				type : "post",
				url : "/member/ajaxemailcheck",
				data : JSON.stringify(joinVal),
				contentType : "application/json",
				dataType : "json",

				success : function(msg) {

					if (msg.check == true) {
						$("#joinchk").show().html(
								"이미 존재하는 EMAIL 입니다.").css("color",
								"red")
					} else {
						$("#joinchk").show().html(
								"사용가능한 EMAIL 입니다.").css("color",
								"green")
					}

				},

				error : function() {
					alert("통신실패");
				}
			});
			/*  */
		});

	});
	
	function test() {
		var member_email = $("#member_email").val().trim();
		var member_name = $("#member_name").val().trim();
		
		if (member_email == null || member_email == "" || member_name == null
				|| member_name == "") {

			alert("EMAIL, NAME 를 모두 입력해주세요!")

		} else if ($("#joinchk").html() == "이미 존재하는 EMAIL 입니다.") {

			alert("이미 존재하는 EMAIL 입니다!!");
			$("#member_email").val("");
			$("#member_email").focus();

		} else {

			$("#profileUpdateForm").submit();

		}
	}
</script>
<!-- END :: board -->
</head>
<body class="is-preload">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Main -->
					<div id="main">
						<div class="inner">

							

							<!-- Content -->
								<section>
									<header class="main">

                                        <div class="limiter">
											<div class="container-login100">
												<div class="wrap-login100 p-l-55 p-r-55 p-t-65 p-b-54">
													
														<span class="login100-form-title p-b-49">
															Profile Edit
														</span>
														
									
														<form id="profileUpdateForm" action="/member/profileUpdate" method="post" class="login100-form validate-form">
															<input type="hidden" name="member_code" value="${sessionLoginMember.member_code }">
									
														<div class="wrap-input100 validate-input m-b-23" data-validate = "Username is reauired">
															<span class="label-input100">이름</span>
															<input class="input100" type="text" name="member_name" id="member_name" placeholder="${sessionLoginMember.member_name }">
															
														</div>
														<div class="wrap-input100 validate-input m-b-23" data-validate = "Username is reauired">
															<span class="label-input100">email</span>
															<input class="input100" type="text" name="member_email" id="member_email" placeholder="${sessionLoginMember.member_email }">
															
														</div>
									
														<div class="wrap-input100 validate-input" data-validate="Password is required">
															<span class="label-input100">웹사이트</span>
															<input class="input100" type="text" name="member_website" id="member_website" placeholder="${sessionLoginMemberProfile.member_website }">
															
														</div><br>
														<div class="wrap-input100 validate-input" data-validate="Password is required">
															<span class="label-input100">소개</span>
															<input class="input100" type="text" name="member_introduce" id="member_introduce" placeholder="${sessionLoginMemberProfile.member_introduce }">
															
														</div><br>
														<div class="wrap-input100 validate-input" data-validate="Password is required">
															<span class="label-input100">성별</span>
															<select name="member_gender" id="member_gender">
																<option value="선택"></option>
																<option value="여자">남자</option>
																<option value="남자">여자</option>
																<option value="밝히고 싶지 않음">밝히고 싶지 않음</option>
															</select>
															
															
														</div>
									
													
														<div class="text-right p-t-8 p-b-31">
															
														</div>
														
														<div class="container-login100-form-btn">
															<div class="wrap-login100-form-btn">
																<div class="login100-form-bgbtn"></div>
																<button class="login100-form-btn" type="submit" value="완료" onclick="test();">
																	완료
																</button>
															</div>
														</div>
														<div id="joinchk"></div>
													</form>
									
														
													
												</div>
											</div>
										</div>
										
									
										<div id="dropDownSelect1"></div>
										
                                        
									</header>

									

									

									<hr class="major" />

									

								</section>

						</div>
					</div>

				
						</div>
			

		<!-- Scripts -->
			<script src="/resources/js/jquery.min.js"></script>
			<script src="/resources/js/browser.min.js"></script>
			<script src="/resources/js/breakpoints.min.js"></script>
			<script src="/resources/js/util.js"></script>
			<script src="/resources/js/main.js"></script>

	</body>
</html>