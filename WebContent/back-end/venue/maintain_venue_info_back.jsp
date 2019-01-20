<%@page import="com.region.model.RegService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.venue.model.VenueVO"%>
<%@page import="com.region.model.RegVO"%>
<%@page import="java.util.List"%>

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
		<%-- include header --%>
<%-- 	<%@ include file="/back-end/CA105G1_header_back.file" %> --%>
		<%-- include show_loginBox --%>
<%-- 	<%@ include file="/back-end/emp/loginfile/showLoginBackEnd.file" %> --%>
		
		<jsp:include page="/back-end/CA105G1_header_back.jsp"/>
		
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
<!-- 					<h1>後台共用區</h1> -->
<!-- 					<h2>here need include file</h2> -->
					<jsp:include page="/back-end/left_side_field.jsp"/>
				</div>
				
	<% 			String whichTab = (String)request.getAttribute("whichTab"); %>
				<div class="col-xs-12 col-sm-9">
					<h1>場地資料查詢</h1>
					
					<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        　	<!-- news area -->
					        <!-- 使用request.getAttribute("whichTab")來分辨，哪個class is active -->
					        <li role="presentation" class="${whichTab==null?'active':(whichTab=='tab1'?'active':'') }">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">查詢、更新</a>
					        </li>
					        <li role="presentation" class="${whichTab=='tab2'?'active':'' }">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">新增</a>
					        </li>
					        <% System.out.println("whichTab : "+whichTab);%>
					        <% if("tab3".equals(whichTab)){ %>
								<li role="presentation" class="${whichTab=='tab3'?'active':'' }">
					            	<a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">更新</a>
					      		</li>
					      	<% } %>
					        
					        
					    </ul>
					
		    <!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					        <!-- 使用request.getAttribute("whichtab")來分辨，哪個class is active -->
					        <div role="tabpanel" class="tab-pane ${whichTab==null?'active':(whichTab=='tab1'?'active':'') }" id="tab1">
        	<%-- 查詢面板  --%>	
					        	<div class="panel panel-info">
									<div class="panel-heading">
										<h3 class="panel-title">維護場地資訊</h3>
									</div>
									<div class="panel-body">
										<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
