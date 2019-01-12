<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html >
	<head>
	 	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
		
	</head>

	<body>
	
		<div class="container-fluid">
			<div class="row">
<!------- 放外面 ------->
<!-- <h4 id="club_name" class="_19s-" > -->
<%-- 	<a href='<%=request.getContextPath()%>/clubfront.do?actionfront=getOneClub&club_no=${clubVO.club_no}' > --%>
<%-- 		${clubVO.club_name} --%>
<!-- 	</a> -->
<!-- </h4> -->

					<div class="list-group active">
						<a href="<%= request.getContextPath()%>/clubfront.do?actionfront=getOneClubintro&club_no=${clubVO.club_no}" class="list-group-item">簡介</a>
						<a href="<%= request.getContextPath()%>//front-end/club/Sg_infoCreateForClub.jsp?club_no=${clubVO.club_no}" class="list-group-item">專屬揪團</a>
						<a href="#" class="list-group-item" role="tab" id="myCreatePost">建立貼文</a>
						<a href="#" class="list-group-item">影音相簿</a>
						<a href="<%= request.getContextPath()%>/clubfront.do?actionfront=getOneClubmanage&club_no=${clubVO.club_no}" class="list-group-item">社團管理</a>
						<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp"class="list-group-item">返回列表</a>
					</div>	
					
<!------- 放外面 ------->	
<%-- <button type="button" class="btn btn-dark" href="<%=request.getContextPath()%>/clubmemberlist.do?action=dropoutclub&club_no=${clubVO.club_no}"> --%>
<!-- 		退出社團 -->
<!-- </button>			 -->
					
			</div>
		</div>
	</body>
</html>