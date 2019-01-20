<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.news.model.NewsVO"%>
<%@ page import="com.newstype.model.NewstypeVO"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta name="description" content="">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<title>CA105G1:SportGo!</title>
<!-- 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
		
		<!-- Favicon -->
    	<link rel="icon" href="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.pngy">

    	<!-- Core Stylesheet -->
    	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    	<script src="<%=request.getContextPath()%>/front-end/pro/TWzipcode/jquery.twzipcode.min.js"></script>

		<style>
/* 	.grid-container{  */
/*  				grid-template-columns:repeat(3,33.33%); */ */
/*  				grid-gap:50px;  */
/* 			}  */
		</style>

	</head>
	<body>
<%-- 		<jsp:include page="/front-end/pro/alazea-gh-pages/header.jsp"/>  --%>
		<jsp:include page="/front-end/CA105G1_header_bt4.jsp" />
<%-- 		<jsp:include page="/front-end/pro/alazea-gh-pages/header.jsp"/> --%>


<%-- 		<div class="container-fluid">${newsVOList.size()}</div> --%>
		
<%-- 		<div>--------${newsTypeVOList}</div> --%>
		<div>
			<%-- 最新消息---跑馬燈 --%>
			<jsp:include page="/front-end/indexPutNewsCarousel.jsp" />
		</div>
		<div style="height:50px"></div>
		
		
		<%-- 各個運動連結 --%>
		
		<div class="container-fluid"  >
			<div class="row">
				<div class="col-xs-12 col-sm-1"></div>
				<div class="col-xs-12 col-sm-10 " style="display:flex;flex-flow:row wrap;justify-content: center;">
					<!-- baseball -->
					<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP001"
					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;">
						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
							<img src="img/indexImg/baseball.png" style="height:100%;width:100%;position:absolute;"/>
						</div>
					</a>
					
					<!-- volleyball.png -->
					<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP002"
					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;">
						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
							<img src="img/indexImg/volleyball.png" style="height:100%;width:100%;position:absolute;"/>
						</div>
					</a>
					<!-- 	basketball.png -->
					<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP003"
					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;">
						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
							<img src="img/indexImg/basketball.png" style="height:100%;width:100%;position:absolute;"/>
						</div>
					</a>					
					<!--tennis.png -->
					<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP004"
					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;">
						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
							<img src="img/indexImg/tennis.png" style="height:100%;width:100%;position:absolute;"/>
						</div>
					</a>
					<!-- badminton.png -->
					<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP005"
					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;">
						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
							<img src="img/indexImg/badminton.png" style="height:100%;width:100%;position:absolute;"/>
						</div>
					</a>
					<!-- running.png -->
					<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP006"
					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;">
						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
							<img src="img/indexImg/running.png" style="height:100%;width:100%;position:absolute;"/>
						</div>
					</a>
					<!-- bicycle.png -->
					<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP007"
					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;">
						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
							<img src="img/indexImg/bicycle.png" style="height:100%;width:100%;position:absolute;"/>
						</div>
					</a>
<!-- 					<a href="img/no-image.PNG" -->
<!-- 					style="display:flex;flex-direction:column;width:calc(100% / 7 - 30px);margin:10px;"> -->
<!-- 						<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;"> -->
<!-- 							<img src="img/no-image.PNG" style="height:100%;width:100%;position:absolute;"/> -->
<!-- 						</div> -->
<!-- 					</a> -->
				</div>
				<div class="col-xs-12 col-sm-1"></div>
			</div>
		</div>
		
		
		
		
		<%-- 推薦揪團區 --%>
		<%-- 左側MAP --%>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-1"></div>
				<div class="col-xs-12 col-sm-10">
					<jsp:include page="/front-end/Sg_infoByMap.jsp" />			
				</div>
				<div class="col-xs-12 col-sm-1"></div>
			</div>
		</div>
		
		<%-- 右側推薦揪團列表 --%>
		
		


		<%-- footer目前尚缺連結點 --%>
<%-- 		<%@ include file="front-end/CA105G1_footer.file" %> <!--請更正成下一行-->--%>
		<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />
<%-- 		<jsp:include page="/front-end/pro/alazea-gh-pages/CA105G1_footer.jsp"/> --%>
		
    <!-- ##### All Javascript Files ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>

<!-- 		<script src="https://code.jquery.com/jquery.js"></script> -->
<!-- 		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>