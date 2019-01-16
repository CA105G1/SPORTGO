<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
					
				</div>
					
				<!-- 手機隱藏選單區 -->
				<div class="collapse navbar-collapse navbar-ex1-collapse">
					<!-- 左選單 -->
					<ul class="nav navbar-nav">
						<li>
<!-- 							<div class="navbar-header"> -->
<!--     							<a href="#" class="navbar-left"> -->
<!--        								 <img src="/path/to/image.png"> -->
<!-- 							    </a> -->
<!-- 							</div> -->
							<a class="navbar-left center-block" href="<%=request.getContextPath()%>/index.jsp">
								<img style="height: 20px;"
								src="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.png" alt="SportGo!"/>
							</a>
						</li>
						<li class="active"><a href="<%=request.getContextPath()%>/index.jsp">SportyGo!</a></li>
						<li><a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">揪團去</a></li>
						<li><a href="<%=request.getContextPath()%>/front-end/club/club_list.jsp">社團</a></li>
					</ul>
				
<!-- 					搜尋表單 -->
<!-- 					<form class="navbar-form navbar-right" role="search"> -->
<!-- 						<div class="form-group"> -->
<!-- 							<input type="text" class="form-control" placeholder="請輸入關鍵字"> -->
<!-- 						</div> -->
<!-- 						<button type="submit" class="btn btn-default">搜尋</button> -->
<!-- 					</form> -->
				
					<!-- 右選單 -->
					<ul class="nav navbar-nav navbar-right">
						<li><a href="<%=request.getContextPath()%>/front-end/pro/listAllPro_front.jsp"><i class="glyphicon glyphicon-shopping-cart"></i> 購物車 </a></li>
						<c:if test="${memberlistVO==null}">
							<li>
								<a href="#">訪客，您好</a>
							</li>
							<li>
								<%  
									//String tempClub_no = request.getParameter("club_no");
// 									session = request.getSession();
// 									if(!"/CA105G1/front-end/memberlist/Login.jsp".equals(request.getRequestURI())){
// 										session.setAttribute("location",request.getRequestURI());
// 										//session.setAttribute("tempClub_no", tempClub_no);
// 									}
									System.out.println("log_in_location :　"+ request.getRequestURI());
								%>
								<a href="<%=request.getContextPath()%>/front-end/memberlist/Login.jsp">登入/註冊</a>
<%-- 								<a href="<%=request.getContextPath()%>/front-end/memberlist/Login.jsp?club_no=${tempClub_no}">登入/註冊</a> --%>
							</li>
						</c:if>
						<c:if test="${!(memberlistVO==null)}">
							<li>
								<a href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp">${memberlistVO.mem_name}，您好</a>
							</li>
							<li>
								<a href="#" >通知</a>
							</li>
							<li>
								<%  
// 									session = request.getSession();
// 									if(!"/CA105G1/front-end/memberlist/Login.jsp".equals(request.getRequestURI())){
// 										session.setAttribute("location",request.getRequestURI()); 
// 									}
// // 									session.removeAttribute("tempClub_no"); // 登入移除 club_no
									System.out.println("log_out_location :　"+ request.getRequestURI());
								%>
								<a href="<%=request.getContextPath()%>/front-end/memberlist/logout.do">登出</a>
							</li>
						</c:if>
						<li><a href="<%=request.getContextPath()%>/backEndIndex.jsp">後台首頁</a></li>
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
						<li ><a href="<%=request.getContextPath()%>/index.jsp">　首頁　</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								關於我們
								<b class="caret"></b>
							</a>
							<ul class="dropdown-menu">
								<li><a href="#">動機</a></li>
<!-- 								<li><a href="#">要做啥阿...2</a></li> -->
<!-- 								<li><a href="#">.......</a></li> -->
							</ul>
						</li>
						
						<li><a href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp">　會員專區　</a></li>
<!-- 						<li class="dropdown"> -->
<!-- 							<a href="#" class="dropdown-toggle" data-toggle="dropdown"> -->
<!-- 								會員專區 -->
<!-- 								<b class="caret"></b> -->
<!-- 							</a> -->
<!-- 							<ul class="dropdown-menu"> -->
<%-- 								<li><a href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp">個人頁面</a></li> --%>
<!-- 								<li><a href="#">Member02</a></li> -->
<!-- 								<li><a href="#">Member03</a></li> -->
<!-- 							</ul> -->
<!-- 						</li> -->
						
						<li><a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">　揪團　</a></li>
<!-- 						<li class="dropdown"> -->
<%-- 							<a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" class="dropdown-toggle" data-toggle="dropdown"> --%>
<!-- 								　揪團　 -->
<!-- 								<b class="caret"></b> -->
<!-- 							</a> -->
<!-- 							<ul class="dropdown-menu"> -->
<!-- 								<li><a href="#">建立揪團</a></li> -->
<!-- 								<li><a href="#">瀏覽揪團</a></li> -->
<!-- 								<li><a href="#">list03</a></li> -->
<!-- 							</ul> -->
<!-- 						</li> -->

						<li><a href="<%=request.getContextPath()%>/front-end/club/club_list.jsp">　社團　</a></li>
<!-- 						<li class="dropdown"> -->
<%-- 							<a href="<%=request.getContextPath()%>/front-end/club/club_list.jsp" class="dropdown-toggle" data-toggle="dropdown"> --%>
<!-- 								　社團　 -->
<!-- 								<b class="caret"></b> -->
<!-- 							</a> -->
<!-- 							<ul class="dropdown-menu"> -->
<!-- 								<li><a href="#">建立社團</a></li> -->
<!-- 								<li><a href="#">瀏覽社團</a></li> -->
<!-- 								<li><a href="#">list03</a></li> -->
<!-- 							</ul> -->
<!-- 						</li> -->
						
<!-- 						<li><a href="#">　賽事(暫時刪除)　</a></li> -->
						<li><a href="<%=request.getContextPath()%>/front-end/venue/venue_query_info_by_composite_front.jsp">　場地　</a></li>
												
						<li><a href="<%=request.getContextPath()%>/front-end/pro/listAllPro_front.jsp">　商城　</a></li>
<!-- 						<li class="dropdown"> -->
<%-- 							<a href="<%=request.getContextPath()%>/front-end/pro/listAllPro_front.jsp" class="dropdown-toggle" data-toggle="dropdown"> --%>
<!-- 								　商城　 -->
<!-- 								<b class="caret"></b> -->
<!-- 							</a> -->
<!-- 							<ul class="dropdown-menu"> -->
<!-- 								<li><a href="#">list01</a></li> -->
<!-- 								<li><a href="#">list02</a></li> -->
<!-- 								<li><a href="#">list03</a></li> -->
<!-- 							</ul> -->
<!-- 						</li> -->
					</ul>
				</div>
			</nav>
		</div>	
	</div>
			
<!-- 		<script src="https://code.jquery.com/jquery.js"></script> -->
<!-- 		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
	
	<script>
// 		$(function(){
// 			$('.dropdown-toggle').on('mouseenter',new function(){
				
// 			});
// 		});
		//沒用的垃圾
// 		window.addEventListener("load", function(){
// 			document.getElementById("login_header").addEventListener("click", function(){
// 				document.location.href="/CA105G1/front-end/memberlist/Login.jsp";
// 				return;
// 			},false);			
// 		},false);
		
// 		$("#joinbtn").click(function(){
// 			 //原頁面VO由session帶著去跟回
// 			document.location.href="/CA105G1/front-end/memberlist/Login.jsp";
// 			return;
// 		});
		
	</script>
	
	
</html>