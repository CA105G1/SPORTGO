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
		<title>SportGo:場地資訊查詢</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<!-- Favicon -->
	   	<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
	
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
<!-- 										<h3 class="panel-title">維護場地資訊</h3> -->
										<div class="panel-title" role="button" data-toggle="collapse" href="#cc2" aria-expanded="false" aria-controls="#cc2">
										    維護場地資訊查詢
										</div>
									</div>
								<% if("listVenueByCompositeQuery".equals(request.getParameter("action"))){%>
									<div class="collapse" id="cc2">
								<% }else if("show_one_venue_back".equals(request.getParameter("action"))){ %>
									<div class="collapse" id="cc2">
								<% }else {%>
									<div class="collapse in" id="cc2">
								<% }%>
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
									      					<select id="reg_name_tab1" size="1" name="reg_name" class="reg_name_class text-center form-control">
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
									      						<option id="reg_dist_tab1Option" value="" class="reg_dist_class">請選擇地區</option>
															</select>
														</td>
													</tr>
													
													<tr>
														<th><label>請選擇時間開放 :</label></th>
														<td>
															<label for="openday_mon" class="checkbox-inline">星期一</label>
															<input type="checkbox" name="openday_mon" value="Y" id="openday_mon" style="vertical-align:middle;"/>
															
															<label for="openday_tue" class="checkbox-inline">星期二</label>
															<input type="checkbox" name="openday_tue" value="Y" id="openday_tue" style="vertical-align:middle;" />
															
															<label for="openday_wed" class="checkbox-inline">星期三</label>
															<input type="checkbox" name="openday_wed" value="Y" id="openday_wed" style="vertical-align:middle;" />
															
															<label for="openday_thu" class="checkbox-inline">星期四</label>
															<input type="checkbox" name="openday_thu" value="Y" id="openday_thu" style="vertical-align:middle;" />
															
															<label for="openday_fri" class="checkbox-inline">星期五</label>
															<input type="checkbox" name="openday_fri" value="Y" id="openday_fri" style="vertical-align:middle;" />
															
															<label for="openday_sat" class="checkbox-inline">星期六</label>
															<input type="checkbox" name="openday_sat" value="Y" id="openday_sat" style="vertical-align:middle;" />
															
															<label for="openday_sun" class="checkbox-inline">星期日</label>
															<input type="checkbox" name="openday_sun" value="Y" id="openday_sun" style="vertical-align:middle;" />
													
														</td>
													</tr>
													
													<tr>
														<th><label>評價分數 :</label></th>
														<td>
															<div class="col-sm-6">
																<select size="1" name="score_max" class="text-center form-control" id="score_max">
									      							<option value="" >請選擇上限</option>
									      							<option value="1">一分</option>
									      							<option value="2">二分</option>
									      							<option value="3">三分</option>
									      							<option value="4">四分</option>
									      							<option value="5">五分</option>
																</select>												
															</div>
															<div class="col-sm-6">
																<select size="1" name="score_min" class="text-center form-control" id="score_min">
									      							<option value="" >請選擇下限</option>
									      							<option value="1">一分</option>
									      							<option value="2">二分</option>
									      							<option value="3">三分</option>
									      							<option value="4">四分</option>
									      							<option value="5">五分</option>
																</select>
															</div>
														</td>
													</tr>
													
													<tr><th colspan='2'>
														<input type="hidden" name="action" value="listVenueByCompositeQuery" />
														<input type="submit" value="送出查詢" class="btn btn-primary btn-block"/>
													</th></tr>
													
													
												</table>
												
												
											</form>
										</div>
									</div><!-- for collapse -->
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

	var temp_My_reg_name;
	$(".reg_name_class").change(function(){
    	var dataStr = {};
    	dataStr.action = "getReg_dist";
    	dataStr.reg_name = $(this).val();
    	temp_My_reg_name = $(this).context.id;
    	temp_My_reg_name = 
    		temp_My_reg_name.substring(
    				temp_My_reg_name.lastIndexOf("_"),
    				temp_My_reg_name.length);
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
    			$(".reg_distOption"+temp_My_reg_name).remove();
    			var reg_distArr = data.reg_dist.split(',');
    			for(var i in reg_distArr){
    				$("#reg_dist"+temp_My_reg_name+"Option").after("<option class='reg_distOption"+temp_My_reg_name+"' value='"+reg_distArr[i]+"'>"+reg_distArr[i]);
    			}
    		}
    	});
    });
	
	var temp_for_get_reg_no_tab;
	$(".reg_dist_class").change(function(){
		temp_for_get_reg_no_tab = $(this).context.id;
		temp_for_get_reg_no_tab = 
			temp_for_get_reg_no_tab.substring(
					temp_for_get_reg_no_tab.lastIndexOf("_"),
					temp_for_get_reg_no_tab.length);
//console.log("temp_for_get_reg_no_tab : "+temp_for_get_reg_no_tab);
		var myDataString = {};
		myDataString.action = "getReg_no";
		myDataString.reg_name = $("#reg_name"+temp_for_get_reg_no_tab).val();
//console.log("myDataString.reg_name : "+myDataString.reg_name);
		myDataString.reg_dist = $("#reg_dist"+temp_for_get_reg_no_tab).val();
//console.log("myDataString.reg_dist : "+myDataString.reg_dist);
		$.ajax({
    		type: "POST",
    		url: "<%= request.getContextPath()%>/region/region.do",
    		data: myDataString,
    		dataType: "json",
    		contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
    		error: function(){
    			alert("發生錯誤!");
    		},
    		success: function(data){
    			$("#reg_no"+temp_for_get_reg_no_tab).val(data.reg_no);
  // console.log("reg_no"+$("#reg_no"+temp_for_get_reg_no_tab).val());
    			$("#reg_no_show"+temp_for_get_reg_no_tab).html(data.reg_no);
    			$("#v_address_show"+temp_for_get_reg_no_tab).html(myDataString.reg_name+myDataString.reg_dist);
    			$("#v_address_temp"+temp_for_get_reg_no_tab).val('');
    		}
    	});
	});
	
	var temp_v_address;
	$(".v_address_class").keyup(function(){
		//console.log("hello");
		temp_v_address = $(this).context.id;
		temp_v_address = 
			temp_v_address.substring(
					temp_v_address.lastIndexOf("_"),
					temp_v_address.length);
		//console.log("temp_v_address : "+temp_v_address);
		var tempStringTitele = $("#v_address_show"+temp_v_address).html();
		
		//console.log("tempStringTitele : "+tempStringTitele);
		
		var tempStringLast = $("#v_address_temp"+temp_v_address).val();
		
		//console.log("tempStringLast : "+tempStringLast);
		$(this).next().val("");
		$(this).next().val(tempStringTitele+tempStringLast);
		
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
	$("#forAddNewNenue").click(function(){
		// 場地類型---籃球場
		$("#vt_no_tab2 option[value='VT001']").prop("selected",true);
		// 場地名稱---湘北高中台灣分部
		$("#v_name_tab2").val("湘北高中台灣分部");
		// 室內or室外---室內設施
		$("#v_inout_tab2 option[value='室內設施']").prop("selected",true);
		// 場地電話---03-1234567
		$("#v_phoneno_tab2").val("03-1234567");
		// 開放狀態---
		$("#open_state_tab2 option[value='免費對外開放使用']").prop("selected",true);
		// 開放日
		$("#openday_mon_tab2 option[value='Y']").prop("selected",true);
		$("#openday_tue_tab2 option[value='Y']").prop("selected",true);
		$("#openday_wed_tab2 option[value='Y']").prop("selected",true);
		$("#openday_thu_tab2 option[value='Y']").prop("selected",true);
		$("#openday_fri_tab2 option[value='Y']").prop("selected",true);
		$("#openday_sat_tab2 option[value='Y']").prop("selected",true);
		$("#openday_sun_tab2 option[value='Y']").prop("selected",true);
		// 是否顯示
		$("#v_display_tab2 option[value='顯示']").prop("selected",true);
		// 適用對象-民眾
		$("#v_fitall_tab2 option[value='Y']").prop("selected",true);
		// 適用對象-內部人員
		$("#v_fitinter_tab2 option[value='Y']").prop("selected",true);
		
		// 場地地址---桃園市大溪區和平路33-1
		$("#reg_name_tab2 option[value='']").prop("selected",true);
		$("#reg_dist_tab2 option[value='']").prop("selected",true);
		$(".reg_distOption_tab2").remove();
		$("#v_address_show_tab2").html("");
		$("#v_address_temp_tab2").val("桃園市大溪區和平路33-1");
		$("#v_address_tab2").val("桃園市大溪區和平路33-1");
		// 郵遞區號
		$("#reg_no_show_tab2").html("335");
		$("#reg_no_tab2").val("335");
		
	});
	
	</script>
	
	
	
</html>