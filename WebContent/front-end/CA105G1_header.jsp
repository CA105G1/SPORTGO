<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title></title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<style type="text/css">
			.navbar-brand {
				padding: 0px; /* firefox bug fix */
			}
			.navbar-brand>img {
				height: 120%;
				padding: 15px; /* firefox bug fix */
				width: auto;
			}
			/*使用flex-水平置中*/
			.navbar-myself-center{
				display: flex;
				justify-content:center;
			}
		</style>
	</head>
	<body> 
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="row">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
						<span class="sr-only">選單切換</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand myNoWrap" href="<%=request.getContextPath()%>/index.jsp">
						<img src="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.png" alt="SportGo!"/>
					</a>
				</div>
					
				<!-- 手機隱藏選單區 -->
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<!-- 左選單 -->
					<ul class="nav navbar-nav">
						<li class="active"><a href="<%=request.getContextPath()%>/index.jsp">SportyGo!</a></li>
						<li><a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">揪團去</a></li>
						<li><a href="<%=request.getContextPath()%>/front-end/club/club_list.jsp">社團</a></li>
					</ul>
				
					<!-- 搜尋表單 -->
					<form class="navbar-form navbar-right" role="search">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="請輸入關鍵字">
						</div>
						<button type="submit" class="btn btn-default">搜尋</button>
						<a href="<%=request.getContextPath()%>/backEndIndex.jsp">後台首頁</a>
					</form>
				
					<!-- 右選單 -->
					<ul class="nav navbar-nav navbar-right">
						<li><a href="<%=request.getContextPath()%>/front-end/pro/listAllPro_front.jsp"><i class="glyphicon glyphicon-shopping-cart"></i> 商城 </a></li>
						<li>
							<c:if test="${memberlistVO==null}">
								<a href="#">訪客，您好</a>
							</c:if>
							<c:if test="${!(memberlistVO==null)}">
								<a href="#">${memberlistVO.mem_name}，您好</a>
							</c:if>
						</li>
						<li>
							<c:if test="${memberlistVO==null}">
								<a href="<%=request.getContextPath()%>/front-end/memberlist/Login.jsp">登入/註冊</a>
							</c:if>
							<c:if test="${!(memberlistVO==null)}">
								<a href="<%=request.getContextPath()%>/front-end/memberlist/logout.do">登出</a>
							</c:if>
						</li>
						
					</ul>
				</div>
				<!-- 手機隱藏選單區結束 -->
			</div>
		</div>
	</nav>
	<div style="height:50px"></div>
	<div class="container-fluid">
		<div class="row">
			<nav class="navbar navbar-default" role="navigation">
				<div class="navbar-myself-center">
					<ul class="nav navbar-nav navbar-form">
						<li ><a href="#">首頁</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								關於我們
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">list01</a></li>
								<li><a href="#">list02</a></li>
								<li><a href="#">list03</a></li>
							</ul>
						</li>
						
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								會員專區
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">Member01</a></li>
								<li><a href="#">Member02</a></li>
								<li><a href="#">Member03</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								　揪團　
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">建立揪團</a></li>
								<li><a href="#">瀏覽揪團</a></li>
								<li><a href="#">list03</a></li>
							</ul>
						</li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								　社團　
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">建立社團</a></li>
								<li><a href="#">瀏覽社團</a></li>
								<li><a href="#">list03</a></li>
							</ul>
						</li>
						
						<li><a href="#">　賽事　</a></li>
						<li><a href="#">　場地　</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								　商城　
								<!-- <b class="caret"></b> -->
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">list01</a></li>
								<li><a href="#">list02</a></li>
								<li><a href="#">list03</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</div>	
	</div>
			
		<script src="https://code.jquery.com/jquery.js"></script>
<!-- 		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>