<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
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

		<nav class="navbar navbar" role="navigation" style="background-color: black;">
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
								<li><a href="#" style="color:yellow;">${MemberlistVO.mem_name} 您好</a></li>
								<li><a href="logout.do" style="color:yellow;">登出</a></li>
						</ul>
				</div>
			</div>
		</nav>

		<div class="container-fluid">
		</div>

		<!-- 右選單 -->
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<div class="list-group">
					<a href="#mem" data-toggle="tab" data-target="#mem" class="list-group-item active">個人頁面</a>
					<a href="#calendar" data-toggle="tab" class="list-group-item">行事曆</a>
					<a href="#renew" data-toggle="tab" class="list-group-item">個人頁面管理</a>
					<a href="#sg" data-toggle="tab" class="list-group-item">個人揪團管理</a>
					<a href="#club" data-toggle="tab" class="list-group-item">個人社團管理</a>
					<a href="#friend" data-toggle="tab" class="list-group-item">好友管理</a>
					<a href="#order" data-toggle="tab" class="list-group-item">訂單管理</a>
					<a href="#prolike" data-toggle="tab" class="list-group-item">最愛的商品</a>
					</div>
				</div>
				<div class="col-xs-12 col-sm-9 tab-content">
				<!-- 個人頁面 -->
					<div class="tab-pane active" id="mem">
						<img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${MemberlistVO.mem_no}">
						<ul class="list">
							<li>姓名 : ${MemberlistVO.mem_name}</li>
							<li>暱稱 : ${MemberlistVO.mem_nick}</li>
							<li>Email : ${MemberlistVO.mem_email}</li>
							<li>電話 : ${MemberlistVO.mem_phone}</li>
							<li>緊急聯絡人 : ${MemberlistVO.mem_emgc}</li>
							<li>緊急聯絡人電話 : ${MemberlistVO.mem_emgcphone}</li>
						</ul>
					</div>
					<!-- 行事曆 -->
					<div class="tab-pane" id="calendar">
					</div>
					<!-- 修改個人資料 -->
					<div class="tab-pane" id="renew">
						<jsp:include page="Member_renew.jsp">
							<jsp:param name="mem_no" value="${MemberlistVO.mem_no}"/>
						</jsp:include>
					</div>
					<!-- 揪團管理 -->
					<div class="tab-pane" id="sg">
					</div>
					<!-- 社團管理 -->
					<div class="tab-pane" id="club">
					</div>
					<!-- 好友管理 -->
					<div class="tab-pane" id="friend">
					</div>
					<!-- 訂單管理 -->
					<div class="tab-pane" id="order">
					</div>
					<!-- 最愛商品管理 -->
					<div class="tab-pane" id="prolike">
					</div>
				</div>	
			</div>
		</div>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>