<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.memberlist.model.*" %>
<%
	MemberlistService service = new MemberlistService();
	List<MemberlistVO> list = service.getAllMem();
	pageContext.setAttribute("memberlist", list);
%>
<!DOCTYPE html>
<html>
<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<title>後台首頁</title>
		
		<style type="text/css">
			.error{
				color:red;
			}
		
		</style>
</head>
<body>
	<jsp:include page="/back-end/CA105G1_header_back.jsp"/>
<!-- 	<!-- 錯誤資訊 -->
<%-- 	<c:if test="${not empty errorMsgs}"> --%>
<!-- 		<ul> -->
<%-- 			<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 				<li class="error">${message}</li> --%>
<%-- 			</c:forEach> --%>
<!-- 		</ul> -->
<%-- 	</c:if> --%>
<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="/back-end/left_side_field.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9">
					<h1>會員列表</h1>
	<table class="table table-hover">
					<thead>
						<tr>
							<th>會員編號</th>
							<th>會員名稱</th>
							<th>會員暱稱</th>
							<th>會員帳號</th>
							<th>會員密碼</th>
							<th>會員電子信箱</th>
							<th>會員電話</th>
							<th>會員緊急聯絡人</th>
							<th>會員緊急聯絡人電話</th>
							<th>會員狀態</th>
							<th>會員照片</th>
						</tr>
					</thead>
					<tbody>
						<% pageContext.getAttribute("memberlist"); %>
						<c:forEach var="MemberlistVO" items="${memberlist}">
							<tr>
								<td>${MemberlistVO.mem_no}</td>
								<td>${MemberlistVO.mem_name}</td>
								<td>${MemberlistVO.mem_nick}</td>
								<td>${MemberlistVO.mem_account}</td>
								<td>${MemberlistVO.mem_pswd}</td>
								<td>${MemberlistVO.mem_email}</td>
								<td>${MemberlistVO.mem_phone}</td>
								<td>${MemberlistVO.mem_emgc}</td>
								<td>${MemberlistVO.mem_emgcphone}</td>
								<td>${MemberlistVO.mem_status}</td>
								<td>
							<a href="/CA105G1/front-end/memberlist/public_Member_page.jsp?mem_no=${MemberlistVO.mem_no}">
								<img src="<%=request.getContextPath()%>
									/front-end/memberlist/showPicture.do?mem_no=${MemberlistVO.mem_no}"
									style="max-width:50px;max-height:50px;">
							</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
				</div>
		</div>
	</div>

<%@ include file="/back-end/CA105G1_footer_back.file" %>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>