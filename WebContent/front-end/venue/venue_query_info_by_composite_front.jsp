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
	   
<%-- 	   <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/venue/build.css" /> --%>
	   
	   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	   <script src="<%=request.getContextPath()%>/front-end/pro/TWzipcode/jquery.twzipcode.min.js"></script>

		<style>
		input{
			height:30px
		}
		.label-text{
			font-size:1.3em;
		}
		.myWeekSet div{
			margin:8px;
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
					<div class="row" style="display:felx; justify-content: center;">
						
						
<%-- 						<!--測試前台萬用查詢-->
							<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">			
 							<input type="hidden" name="action" value="listVenueByCompostieQueryForFrontEnd" />
 							<input type="submit" value=" __查詢 __ " />
 						</form> --%>
						<form method="get" action="<%=request.getContextPath()%>/venue/venue.do">
							<h1>查詢場地資料</h1>
							<table class="table table-hover table-striped table-bordered">
								
<!-- 								  <div class="input-group mb-3"> -->
<!-- 								    <div class="input-group-prepend"> -->
<!-- 								      <span class="input-group-text">Default</span> -->
<!-- 								    </div> -->
<!-- 								    <input type="text" class="form-control"> -->
<!-- 								  </div> -->
								
								<tr>
									<th><label>請輸入場地名稱 :</label></th>
									<td>
										<input type="text" name="v_name" value="${venueVO.v_name}" class="form-control"/>
										<div>${errorMsgs.get("v_name")}</div>
									</td>
								</tr>
								
								<tr>
									<th><label for='vt_no'>請選擇場地種類 :</label></th>
									<td>
										<jsp:useBean id="venueTypeService" scope="session" class="com.venuetype.model.VenueTypeService" />
										<div class="form-group">
											<select size="1" name="vt_no" class="text-center form-control" id="vt_no">
												<option value=""></option>
												<c:forEach var="venueTypeVO" items="${venueTypeService.all}">
													<option value="${venueTypeVO.vt_no}" ${(param.vt_no==venueTypeVO.vt_no)?'selected':''}>${venueTypeVO.vt_name}</option>
												</c:forEach>
											</select>
										</div>
									</td>
								</tr>
								
								<tr>
									<th><label>請選擇縣市 :</label></th>
									<td>
										<jsp:useBean id="regSvc" scope="page" class="com.region.model.RegService" />
				      					<select id="reg_name" size="1" name="reg_name" class="text-center form-control">
				      						<option value="">請選擇縣市</option>
				      						<c:forEach var="reg_name" items="${regSvc.reg_nameList }">
				      							<option value="${reg_name }">${reg_name}
				      						</c:forEach>
										</select>
									</td>
								</tr>
								
								<tr>
									<th><label>請選擇地區 :</label></th>
									<td>
										<select size="1" name="reg_dist" class="text-center form-control">
				      						<option id="reg_dist" value="">請選擇地區</option>
										</select>
									</td>
								</tr>
								
								<tr>
									<th><label>是否有場地使用費 :</label></th>
									<td>
										<select size="1" name="open_state" class="text-center form-control">
				      						<option value="">是否有場地使用費</option>
				      						<option value="免費對外開放使用" ${venueVO.v_display=='免費對外開放使用'?'selected':'' }>免費對外開放使用</option>
				      						<option value="付費對外開放使用" ${venueVO.v_display=='付費對外開放使用'?'selected':'' }>付費對外開放使用</option>
										</select>
									</td>
								</tr>
								
								
								
								
								<tr>
									<th><label>請選擇時間開放 :</label></th>
									<td>
										<div class="myWeekSet" style="display:inline-flex;">
											<div class="custom-control custom-checkbox">
										    	<input type="checkbox" class="custom-control-input" id="openday_mon" name="openday_mon">
										    	<label class="custom-control-label" for="openday_mon">星期一</label>
										  	</div>
											
											<div class="custom-control custom-checkbox">
										    	<input type="checkbox" class="custom-control-input" id="openday_tue" name="openday_tue">
										    	<label class="custom-control-label" for="openday_tue">星期二</label>
										  	</div>
											
											<div class="custom-control custom-checkbox">
										    	<input type="checkbox" class="custom-control-input" id="openday_wed" name="openday_wed">
										    	<label class="custom-control-label" for="openday_wed">星期三</label>
										  	</div>
											
											<div class="custom-control custom-checkbox">
										    	<input type="checkbox" class="custom-control-input" id="openday_thu" name="openday_thu">
										    	<label class="custom-control-label" for="openday_thu">星期四</label>
										  	</div>
											
											<div class="custom-control custom-checkbox">
										    	<input type="checkbox" class="custom-control-input" id="openday_fri" name="openday_fri">
										    	<label class="custom-control-label" for="openday_fri">星期五</label>
										  	</div>
											
											<div class="custom-control custom-checkbox">
										    	<input type="checkbox" class="custom-control-input" id="openday_sat" name="openday_sat">
										    	<label class="custom-control-label" for="openday_sat">星期六</label>
										  	</div>
											
											<div class="custom-control custom-checkbox">
										    	<input type="checkbox" class="custom-control-input" id="openday_sun" name="openday_sun">
										    	<label class="custom-control-label" for="openday_sun">星期日</label>
										  	</div>
										</div>

									</td>
								</tr>
									
								<tr>
									<th><label>評價分數 :</label></th>
									<td>
										<div class="row">
											<div class="col-sm-6">
												<select size="1" name="score_max" class="form-control" id="score_max">
					      							<option value="" >請選擇上限</option>
					      							<option value="1">一分</option>
					      							<option value="2">二分</option>
					      							<option value="3">三分</option>
					      							<option value="4">四分</option>
					      							<option value="5">五分</option>
												</select>												
											</div>
											<div class="col-sm-6">
												<select size="1" name="score_min" class="form-control" id="score_min">
					      							<option value="" >請選擇下限</option>
					      							<option value="1">一分</option>
					      							<option value="2">二分</option>
					      							<option value="3">三分</option>
					      							<option value="4">四分</option>
					      							<option value="5">五分</option>
												</select>
											</div>
										</div>
									</td>
								</tr>	
														
								<tr><th colspan='2'>
									<input type="hidden" name="action" value="listVenueByCompostieQueryForFrontEnd" />
									<input type="submit" value="送出查詢" class="btn btn-primary btn-block"/>
								</th></tr>
								
							</table>
						</form>
						
						
						

					</div>
					<div class="row" style="display:felx; justify-content: center;">
						
						<% if("listVenueByCompostieQueryForFrontEnd".equals(request.getParameter("action")) || 
								"memEvaluateVenueInFrontEnd".equals(request.getParameter("action"))){ %>
							<div style="display:felx; justify-content: center;">
								<div class="h1">---Result---</div>
								<jsp:include page="listQueryVenueForFront.jsp" />
							</div>
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
    
    <script>
    
    $("#reg_name").change(function(){
    	var dataStr = {};
    	dataStr.action = "getReg_dist";
    	dataStr.reg_name = $("#reg_name").val();
    	
    	$.ajax({
    		type: "POST",
    		url: "<%= request.getContextPath()%>/region/region.do",
    		data: dataStr,
    		dataType: "json",
    		contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    		error: function(){
    			alert("發生錯誤!");
    		},
    		success: function(data){
    			$(".reg_distOption").remove();
    			var reg_distArr = data.reg_dist.split(',');
    			for(var i in reg_distArr){
    				$("#reg_dist").after("<option class='reg_distOption' value='"+reg_distArr[i]+"'>"+reg_distArr[i]);
    			}
    		}
    	});
    	
    });
	
    $("#score_max").change(function(){
		var max = $(this).context.value;
		for(var i = 1 ; i<=5; i++){
			if(i>max){
				$("#score_min option[value='"+i+"']")
					.prop("disabled",true).attr("style","display:none");
			}else{
				$("#score_min option[value='"+i+"']")
					.prop("disabled",false).attr("style","display:block");
			}
		}
	});
	$("#score_min").change(function(){
		var min = $(this).context.value;
		for(var i = 1 ; i<=5; i++){
			if(i<min){
				$("#score_max option[value='"+i+"']")
					.prop("disabled",true).attr("style","display:none");
			}else{
				$("#score_max option[value='"+i+"']")
					.prop("disabled",false).attr("style","display:block");
			}
		}
	});	
    
    </script>
		
		
<!-- 		<script src="https://code.jquery.com/jquery.js"></script> -->
<!-- 		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>