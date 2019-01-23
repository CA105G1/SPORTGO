<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<meta name="description" content="">
		<title>SPORTGO 會員註冊</title>
		<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
		<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
		
		<style type="text/css">
			.btn{display: flex;}
			.error{color:red;}
			img{width:100%;
				height:100%;}
		</style>
</head>
<body>
	<jsp:include page="/front-end/CA105G1_header_bt4.jsp"/>
	<!-- Loading時的小圖示 -->
	<div class="preloader d-flex align-items-center justify-content-center">
	    <div class="preloader-circle"></div>
	    <div class="preloader-img">
	        <img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png" alt="">
	    </div>
	</div>
    <!-- Top Breadcrumb Area -->
	<div class="breadcrumb-area">
	    <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/sgpic/sportbg2.jpg);">
	    </div>
	</div>
<!-- 	RegisterArea -->
	<section class="contact-area">
		<div class="container">
			<div class="row  align-items-center justify-content-between">
				<div class="col-sm-6 offset-3">
					<div class="section-heading">
						<h2 align="center">會員註冊</h2>
					</div>
					<div class="contact-form-area mb-100">
						<form method="post" enctype="multipart/form-data" action="Register.do">
						<div class="row">
<%-- 							<c:if test="${not empty errorMsgs}"> --%>
<!-- 								<ul class="error"> -->
<%-- 									<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 										<li>${message.value}</li> --%>
<%-- 									</c:forEach> --%>
<!-- 								</ul> -->
<%-- 							</c:if> --%>
						<div class="col-12">
							<div class="form-group">
								<input type="file" name="picture" class="upl" placeholder="照片">
								<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
								<img class="preview" src="<%=request.getContextPath()%>/img/mem_no.jpg"
								style="height:100%;position:absolute;">
								</div>							
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
							${message.account.value}
								<input type="text" name="account" 
								class="form-control" value="${param.account}"
								placeholder="帳號(必填)">
								<div style="color:red;">${errorMsgs.account}</div>
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<input type="password" name="password" 
								class="form-control" value="${param.password}"
								placeholder="密碼(必填)">
								<div style="color:red;">${errorMsgs.password}</div>
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<input type="text" name="name" 
								class="form-control" value="${param.name}"
								placeholder="姓名(必填)">
								<div style="color:red;">${errorMsgs.name}</div>
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<input type="text" name="nick" 
								class="form-control" value="${param.nick}"
								placeholder="暱稱">
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<input type="email" name="email" 
								class="form-control" value="${param.email}"
								placeholder="電子郵件(必填)">
								<div style="color:red;">${errorMsgs.email}</div>
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<input type="phone" name="phone" 
								class="form-control" value="${param.phone}"
								placeholder="手機號碼(必填)">
								<div style="color:red;">${errorMsgs.phone}</div>
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<input type="text" name="emgc" 
								class="form-control" value="${param.emgc}"
								placeholder="推薦人">
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<input type="text" name="emgcphone" 
								class="form-control" value="${param.emgcphone}"
								placeholder="推薦人電話">
								<div style="color:red;">${errorMsgs.emgcphone}</div>
							</div>
						</div>
						<div class="col-6">
							<button type="submit" name="button" class="btn alazea-btn"
							value="register">註冊</button>
						</div>
						<div class="col-6">
							<button type="submit" name="button" class="btn alazea-btn"
							value="cancel" style="float:right;">取消</button>
						</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
	<jsp:include page="/front-end/CA105G1_footer_bt4.jsp"/>
	<!-- Popper js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
		<!-- Bootstrap js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
		<!-- All Plugins js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
		<!-- Active js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>
		
<script>
$(function (){
	function format_float(num, pos){
        var size = Math.pow(10, pos);
        return Math.round(num * size) / size;
    }
function preview(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('.preview').attr('src', e.target.result);
           /*  var KB = format_float(e.total / 1024, 2);
            $('.size').text("檔案大小：" + KB + " KB"); */
        }
        reader.readAsDataURL(input.files[0]);
    }
}
function format_float(num, pos){
    var size = Math.pow(10, pos);
    return Math.round(num * size) / size;
}
$("body").on("change", ".upl", function (){
    preview(this);
})
})
</script>
		
		
</body>
</html>