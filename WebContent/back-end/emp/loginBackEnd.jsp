<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.emp.model.EmpVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>CA105G1:back-end:login</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
		  Launch demo modal
		</button>
		
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        ...
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary">Save changes</button>
		      </div>
		    </div>
		  </div>
		</div>
		
		
		<!-- ------------------------------------------------------------------------ -->
		
<!-- 		<a href='#modal-id' data-toggle="modal" class="btn btn-primary"> 後台 : 登入 </a> -->
<!-- 		<div class="modal fade" id="modal-id" tabindex="-1"> -->
<!-- 			<div class="modal-dialog"> -->
<!-- 				<div class="modal-content"> -->
<!-- 					<div class="modal-header"> -->
<!-- 						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
<!-- 						<h4 class="modal-title"> 後台 : 登入 </h4> -->
<!-- 					</div> -->
<!-- 					<div class="modal-body"> -->
<!-- 						內容區 -->
<%-- 						for test login --%>
<%-- 						<form method="post" action="<%=request.getContextPath()%>/emp/emp.do"> --%>
<!-- 							account  : <input type="text" name="emp_account" value="Peter1"><br> -->
<!-- 							passwoed : <input type="password" name="emp_psw" value="654321"><br> -->
<!-- 							<input type="hidden" name="action" value="emp_login"> -->

<%-- 						錯誤表列 --%>
<%-- 						<c:if test="${not empty errorMsgs}"> --%>
<!-- 							<ul> -->
<%-- 								<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 									<li style="color:red">${message}</li> --%>
<%-- 								</c:forEach> --%>
<!-- 							</ul> -->
<%-- 						</c:if>						 --%>
<!-- 						內容區 -->
<!-- 					</div> -->
<!-- 					<div class="modal-footer"> -->
<!-- 						<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button> -->
<!-- 						<button type="button" class="btn btn-primary">Save changes</button> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
		
		
		
		
		
		
		
		<!-- 
			---------------------------------------------------------------------------------
		 -->
<!-- 		<a href='#modal-id' data-toggle="modal"> 後台 : 登入 </a> -->
<!-- 		<div class="modal fade" id="modal-id" > -->
<!-- 			<div class="modal-dialog"> -->
<!-- 				<div class="modal-content"> -->
					
<!-- 					<div class="modal-header"> -->
<!-- 						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button> -->
<!-- 						<h4 class="modal-title"> 後台 : 登入 </h4> -->
<!-- 					</div> -->
					
<!-- 					<div class="modal-body"> -->

<%-- 						for test login --%>
<%-- 						<form method="post" action="<%=request.getContextPath()%>/emp/emp.do"> --%>
<!-- 							account  : <input type="text" name="emp_account" value="Peter1"><br> -->
<!-- 							passwoed : <input type="password" name="emp_psw" value="654321"><br> -->
<!-- 							<input type="hidden" name="action" value="emp_login"> -->

<%-- 						錯誤表列 --%>
<%-- 						<c:if test="${not empty errorMsgs}"> --%>
<!-- 							<ul> -->
<%-- 								<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 									<li style="color:red">${message}</li> --%>
<%-- 								</c:forEach> --%>
<!-- 							</ul> -->
<%-- 						</c:if> --%>

<!-- 					</div> -->
					
<!-- 					<div class="modal-footer"> -->
<!-- 						<button type="button" class="btn btn-default" data-dismiss="modal"> 關閉 </button> -->
<!-- <!-- 						<button type="button" class="btn btn-primary"> Login </button> --> -->
<!-- 							<input type="submit" value="login" class="btn btn-primary" /> -->
<!-- 						</from> -->
<!-- 					</div> -->
					
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	
	
		<%-- --------------------------------------------------------- --%>
		
		<script src="https://code.jquery.com/jquery.js"></script>
<!-- 		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>