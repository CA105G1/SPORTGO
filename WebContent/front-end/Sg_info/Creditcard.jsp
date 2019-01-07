<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.memberlist.model.*" %>
<jsp:useBean id="memberlistVO" scope="session" class="com.memberlist.model.MemberlistVO"/>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<title>SPORTGO 會員頁面</title>
		<style type="text/css">
			body{
				text-align:center;
			}
			.container{
				width: 100%;
			}
			center{
				font-size: xx-large;
				color: red;
			}
			.error{
				color:red;
			}
		</style>
	</head>
	<body>
		<%@ include file="/front-end/CA105G1_header.file"%>
		
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
				</div>
				<div class="col-xs-12 col-sm-9 tab-content">
				<!-- 信用卡管理 -->
				<c:if test="${not empty errorMsgs}">
				<ul class="error">
					<c:forEach var="message" items="${errorMsgs}">
						<li>${message.value}</li>
					</c:forEach>
				</ul>
				</c:if>
				<form method="post" action="MemManager.do" style="text-align:center;width:80%">
					<div class="form-group" style="display:flex;justify-content:center;">
					      <label class="control-label col-xs-12 col-sm-5" for="card">信用卡卡號</label>
					      <div class="col-xs-12 col-sm-5">
					        <input type="number" class="form-control" id="card" value="${mem_card}" name="card">
					      </div>
			   		</div>
			   		<div class="form-group" style="display:flex;justify-content:center;">
					      <label class="control-label col-xs-12 col-sm-5" for="expiry">信用卡到期日</label>
					      <div class="col-xs-12 col-sm-5" style="display:flex;justify-content:space-between;">
					        <input type="number" class="form-control" id="expiry1" value="" name="expiry1" style="width:40%">
					        <label style="text-align:center;">年</label>
					        <input type="number" class="form-control" id="expiry2" value="" name="expiry2" style="width:40%">
					        <label>月</label>
					      </div>
			   		</div>
					<div>
					      <div class="col-sm-offset-6 col-xs-12 col-sm-5" >
					      	<input type="hidden" name="action" value="renew_Card">
					        <button type="submit" class="btn btn-info">更新</button>
					        <button type="submit" class="btn btn-info" name="action" value="cancel">取消</button>
					      </div>
			    	</div>
				</form>
				
				
				
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/SportyGo_Footer.html"/>
	<script>
	</script>
	</body>
</html>