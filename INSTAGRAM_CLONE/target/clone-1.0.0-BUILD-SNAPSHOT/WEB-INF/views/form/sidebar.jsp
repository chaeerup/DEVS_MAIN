<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		
		<!-- Sidebar -->
		<div id="sidebar">
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
							<li><a href="#">Collabo Ch.</a></li>
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
						<p class="copyright">&copy; Untitled. All rights reserved. <br>&nbsp &nbsp  Design: <b style="color: #2f2f2f;">Devs</b></p>
					</footer>

			</div>
		</div>
</body>
</html>