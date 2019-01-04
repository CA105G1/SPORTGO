<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTGO 送貨地址</title>
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
	<form method="post" action="Address.do">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-sm-offset-3">
					<h1 align="center">送貨地址</h1>
					<c:if test="${not empty errorMsgs}">
						<ul class="error">
							<c:forEach var="message" items="${errorMsgs}">
								<li>${message.value}</li>
							</c:forEach>
						</ul>
					</c:if>
					
					<div class="form-group">
						<label for="receiver">收件人姓名</label>
						<input type="text" name="receiver" 
						class="form-control" value="${param.receiver}">
					</div>
					<div class="form-group">
						<label for="phone">收件人電話</label>
						<input type="text" name="phone" 
						class="form-control" value="${param.phone}">
					</div>
					<div class="form-group">
						<label for="country">國家</label>
						<input type="text" name="country" 
						class="form-control" value="${param.country}">
					</div>
					<div class="form-group">
						<label for="city">城市</label>
						<input type="text" name="city" 
						class="form-control" value="${param.city}">
					</div>
					<div class="form-group">
						<label for="detail">地址</label>
						<input type="text" name="detail" 
						class="form-control" value="${param.detail}">
					</div>
					<div class="form-group">
						<label for="zip">郵遞區號</label>
						<input type="text" name="zip" 
						class="form-control" value="${param.zip}">
					</div>
					<div class="col-xs-12 col-sm-6">
						<center>
							<button type="submit" name="action"
							value="add_address" class="btn btn-info">新增</button>
						</center>
					</div>
					<div class="col-xs-12 col-sm-6">
						<center>
							<button type="submit" name="action"
							value="cancel" class="btn btn-info">取消</button>
						</center>
					</div>
				</div>
			</div>
		</div>
	</form>	
				<form method="post" action="Address.do"  class="grid-item">
					<button type="submit" name="action"
								value="Member_address" class="btn btn-info">查詢</button>
					<c:forEach var="address" items="${addresslist}">
						<div>
							${address.receiver}<br>
							${address.receiver_phone}<br>
							${address.country}<br>
							${address.city}<br>
							${address.addr_detail}<br>
							${address.addr_zip}<br>
							<input type="hidden" name="addr_no" value="${address.addr_no}">
							<button type="submit" class="btn btn-danger" name="action" value="delete_address">刪除</button>
						</div>
					</c:forEach>			
				</form>			
	
<script>
</script>
		
		
</body>
</html>