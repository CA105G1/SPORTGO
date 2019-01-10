<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.emp.model.EmpVO"%>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTYGO!</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<style>
		input{
			height:30px
		}
		</style>
	</head>
	<body>
		<%-- include header --%>
		<%@ include file="/back-end/CA105G1_header_back.file" %>
		<%-- include show_loginBox--%>
		<%@ include file="/back-end/emp/loginfile/showLoginBackEnd.file" %>
		<!--  -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
				<!-- <h1>後台共用區</h1> -->
				<!-- <h2>here need include left_side_field.jsp</h2> -->
					<jsp:include page="/back-end/left_side_field.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9">
				
					<h1>This is the back-end index.</h1>

				

				
				
				
				
<!-- 	<h1>後台內容，使用tabs，也可自由發揮</h1> -->
<%-- 					<% 	Object object = session.getAttribute("empVO"); %> --%>
<%-- 					<%  EmpVO empVO = null; %> --%>
<%-- 					<%	if(object==null){ %> --%>
<%-- 							<jsp:include page="back-end/emp/loginBackEnd.jsp" flush="true" />	 --%>
<%-- 					<%	}else {  --%>
<!--  							empVO = (EmpVO)object; -->
<%-- 							if(empVO.getEmp_psw()==null){ %> --%>
<%-- 								<jsp:include page="back-end/emp/loginBackEnd.jsp" flush="true" /> --%>
<%-- 					<%		}else{ %> --%>
<%-- 								${empVO.emp_name}-登入成功	<br> --%>
<%-- 								<form method="post" action="<%=request.getContextPath()%>/emp/emp.do"> --%>
<!-- 									<input type="hidden" name="action" value="show_registered_view"/> -->
<!-- 									新增員工: <input type="submit" value="registered emp"/> -->
<!-- 								</form> -->
<%-- 					<%		} %> --%>
<%-- 					<%  } %> --%>
<%-- 					------------------------------------------------------------ --%>
<%-- 					test for registered --%>
<%-- 					<% String show_registered_view = request.getParameter("action"); %> --%>
<%-- 					<% if("show_registered_view".equals(show_registered_view) && !"no_auth".equals(request.getAttribute("no_auth"))){ %> --%>
<%-- 							<jsp:include page="back-end/emp/registeredEmp.jsp"></jsp:include> --%>
<%-- 					<% } else { %> --%>
<%-- 							錯誤表列 --%>
<%-- 							<c:if test="${not empty errorMsgs}"> --%>
<!-- 								<ul> -->
<%-- 									<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 										<li style="color:red">${message}</li> --%>
<%-- 									</c:forEach> --%>
<!-- 								</ul> -->
<%-- 							</c:if> --%>
<%-- 							--------------------------------------------------------- --%>
<%-- 					<% } %> --%>
<%-- 					------------------------------------------------------------ --%>
					
					
					
				</div>
			</div>
		</div>



		<%@ include file="/back-end/CA105G1_footer_back.file" %>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>