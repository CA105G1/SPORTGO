<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
	${empVO_forNewOne.emp_name}，註冊成功。<br>
	<table border="1">
		<tr>
			<th>emp_no</th>
			<th>emp_name</th>
			<th>emp_auth</th>
			<th>emp_phone</th>
			<th>emp_email</th>
			<th>emp_account</th>
			<th>emp_psw</th>
			<th>hiredate</th>
			<th>leavedate</th>
		</tr>	
		<tr>
			<td>${empVO_forNewOne.emp_no}</td>
			<td>${empVO_forNewOne.emp_name}</td>
			<td>${empVO_forNewOne.emp_auth}</td>
			<td>${empVO_forNewOne.emp_phone}</td>
			<td>${empVO_forNewOne.emp_email}</td>
			<td>${empVO_forNewOne.emp_account}</td>
			<td>${empVO_forNewOne.emp_psw}</td>
			<td><fmt:formatDate value="${empVO_forNewOne.hiredate}" pattern="yyyy-MM-dd HH:mm"/></td>
			<td><fmt:formatDate value="${empVO_forNewOne.leavedate}" pattern="yyyy-MM-dd HH:mm"/></td>
		</tr>	
	</table>
	
</body>
</html>