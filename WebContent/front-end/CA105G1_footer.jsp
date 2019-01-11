<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title></title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<style type="text/css">
		div.footer{
			clear:both;
			width:100%;
			position:absolute;
			bottom:0; /* 設置位置於下方 */
			height:80px;
			background-color:#4d5363;
		}
		/*使用flex-水平置中*/
		.navbar-myself-center{
			display: flex;
			justify-content:center;
		}
		</style>
	</head>
	<body> 
	<div style="height:50px;width:50px"></div>
	<div class="container-fluid">
			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-myself-center">
					<ul class="nav navbar-nav navbar-form">
						<li ><a href="#">首頁</a></li>
						<li class="dropup">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								關於我們
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">list01</a></li>
								<li><a href="#">list02</a></li>
								<li><a href="#">list03</a></li>
							</ul>
						</li>
						<li class="dropup">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								關於我們
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">AboutUs01</a></li>
								<li><a href="#">AboutUs02</a></li>
								<li><a href="#">AboutUs03</a></li>
							</ul>
						</li>
						<li class="dropup">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								會員專區
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="front-end/memberlist/Member_page.jsp">會員首頁</a></li>
								<li><a href="#">Member02</a></li>
								<li><a href="#">Member03</a></li>
							</ul>
						</li>
						<li class="dropup">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								　揪團　
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">建立揪團</a></li>
								<li><a href="#">瀏覽揪團</a></li>
								<li><a href="#">list03</a></li>
							</ul>
						</li>
						<li class="dropup">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								　社團　
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">建立社團</a></li>
								<li><a href="#">瀏覽社團</a></li>
								<li><a href="#">list03</a></li>
							</ul>
						</li>
						<li><a href="#">　賽事　</a></li>
						<li><a href="#">　場地　</a></li>
						<li><a href="#">網站地圖</a></li>
					</ul>
				</div>
			</nav>
		</div>
		<div class="h3 navbar-myself-center">@ SportyGo! 2018</div>
			
<!-- 	<script src="https://code.jquery.com/jquery.js"></script> -->
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>