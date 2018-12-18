<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTGO 會員頁面</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

		<style type="text/css">
			.navbar{
				background-color: black;
				font-size: large;
				display: flex;
				height: 100%;
			}
			.container{
				width: 100%;

			}
			.list-group-item{
				text-align: center;
				font-size: large;
				height: 80px;
				display: flex;
				justify-content: space-around;
				align-items: center;

				
			}
			.navbar-brand{
				font-size: large;
				font-style: normal;
				display: flex;

			}
			center{
				font-size: xx-large;
				color: red;
			}


		</style>
	</head>
	<body>

		<nav class="navbar navbar-default" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
						<span class="sr-only">選單切換</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="https://localhost:8081/index.html"style="color:yellow;">SPORTGO 運動揪揪</a>
				</div>
				
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					
					<ul class="nav navbar-nav navbar-right" >
						<li><a href="#" style="color:yellow;">Amos 您好</a></li>
						<li><a href="#" style="color:yellow;">登出</a></li>
						
						<li class="dropdown">
							
						</li>
					</ul>
				</div>
			</div>
		</nav>

		<div class="container">
		</div>

		<!-- 右選單 -->
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<div class="list-group">
						<a href="#" class="list-group-item active">個人頁面</a>
						<a href="#" class="list-group-item">行事曆</a>
						<a href="#" class="list-group-item">個人頁面管理</a>
						<a href="#" class="list-group-item">個人揪團管理</a>
						<a href="#" class="list-group-item">個人社團管理</a>
						<a href="#" class="list-group-item">好友管理</a>
						<a href="#" class="list-group-item">訂單管理</a>
						<a href="#" class="list-group-item">最愛的商品</a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-9">
					<div class="container">
						
					</div>
				</div>	
			</div>
		</div>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>