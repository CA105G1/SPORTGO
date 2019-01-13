<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.news.model.NewsVO"%>
<%@ page import="com.newstype.model.NewstypeVO"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>CA105G1:SportyGo!</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
/* 	.grid-container{  */
/*  				grid-template-columns:repeat(3,33.33%); */ */
/*  				grid-gap:50px;  */
/* 			}  */
		
		</style>

	</head>
	<body>
		<%-- header目前尚缺連結點 --%>
<%-- 	<%@ include file="/front-end/CA105G1_header.file" %> <!--請更正成下一行--> --%>
		<jsp:include page="/front-end/CA105G1_header.jsp" />

<%-- 		<div class="container-fluid">${newsVOList.size()}</div> --%>
		
<%-- 		<div>--------${newsTypeVOList}</div> --%>
		<div class="container-fluid">
			<%-- 最新消息---跑馬燈 --%>
			<jsp:include page="/front-end/indexPutNewsCarousel.jsp" />

		</div>
		<div style="height:50px"></div>
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

		<%-- 各個運動連結 --%>
		<div style="height:500px"></div>
		<div class="container"  style="display:flex;flex-flow:row wrap;">
				<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP001"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
<!-- 					<a href="img/indexImg/SP001.jpg"> -->
						<img src="img/indexImg/SP001.jpg" 
						style="height:100%;position:absolute;"/>
					</div>
				</a>
<!-- 					<a href="https://www.youtube.com/watch?v=oY2nVQNlUB8"> -->
				<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP002"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
						<img src="img/indexImg/fun01.jpg" style="height:100%;position:absolute;"/>
					</div>
				</a>
<!-- 					<a href="img/indexImg/fun03.jpg"> -->
				<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP003"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
						<img src="img/indexImg/fun03.jpg" style="height:100%;position:absolute;"/>
					</div>
				</a>					
<!-- 					<a href="img/indexImg/SP004.jpg"> -->
				<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP004"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
						<img src="img/indexImg/SP004.jpg" style="height:100%;position:absolute;"/>
					</div>
				</a>
				<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP005"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
<!-- 					<a href="img/indexImg/SP005.png"> -->
						<img src="img/indexImg/SP005.png" style="height:100%;position:absolute;"/>
					</div>
				</a>
<!-- 					<a href="img/indexImg/SP006.jpg"> -->
				<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP006"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
						<img src="img/indexImg/SP006.jpg" style="height:100%;position:absolute;"/>
					</div>
				</a>
				<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?action=sg_infoCompositeQuery&sp_no=SP007"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
<!-- 					<a href="img/no-image.PNG"> -->
						<img src="img/no-image.PNG" style="height:100%;position:absolute;"/>
					</div>
				</a>
			<div>
				<a href="img/no-image.PNG"
				style="display:flex;flex-direction:column;width:calc(100% / 3 - 30px);margin:10px;">
					<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
						<img src="img/no-image.PNG" style="height:100%;position:absolute;"/>
					</div>
				</a>
			</div>
		</div>
		<%-- footer目前尚缺連結點 --%>
<%-- 		<%@ include file="front-end/CA105G1_footer.file" %> <!--請更正成下一行-->--%>
		<jsp:include page="/front-end/CA105G1_footer.jsp" />
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>