<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title></title>
<!-- 		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
		<style type="text/css">
		div.footer{
			clear:both;
			width:100%;
			position:absolute;
			bottom:0; /* 設置位置於下方 */
			height:80px;
			background-color:#4d5363;
		}
		/*使用flex-水平置中*/
		.navbar-myself-center{
			display: flex;
			justify-content:center;
		}
		</style>
	</head>
	<body> 
	<div style="height:50px;width:50px"></div>
	<div class="container-fluid">
	
    <nav class="navbar navbar-expand-md navbar-light bg-light">

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse d-flex justify-content-center" id="navbarsExampleDefault">
            <ul class="navbar-nav ">
              <li class="nav-item "><a class="nav-link" href="<%=request.getContextPath()%>/index.jsp">首頁</a></li>
              <li class="nav-item "><a class="nav-link" href="/">關於我們</a></li>
              <li class="nav-item "><a class="nav-link" href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp">會員專區</a></li>
              <li class="nav-item "><a class="nav-link" href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">揪團</a></li>
              <li class="nav-item "><a class="nav-link" href="<%=request.getContextPath()%>/front-end/club/club_list.jsp">社團</a></li>
              <li class="nav-item "><a class="nav-link" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp">商城</a></li>
              <li class="nav-item "><a class="nav-link" href="<%=request.getContextPath()%>/front-end/venue/venue_query_info_by_composite_front.jsp">場地</a></li>
            </ul>
        </div>
    </nav>
	
		</div>
		<div class="h3 navbar-myself-center">@ SportGo! 2018</div>
			
<!-- 	<script src="https://code.jquery.com/jquery.js"></script> -->
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>