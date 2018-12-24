<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.memberlist.model.*" %>
<%-- <% MemberlistVO MemVO = (MemberlistVO) request.getAttribute("memberlist");%> --%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<title>個人資料頁面</title>
</head>
<body>
	<div class="container">
		<ul class="list">
			
			<li>編號 : ${MemberlistVO.mem_no}</li>
			<li>姓名 : ${MemberlistVO.mem_name}</li>
			<li>暱稱 : ${MemberlistVO.mem_nick}</li>
			<li>帳號 : ${MemberlistVO.mem_account}</li>
			<li>密碼 : ${MemberlistVO.mem_pswd}</li>
			<li>Email : ${MemberlistVO.mem_email}</li>
			<li>電話 : ${MemberlistVO.mem_phone}</li>
			<li>緊急聯絡人 : ${MemberlistVO.mem_emgc}</li>
			<li>緊急聯絡人電話 : ${MemberlistVO.mem_emgcphone}</li>
		</ul>
	</div>
	
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>