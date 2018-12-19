<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTGO 會員登入/註冊</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<style type="text/css">
			.btn{display: flex;}
			.error{color:red;}
		</style>
	</head>
	<body> 
	<!-- pressure test -->
	
	
	
	
	<form METHOD="post" ACTION="login.do">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-sm-offset-3">
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
						<input type="text" name="password" id="password" 
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
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>