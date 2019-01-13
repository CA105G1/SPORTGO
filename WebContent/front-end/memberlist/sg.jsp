<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.sg_info.model.*" %>
<%@ page import = "com.sg_mem.model.*" %>
<%@ page import = "java.util.*" %>
<%
	//session.setAttribute("loaction",request.getRequestURI());
%>
<jsp:useBean id="memberlistService" class="com.memberlist.model.MemberlistService"/>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<title>SPORTGO 會員頁面</title>
		<style type="text/css">
			.container{
				width: 90%;
			}
			center{
				font-size: xx-large;
				color: red;
			}
			.grid-container{
				grid-template-columns:20% 40% 20%;
				grid-gap:20px;
				text-algin:center;
			}
			.list-group-item{
				align-items:center;
			}
		</style>
	</head>
	<body>
		<jsp:include page="/front-end/CA105G1_header.jsp"/>
		
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="list_group.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9">
				<!-- 揪團管理 -->
<%-- 					<h1>${memberlistVO.mem_name}</h1> --%>
					<div class="container">
						<div class="row">
							<h3>即將到來的揪團</h3>
							<div class="grid-container" style="display:grid;">
								<c:forEach var="sg_memVO" items="${sg_mem}">
									<c:forEach var="sg_infoVO" items="${sgall}">
											<c:if test="${sg_infoVO.sg_no eq sg_memVO.sg_no}">
											
												<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
												<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}"
												style="height:100%;position:absolute;">
												</div>
												<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForJoinMem.jsp?Sg_no=${sg_infoVO.sg_no}" 
												class="list-group-item" style="display:flex;height:100%;border:0;">
												${sg_infoVO.sg_name}<br>
											 	團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br>
											 	時間：${sg_infoVO.sg_date}<br>
												</a>
												<div></div>
											</c:if>
									</c:forEach>
								</c:forEach>
							</div>
						</div>
					</div>
					
					<div class="container">
						<div class="row">
							<h3>即將到來的我的揪團</h3>
							<div class="grid-container" style="display:grid;align-item:center;">
								<c:forEach var="sg_infoVO" items="${sglist}">
										<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
										<img class="pic" src="<%= request.getContextPath()%>
										/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}" style="height:100%;position:absolute;">
										</div>
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForHead.jsp?Sg_no=${sg_infoVO.sg_no}"
										 class="list-group-item" style="display:flex;height:100%;border:0;">
										 ${sg_infoVO.sg_name}<br>
										 團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br>
										 時間：${sg_infoVO.sg_date}<br>
										
										</a>
										<div></div>
								</c:forEach>
							</div>
						</div>
					</div>
					
					<div class="container">
						<div class="row">
							<h3>我參加過的揪團</h3>
							<div class="grid-container" style="display:grid;align-item:center;">
								<c:forEach var="sg_memVO" items="${sg_mem}">
									<c:forEach var="sg_infoVO" items="${sghisall}">
											<c:if test="${sg_infoVO.sg_no eq sg_memVO.sg_no}">
												<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
												<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoGetByPkForJoinMem.jsp?sg_no=${sg_infoVO.sg_no}"
												style="height:100%;position:absolute;">
												</div>
												<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?sg_no=${sg_infoVO.sg_no}" 
												 class="list-group-item" style="display:flex;height:100%;border:0;">
												${sg_infoVO.sg_name}<br>
										 		團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br>
										 		時間：${sg_infoVO.sg_date}<br>
												</a>
												<a href=""
												class="list-group-item" style="display:flex;height:100%;border:0;">評價</a>
											</c:if>
									</c:forEach>
								</c:forEach>
							</div>
						</div>
					</div>
					
					<div class="container">
						<div class="row">
							<h3>我舉辦過的揪團</h3>
							<div class="grid-container" style="display:grid;align-item:center;">
								<c:forEach var="sg_infoVO" items="${sghislist}">
									<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;">
									<img src="<%= request.getContextPath()%>
									/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}" style="height:100%;position:absolute;">
									</div>
									<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForHead.jsp?Sg_no=${sg_infoVO.sg_no}"
									class="list-group-item" style="display:flex;margin-top: 37.5px;margin-bottom: 37.5px;">
									${sg_infoVO.sg_name}<br>
									團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br>
									時間：${sg_infoVO.sg_date}<br>
									</a>
									<a href=""
									class="list-group-item"  style="display:flex;margin-top: 37.5px;margin-bottom: 37.5px;">評價</a>
								</c:forEach>
							</div>
						</div>
					</div>
					
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/CA105G1_footer.jsp"/>
	<script>
	</script>
	</body>
</html>