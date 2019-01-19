<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta name="description" content="">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTGO:Front-venue-select</title>
<!-- 		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<!-- Title -->

	   <!-- Favicon -->
	   <link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
	
	   <!-- Core Stylesheet -->
	   <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
	   
	   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	   <script src="<%=request.getContextPath()%>/front-end/pro/TWzipcode/jquery.twzipcode.min.js"></script>

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
		<jsp:include page="/front-end/CA105G1_header_bt4.jsp" />
		<div class="breadcrumb-area">
	    <!-- Top Breadcrumb Area -->
		    <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/sgpic/sportbg2.jpg);">
		    </div>
		
		    <div class="container">
		        <div class="row">
		            <div class="col-12">
		                <nav aria-label="breadcrumb">
		                    <ol class="breadcrumb">
		                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/index.jsp"><i class="fa fa-home"></i> 首頁</a></li>
		                        <li class="breadcrumb-item active" aria-current="page">查詢場地資料</li>
		                    </ol>
		                </nav>
		            </div>
		        </div>
		    </div>
		</div>
		
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-1">
					<!--留白-->
				</div>
				<div class="col-xs-12 col-sm-10">
					<!-- 連結到各分頁上 -->
<!-- 					<div class="row"> -->
						
<!-- 						<div class="col-xs-12 col-sm-1"></div> -->
						
<!-- 						<div class="col-xs-12 col-sm-4"> -->
<%-- 							<a href="<%=request.getContextPath()%>/front-end/venue/venue_query_info_by_composite_front.jsp"  --%>
<!-- 							class="btn btn-success btn-block">一般詳細查詢</a> -->
<!-- 						</div> -->
						
<!-- 						<div class="col-xs-12 col-sm-2"></div> -->
												
<!-- 						<div class="col-xs-12 col-sm-4"> -->
<%-- 							<a href="<%=request.getContextPath()%>/front-end/venue/venue_query_info_by_map_front.jsp"  --%>
<!-- 							class="btn btn-success btn-block"> 地圖查詢</a> -->
<!-- 						</div> -->
						
<!-- 						<div class="col-xs-12 col-sm-1"></div> -->
					
<!-- 					</div> -->
					<div class="row">
						<div class="h1 center-block">venue_query_info_by_composite_front</div>
						
<%-- 						<!--測試前台萬用查詢-->
							<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">			
 							<input type="hidden" name="action" value="listVenueByCompostieQueryForFrontEnd" />
 							<input type="submit" value=" __查詢 __ " />
 						</form> --%>
						<form method="get" action="<%=request.getContextPath()%>/venue/venue.do">
							<div class="label label-default label-text">請輸入場地編號 : (V000002)</div>
								<input type="text" name="v_no" value="${venueVO.v_no}"/>${errorMsgs.get("v_no")}
							<br>
							
							<div class="label label-default label-text">請選擇場地種類:</div>							
							<jsp:useBean id="venueTypeService" scope="session" class="com.venuetype.model.VenueTypeService" />
							<select size="1" name="vt_no" class="text-center">
								<option value=""></option>
								<c:forEach var="venueTypeVO" items="${venueTypeService.all}">
									<option value="${venueTypeVO.vt_no}" ${(param.vt_no==venueTypeVO.vt_no)?'selected':''}>${venueTypeVO.vt_name}</option>
								</c:forEach>
							</select>
							<br>
							
							<div class="label label-default label-text">請選擇地區:</div>							
							<jsp:useBean id="regService" scope="session" class="com.region.model.RegService" />
							<select size="1" name="reg_no" class="text-center">
								<option value=""></option>
								<c:forEach var="regVO" items="${regService.all}">
									<option value="${regVO.reg_no}" ${(param.reg_no==regVO.reg_no)?'selected':''}>${regVO.reg_name}-${regVO.reg_dist}</option>
								</c:forEach>
							</select>
							<br>
							
							<div class="label label-default label-text">請選擇時間開放:</div>							
<%-- 												<jsp:useBean id="regService" scope="session" class="com.region.model.RegService" /> --%>
							<label for="openday_mon">一</label>
							<input type="checkbox" name="openday_mon" value="Y" id="openday_mon" />
							<label for="openday_tue">二</label>
							<input type="checkbox" name="openday_tue" value="Y" id="openday_tue" />
							<label for="openday_wed">三</label>
							<input type="checkbox" name="openday_wed" value="Y" id="openday_wed" />
							<label for="openday_thu">四</label>
							<input type="checkbox" name="openday_thu" value="Y" id="openday_thu" />
							<label for="openday_fri">五</label>
							<input type="checkbox" name="openday_fri" value="Y" id="openday_fri" />
							<label for="openday_sat">六</label>
							<input type="checkbox" name="openday_sat" value="Y" id="openday_sat" />
							<label for="openday_sun">日</label>
							<input type="checkbox" name="openday_sun" value="Y" id="openday_sun" />
							
							<input type="hidden" name="action" value="listVenueByCompostieQueryForFrontEnd" /><br>
							<input type="submit" value="submit_composite_query" class="btn-primary"/>
						</form>
						
						
						

					</div>
					<div class="row">
						<div class="h1 center-block">結果回傳區</div>
						<% if("listVenueByCompostieQueryForFrontEnd".equals(request.getParameter("action")) || 
								"memEvaluateVenueInFrontEnd".equals(request.getParameter("action"))){ %>
							<jsp:include page="listQueryVenueForFront.jsp" />
						<% } %>						
						
						
					</div>
				</div>
				<div class="col-xs-12 col-sm-1">
					<!--留白-->
				</div>
			</div>
		</div>
		
		
		
		
		
		<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />
		
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