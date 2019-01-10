<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>

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
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
						<span class="sr-only">選單切換</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand myNoWrap" href="#">
						<img src="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.png" alt="SportyGo!"/>
					</a>
				</div>		
				<!-- 手機隱藏選單區 -->
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					
					<!-- 左選單 -->
					<ul class="nav navbar-nav">
						<li class="active"><a href="<%=request.getContextPath()%>/index.jsp">SportGo! 前台首頁 </a></li>
					</ul>
				
					<!-- 搜尋表單 -->
					<form class="navbar-form navbar-right" role="search">
						<div class="form-group">
							<input type="text" class="form-control" placeholder="請輸入關鍵字">
						</div>
						<button type="submit" class="btn btn-default">搜尋</button>
					</form>
				
					<!-- 右選單 -->
					<ul class="nav navbar-nav navbar-right">
						<li><a href="<%=request.getContextPath()%>/backEndIndex.jsp"> 後台首頁 </a></li>
						<li>
							<c:if test="${empVO==null || empVO.emp_psw==null}">
								<a href="#">訪客，您好</a>
							</c:if>
							<c:if test="${!(empVO==null || empVO.emp_psw==null)}">
								<a href="#">${empVO.emp_name}，您好</a>
							</c:if>
						</li>
						<li>
							<c:if test="${empVO==null || empVO.emp_psw==null}">
						<%--		<%@ include file="/back-end/emp/loginfile/checkHasLogin.file" %>  --%>
								<a href="#myModalId" data-toggle="modal"> 後台 : 登入 </a>
								<div class="modal fade" id="myModalId" style="z-index:9999999">
									<div class="modal-dialog">
										<div class="modal-content">
										
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title"> 後台 : 登入 </h4>
											</div>
												
											<div class="modal-body">
							
												<%-- for test login--%>
								      			<form method="post" action="<%=request.getContextPath()%>/emp/emp.do">
													account  : <input type="text" name="emp_account" value="Peter1"><br>
													passwoed : <input type="password" name="emp_psw" value=""><br>
													<input type="hidden" name="action" value="emp_login">
													<input type="submit" value="login" class="btn btn-primary" />		
								      			</form>
												
												<%-- 錯誤表列 --%>
												<c:if test="${not empty errorMsgs}">
													<ul>
														<c:forEach var="message" items="${errorMsgs}">
															<li style="color:red">${message}</li>
														</c:forEach>
													</ul>
												</c:if>
							
											</div>
												
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal"> 關閉 </button>
											<!--	<button type="button" class="btn btn-primary"> Login </button> -->
										
								
											</div>
												
										</div>
									</div>
								</div>
								
							</c:if>
							<c:if test="${!(empVO==null || empVO.emp_psw==null)}">
								<a href="<%=request.getContextPath()%>/emp/emp.do?action=emp_logout">後台:登出</a>
							</c:if>
						</li>			
					</ul>
					
					
				</div>
				<!-- 手機隱藏選單區結束 -->
			</div>
		</nav>
		<div style="height:50px"></div>
<!-- 		<script src="https://code.jquery.com/jquery.js"></script> -->
	</body>
</html>