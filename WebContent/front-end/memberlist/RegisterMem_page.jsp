<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTGO 會員註冊</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<style type="text/css">
			.btn{display: flex;}
			.error{color:red;}
			img{width:100%;
				height:100%;}
		</style>
</head>
<body>
	<jsp:include page="/front-end/CA105G1_header.jsp"/>
	<form method="post" enctype="multipart/form-data" action="Register.do">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-sm-offset-3">
					<h1 align="center">會員註冊</h1>
					<c:if test="${not empty errorMsgs}">
						<ul class="error">
							<c:forEach var="message" items="${errorMsgs}">
								<li>${message.value}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					<div>
						<label>照片</label>
						<input type="file" name="picture" class="upl">
						<img class="preview" src="<%=request.getContextPath()%>/img/mem_no.jpg">
					</div>
					<div class="form-group">
						<label for="account">帳號</label>
						<input type="text" name="account" 
						class="form-control" value="${param.account}">
					<div class="form-group">
						<label for="password">密碼</label>
						<input type="password" name="password" 
						class="form-control" value="${param.password}">
					</div>
					<div class="form-group">
						<label for="name">姓名</label>
						<input type="text" name="name" 
						class="form-control" value="${param.name}">
					</div>
					<div class="form-group">
						<label for="nick">暱稱</label>
						<input type="text" name="nick" 
						class="form-control" value="${param.nick}">
					</div>
					<div class="form-group">
						<label for="email">電子郵件</label>
						<input type="text" name="email" 
						class="form-control" value="${param.email}">
					</div>
					<div class="form-group">
						<label for="phone">手機號碼</label>
						<input type="text" name="phone" 
						class="form-control" value="${param.phone}">
					</div>
					<div class="form-group">
						<label for="emgc">緊急聯絡人</label>
						<input type="text" name="emgc" 
						class="form-control" value="${param.emgc}">
					</div>
					
					<div class="form-group">
						<label for="emgcphone">緊急聯絡人電話</label>
						<input type="text" name="emgcphone" 
						class="form-control" value="${param.emgcphone}">
					</div>
					<div class="col-xs-12 col-sm-6">
						<center>
							<button type="submit" name="button"
							value="register" class="btn btn-info">註冊</button>
						</center>
					</div>
					<div class="col-xs-12 col-sm-6">
						<center>
							<button type="submit" name="button"
							value="cancel" class="btn btn-info">取消</button>
						</center>
					</div>
					</div>
				</div>
			</div>

		</div>
	</form>	
	<jsp:include page="/front-end/CA105G1_footer.jsp"/>
	
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