<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
<!-- 		<meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- 		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no"> -->
		<title>SPORTGO 會員登入/註冊</title>
		<meta charset="utf-8">
		<meta name="description" content="">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
	<jsp:include page="/front-end/CA105G1_header_bt4.jsp"/>
	<!-- Loading時的小圖示 -->
<!-- 	<div class="preloader d-flex align-items-center justify-content-center"> -->
<!-- 	    <div class="preloader-circle"></div> -->
<!-- 	    <div class="preloader-img"> -->
<%-- 	        <img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png" alt=""> --%>
<!-- 	    </div> -->
<!-- 	</div> -->
	<div class="breadcrumb-area">
    <!-- Top Breadcrumb Area -->
	    <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/sgpic/sportbg2.jpg);">
	    </div>
	</div>
<!-- 	login area -->
	<section class="contact-area">
		<div class="container">
			<div class="row align-items-center justify-content-between">
				<div class="col-sm-6 offset-3">
					<div class="section-heading">
						<h2 align="center">會員登入</h2>
					</div>
					 <!-- Contact Form Area -->
					<div class="contact-form-area mb-100">
						<form METHOD="post" ACTION="login.do">
							<div class="row">
								<c:if test="${not empty errorMsgs}">
									<ul class="error">
										<c:forEach var="message" items="${errorMsgs}">
											<li>${message.value}</li>
										</c:forEach>
									</ul>
								</c:if>
								<div class="col-12">
									<div class="form-group">
										<input type="text" name="account" id="account" 
										class="form-control" value="${param.account}"
										placeholder="帳號">
									</div>
								</div>
								<div class="col-12">
									<div class="form-group">
										<input type="password" name="password" id="password" 
										class="form-control" value="${param.password}"
										placeholder="密碼">
									</div>
								</div>
								<div class="col-6">
									<button type="submit" name="button" 
									class="btn alazea-btn" value="login">登入</button>
								</div>
								<div class="col-6">
									<button type="submit" name="button"
									class="btn alazea-btn" value="register" style="float:right;text-align:center;">
									註冊</button>
								</div>
					</div>
					</div>
	</form>
	</div>
				</div>
			</div>
		</div>
	</section>
	<jsp:include page="/front-end/CA105G1_footer_bt4.jsp"/>
		
	</body>
</html>