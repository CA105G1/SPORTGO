<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
<!-- 		<meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- 		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> -->
		<title>SPORTGO 會員登入/註冊</title>
		<meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
		<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
		<!-- Popper js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
		<!-- Bootstrap js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
		<!-- All Plugins js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
		<!-- Active js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>
		
		<style type="text/css">
			.btn{display: flex;}
			.error{color:red;}
		</style>
	</head>
	<body> 
	<div></div>
	<jsp:include page="/front-end/CA105G1_header_bt4.jsp"/>
	<!-- Loading時的小圖示 -->
	<div class="preloader d-flex align-items-center justify-content-center">
	    <div class="preloader-circle"></div>
	    <div class="preloader-img">
	        <img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png" alt="">
	    </div>
	</div>
	<form METHOD="post" ACTION="login.do">
		<div class="container">
			<div class="row">
				<div class="shop-widget col-sm-6 offset-3">
					<h1 align="center">會員登入</h1>
					<c:if test="${not empty errorMsgs}">
						<ul class="error">
							<c:forEach var="message" items="${errorMsgs}">
								<li>${message.value}</li>
							</c:forEach>
						</ul>
					</c:if>
					<div class="form-group">
						<label for="account">帳號</label>
						<input type="text" name="account" id="account" 
						class="form-control" value="${param.account}">
					<div class="form-group">
						<label for="password">密碼</label>
						<input type="password" name="password" id="password" 
						class="form-control" value="${param.password}">
					</div>
						<div class="col-xs-12 col-sm-6">
							<center>
								<button type="submit" name="button" class="btn btn-info" value="login">
								登入</button>
							</center>
						</div>
						<div class="col-xs-12 col-sm-6">
							<center>
								<button type="submit" name="button" class="btn btn-info" value="register">
								註冊</button>
							</center>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<jsp:include page="/front-end/CA105G1_footer_bt4.jsp"/>
		
	</body>
</html>