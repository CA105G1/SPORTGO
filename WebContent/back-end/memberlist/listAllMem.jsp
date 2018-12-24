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
		<title>所有的會員</title>
		
		<style type="text/css">
			.error{
				color:red;
			}
		
		</style>
</head>
<body>
	<!-- 錯誤資訊 -->
	<c:if test="${not empty errorMsgs}">
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li class="error">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
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
							<td>${MemberlistVO.mem_pic}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>	


		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>