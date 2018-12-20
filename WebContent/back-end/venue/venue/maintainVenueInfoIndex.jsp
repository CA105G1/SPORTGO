<%@page import="com.venue.model.VenueVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html>
<html lang="">
	<head>
		<title>CA105G1:SPORTYGO:maintainVenueInfo</title>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<style>
		
		input{
			height:30px
		}
		.label-text{
			font-size:1.3em;
		}
		
		</style>
		
	</head>
	<body>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-2">
					<a href="<%=request.getContextPath()+request.getServletPath()%>" for="returnIndex">
						<img id="returnIndex" src="https://api.fnkr.net/testimg/1500x1000/00CED1/FFF/?text=back_home" class="img-responsive" />
					</a>
				</div>
				<div class="col-xs-12 col-sm-10">
					<img src="https://api.fnkr.net/testimg/1500x200/00CED1/FFF/?text=justColumn" class="img-responsive" />
					<div class='h1'>維護場地資訊</div>
				</div>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-2">
				<!-- 					
					<img src="https://api.fnkr.net/testimg/1500x200/00CED1/FFF/?text=justColumn" class="img-responsive" />
				 -->
				</div>
				<div class="col-xs-12 col-sm-10">
					<div>
						<div>
							<div class="label label-default label-text">查詢區1版</div>
						</div>
						<br>
						<div>
							<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
								<div class="label label-default label-text">請輸入場地編號 : (V000002)</div>
								<% 
									VenueVO tempVO = (VenueVO)request.getAttribute("venueVO");
								%>
								<input type="text" name="v_no" value="<%=tempVO==null? "V000002":tempVO.getV_no()%>"/>
								<input type="hidden" name="action" value="get_one_venue" />
								<input type="submit" value="submit_get_ont_venue" class="btn-primary"/>
							</form>
						</div>
						<br>
						<div>
							<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
								<div class="label label-default label-text">查詢全部場地</div>
								<input type="hidden" name="action" value="get_all_venue" />
								<input type="submit" value="submit_get_all_venue" class="btn-primary"/>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			<c:if test="${not empty errorMsgs}">
				<div class="row">
					<div class="col-xs-12 col-sm-2"></div>
					<div class="col-xs-12 col-sm-10">
						<div>
							<div class="label label-default label-text">錯誤提示區1版</div>
						</div>
						<br>
						<div>
							<font style="color:red">請修正以下錯誤</font>
							<ul>
								<c:forEach var = "message" items="${errorMsgs}">								
									<li style="color:red">${message}</li><br>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</c:if>

			<div style="height:20px"></div>
			<div class="row">
				<div class="col-xs-12 col-sm-2">
	<!-- 	<img src="https://api.fnkr.net/testimg/1500x1000/00CED1/FFF/?text=justColumn" class="img-responsive" />
	 -->
				</div>
				<div class="col-xs-12 col-sm-10">
					<div>
						<div class="label label-default label-text">回應區1版</div>
						<div>
							<% if("get_one_venue".equals(request.getAttribute("resultAction"))){ %>
								<jsp:include page="listOneVenue.jsp" flush="true" />	
							<% }else if("get_all_venue".equals(request.getAttribute("resultAction"))){%>
								<jsp:include page="listAllVenue.jsp" flush="true" />	
							<% }else if("success_delete".equals(request.getAttribute("resultAction"))){%>								
								<div style="height:10px"></div>
								<div class="label label-warning label-text">
									<%= request.getAttribute("showDeleteResult")%>
								</div>
							<% } %>
						</div>
					</div>

				</div>
			</div>
			
		</div>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>