<!-- 											<div class="label label-default label-text">請輸入場地編號 : (V000002)</div> -->
											<table class="table table-hover table-striped table-bordered">
												<tr>
													<th><label>請輸入場地編號 : (V000002)</label></th>
													<td>
														<input type="text" name="v_no" value="${venueMap.get('v_no')[0]}" class="text-left form-control"/>
													</td>
												</tr>
												
												<tr>
													<th><label>請輸入場地名稱 : </label></th>
													<td>
														<input type="text" name="v_name" value="${venueMap.get('v_name')[0]}" class="text-left form-control"/>
													</td>
												</tr>
												
												<tr>
													<th><label>請選擇場地種類 :</label></th>
													<td>
														<jsp:useBean id="venueTypeService" scope="session" class="com.venuetype.model.VenueTypeService" />
														<select size="1" name="vt_no" class="text-center form-control">
															<option value=""></option>
															<c:forEach var="venueTypeVO" items="${venueTypeService.all}">
																<option value="${venueTypeVO.vt_no}" ${venueMap.get('vt_no')[0]==venueTypeVO.vt_no?'selected':''}>
																	${venueTypeVO.vt_name}
																</option>
															</c:forEach>
														</select>
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
													<th><label>請選擇時間開放 :</label></th>
													<td>
														<label for="openday_mon" class="checkbox-inline">一</label>
														<input type="checkbox" name="openday_mon" value="Y" id="openday_mon" />
														<label for="openday_tue" class="checkbox-inline">二</label>
														<input type="checkbox" name="openday_tue" value="Y" id="openday_tue" />
														<label for="openday_wed" class="checkbox-inline">三</label>
														<input type="checkbox" name="openday_wed" value="Y" id="openday_wed" />
														<label for="openday_thu" class="checkbox-inline">四</label>
														<input type="checkbox" name="openday_thu" value="Y" id="openday_thu" />
														<label for="openday_fri" class="checkbox-inline">五</label>
														<input type="checkbox" name="openday_fri" value="Y" id="openday_fri" />
														<label for="openday_sat" class="checkbox-inline">六</label>
														<input type="checkbox" name="openday_sat" value="Y" id="openday_sat" />
														<label for="openday_sun" class="checkbox-inline">日</label>
														<input type="checkbox" name="openday_sun" value="Y" id="openday_sun" />
													
													
													
													
														<fieldset>
    <legend>Hotel Ratings: </legend>
    <label for="checkbox-1">2 Star</label>
    <input type="checkbox" name="checkbox-1" id="checkbox-1">
    <label for="checkbox-2">3 Star</label>
    <input type="checkbox" name="checkbox-2" id="checkbox-2">
    <label for="checkbox-3">4 Star</label>
    <input type="checkbox" name="checkbox-3" id="checkbox-3">
    <label for="checkbox-4">5 Star</label>
    <input type="checkbox" name="checkbox-4" id="checkbox-4">
  </fieldset>
													</td>
												</tr>
												
												<tr><th colspan='2'>
													<input type="hidden" name="action" value="listVenueByCompositeQuery" />
													<input type="submit" value="送出查詢" class="btn btn-primary btn-block"/>
												</th></tr>
												
												
											</table>
											
											
										</form>
									</div>
								</div>
					        	<%-- 錯誤表列 --%>
								<c:if test="${not empty errorMsgs_tab1}">
									<ul>
										<c:forEach var="message" items="${errorMsgs_tab1}">
											<li style="color:red">${message}</li>
										</c:forEach>
									</ul>
								</c:if>	
					        	<%-- 查詢回應區--%>
					        	<div class="panel panel-info">
									<% if("listVenueByCompositeQuery".equals(request.getParameter("action"))){%>
										<jsp:include page="listQueryVenue_back.jsp"/>
									<% }else if("show_one_venue_back".equals(request.getParameter("action"))){ %>
										<jsp:include page="show_one_venue_back.jsp"/>
									<% }else if("delete".equals(request.getParameter("action"))){ %>
										<c:if test="${venue.v_no!=null}">
											<div>${venue.v_no}-${venueVO.v_name}-${venueTypeVO.vt_name}-已被刪除</div>
										</c:if>
									<% } %>
					        	</div>
					        </div>
					        
					        <div role="tabpanel" class="tab-pane ${whichTab=='tab2'?'active':'' }" id="tab2">
					        	<jsp:include page="/back-end/venue/add_one_venue_back.jsp" />
					        </div>
					       <% if("tab3".equals(whichTab)){ %>
								<div role="tabpanel" class="tab-pane ${whichTab=='tab3'?'active':''}" id="tab3">
					        		<jsp:include page="/back-end/venue/update_one_venue_back.jsp" />
					        	</div>
							<% } %>
							
					    </div>
					</div>
					
					
				</div>
			</div>
		</div>











		<%@ include file="/back-end/CA105G1_footer_back.file" %>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

	</body>
	
	<script type="text/javascript">
	
	//照片上傳
	var temp_My_pic;
	var test = $(":file").change(function(){
		temp_My_pic = "#"+$(this).context.id;
		readURL(this);
		if(temp_My_pic=="#v_photo1_tab3"){
			$('#hasChangePicture_tab3').val("true");
			console.log($('#hasChangePicture_tab3').val());
		}
	});
	
	
	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$(temp_My_pic).parent().next().empty();
				$(temp_My_pic).parent().next().append("<img/>");
				$(temp_My_pic).parent().next().children().attr({"src":e.target.result, "class":"img-responsive img-rounded center-block"});
			};
			reader.readAsDataURL(input.files[0]);
		};
	}

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
	
	</script>
	
	
	
</html>