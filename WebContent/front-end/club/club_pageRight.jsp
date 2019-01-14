<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.club.model.*"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<title>club_pageRight</title>
	</head>
	<body>
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<h4 id="club_name" class="_19s-" >
					<a href='club_page.jsp?club_no=${clubVO.club_no}' >
						${clubVO.club_name}
					</a>
				</h4>
				<div class="list-group active">
					<a href="<%= request.getContextPath()%>/front-end/club/club_intro_page.jsp" class="list-group-item">簡介</a>
					<a href="<%= request.getContextPath()%>/front-end/club/Sg_infoList.jsp" class="list-group-item">專屬揪團</a>
					<a href="#" class="list-group-item" role="tab" id="myCreatePost">建立貼文</a>
					<a href="#" class="list-group-item">影音相簿</a>
					<a href="<%= request.getContextPath()%>/clubfront.do?actionfront=getOneClubmanage&club_no=${clubVO.club_no}" class="list-group-item">社團管理</a>
					<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp"class="list-group-item">返回列表</a>
				</div>	
				<button type="button" class="btn btn-dark" href="<%=request.getContextPath()%>/clubmemberlist.do?action=dropoutclub&club_no=${clubVO.club_no}">
					退出社團
				</button>	
			</div>
		</div>
	</body>
</html>