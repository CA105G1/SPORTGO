<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import ="com.emp.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTGO 管理員頁面</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<style type="text/css">
			.navbar-default{
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
			
		</style>
</head>
<body>
		<nav class="navbar navbar-default" role="navigation" style="background-color: black;">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
						<span class="sr-only">選單切換</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="https://localhost:8081/index.html"style="color:yellow;">SPORTGO 後台管理員</a>
				</div>
				
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					
						<ul class="nav navbar-nav navbar-right" >
								<li><a href="#" style="color:yellow;">會員管理頁面</a></li>
								<li><a href="logout.do" style="color:yellow;">登出</a></li>
						</ul>
				</div>
			</div>
		</nav>

		<jsp:useBean id="MemSvc" scope="page" class="com.memberlist.model.MemberlistService" />
	<div class="container">
				<div class="row">
						<!-- 左邊選擇欄位 -->
						<div class="col-xs-12 col-sm-3 list-group">
							<a href="#all" data-toggle="tab" class="list-group-item">查詢所有會員</a>
							<a href="#one" data-toggle="tab" class="list-group-item">查詢單一會員</a>
							<a href="#new" data-toggle="tab" class="list-group-item">新增一位會員</a>
							<a href="#update" data-toggle="tab" class="list-group-item">修改會員資料</a>
						</div>
						<!-- 內容 -->
						<div class="col-xs-12 col-sm-9 tab-content">
						<!-- 查全部 -->
							<div class="tab-pane" id="all">
								<%@ include file = "listAllMem.jsp" %>
							</div>
						<!-- 查一個 -->
							<div class="tab-pane" id="one">
								<form method="post" action="MemManager.do">
								<b>選擇會員編號：</b>
									<select size="1" name="mem_no">
										<c:forEach var="MemVO" items="${MemSvc.allMem}">
											<option value="${MemVO.mem_no}">${MemVO.mem_no}
										</c:forEach>
									</select>
								<input type="hidden" name="action" value="getOne_For_Display">
								<input type="submit" value="查詢">
								</form>
							</div>
						<!-- 註冊新帳號 -->
							<div class="tab-pane" id="new">
								<%@include file="/front-end/memberlist/RegisterMem_page.jsp" %>
							</div>
						<!-- 更新資料 -->
							<div class="tab-pane" id="update">
								<form method="post" action="MemManager.do">
									<b>選擇會員編號：</b>
										<select size="1" name="empno">
											<c:forEach var="MemVO" items="${MemSvc.allMem}">
												<option value="${MemVO.mem_no}">${MemVO.mem_no}
											</c:forEach>
										</select>
									<input type="hidden" value="updateOne_Detail">
									<input type="submit" value="修改">
								</form>
							</div>
						</div>
			</div>
	</div>
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>