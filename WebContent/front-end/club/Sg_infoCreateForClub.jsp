<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ page import="com.club.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>建立專屬揪團</title>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"> -->
<!-- <script src="http://code.jquery.com/jquery-1.12.4.min.js"></script> -->
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
<%-- <link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" /> --%>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script> -->

<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>



<style type="text/css">
	th{
		text-align:center;
	}
	#title{
		font-size:2em;
		padding-right:20px;
	}
	#map {
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
	#sg_extrainfo{
		resize:none;
		height:100px;
		width:90%;
	}
</style>



</head>
<body>
<jsp:include page="/front-end/CA105G1_header_bt4.jsp" />

<%
//  session中有memberlistVO、club_no，EL直接拿了就用
	String club_no = (String)session.getAttribute("club_no");
	ClubService svc = new ClubService();
	ClubVO clubVO = svc.getOneClub(club_no);
	request.setAttribute("clubVO",clubVO);
%>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsg}">
	<font style="color:red">請修正以下錯誤:</font>
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsg}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
	<ul>
		<c:forEach var="message" items="${errorMsg}">  <!-- 等同於${errorMsgs.entrySet()} -->
			<li style="color:red">${message.value}</li>  <!-- 等同於${message.getValue()} -->
		</c:forEach>
	</ul>
</c:if>


<!-- 麵包屑 -->
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
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp">社團專區</a></li>
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/front-end/club/Sg_infoList.jsp">專屬揪團</a></li>
                        <li class="breadcrumb-item active" aria-current="page">建立專屬揪團</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>


<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-2">
			<jsp:include page="/front-end/club/club_pageRight.jsp" />						
		</div>
		<div class="col-xs-12 col-sm-7">
			<form action="<%= request.getContextPath()%>/Sg_info/Sg_info.do" method="post" enctype="multipart/form-data">
				<table class="table table-striped table-bordered text-center">
					<jsp:useBean id="clubSvc" scope="page" class="com.club.model.ClubService"/>
					<caption class="text-center" style="text-align:center; caption-side: top"><span id="title">${clubSvc.getOneClub(club_no).club_name}</span>專屬揪團</caption>
					<tbody>
					<!------------ 圖片上傳 ------------>
						<tr>
							<td colspan="2" class="uploadPicTd">
								<img src="<%= request.getContextPath()%>/img/no-image.PNG" style="width:90%"  id="showPic">
								<input type="file" id="sg_pic" name="sg_pic"><br>
							</td>
						</tr>
						<tr>
							<th>團長</th>
							<td>
								${memberlistVO.mem_name }
								<input type="hidden" name="mem_no" value="${memberlistVO.mem_no }">
							</td>
						</tr>
						<tr>
							<th>團名</th>
							<td>
								<input type="text" name="sg_name" 
									value="${param.sg_name}">
							</td>
						</tr>
						<tr>
							<th>活動時間</th>
							<td>
								<input type="text" id="sg_date" name="sg_date" 
									value="${param.sg_date }">
							</td>
						</tr>
						<tr>
							<th>報名截止日期</th>
							<td>
								<input type="text" id="apl_end" name="apl_end" 
									value="${param.apl_end }">
							</td>
						</tr>
						<tr>
							<th>報名費用</th>
							<td>
								<input type="text" name="sg_fee" 
									value="${param.sg_fee }">
							</td>
						</tr>
						<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
						<tr>
							<th>運動種類</th> <!-- 下拉選單 -->
							<td>
								<select size="1" name="sp_no" id='sp_no'>
									<c:forEach var="sportVO" items="${sportSvc.all}" > 
										<option value="${sportVO.sp_no}" ${(param.sp_no == sportVO.sp_no)? 'selected':'' }>${sportVO.sp_name}
									</c:forEach>   
								</select>
							</td>
						</tr>
						<jsp:useBean id="venueSvc" scope="page" class="com.venue.model.VenueService"/> 
						<tr>
							<th>場地名稱</th> <!-- 下拉選單 -->
							<td>
							<select name='v_no' id="v_no">
								<option value=''>請選擇場地
								<c:forEach var='venueVO' items='${venueSvc.all}' > 
									<option value='${venueVO.v_no}' ${(param.v_no == venueVO.v_no)? 'selected':'' }>${venueVO.v_name}
								</c:forEach>
							</select>	
							</td>
						</tr> 
						<tr>
							<th>人數上限</th>
							<td>
								<input type="text" name="sg_maxno" 
									value="${param.sg_maxno }">
							</td>
						</tr> 
						<tr>
							<th>人數下限</th>
							<td>
								<input type="text" name="sg_minno" 
									value="${param.sg_minno }">
							</td>
						</tr> 
						<tr>
							<th>團長的話</th>
							<td>
								<textarea name="sg_extrainfo" id="sg_extrainfo">
									${param.sg_extrainfo}
								</textarea>
							</td>
						</tr>  
					</tbody>
				</table>
				<!-------------GOOGLE地圖 -------------->
				<div id="mapSetting" style="display:none">
					<table style="text-align:center; width:100%">
						<tr>
							<td>
								<div class="input-group">
									<label class="input-group-addon">起點</label>
									<input type="text" class="form-control" name="startAddr" id="startAddr">
									<div class="input-group-btn">
										<input type="button" class="btn btn-info" name="startSearchBtn" value="查詢" id="startSearchBtn">
									</div>
								</div>
							</td>
							<td rowspan="2" align="center">
								<input type="button" class="btn btn-success" name="road" id="road" value="規劃路線" style="width:90px; height:60px">
							</td>
						</tr>
						<tr><td>
							<div class="input-group" style="text-align:center; width:100%; padding-top:5px">
						        <div class="input-group">
						        	<label class="input-group-addon">終點</label>
									<input type="text" class="form-control" name="endAddr" id="endAddr">
									<div class="input-group-btn">
						        		<input type="button" class="btn btn-info" name="endSearchBtn" value="查詢" id="endSearchBtn">
					        		</div>
				        		</div>
							</div>
						</td></tr>
					</table>
				</div>
				<div class="card" style="background-color:#444444; ">
					<div class="card-header" >
						<h4 class="panel-title text-center" style="color:white; font-weight:bold; font-size:1.5em;">
							LOCATION
						</h4>
					</div>
					<div>
						<div id="map"></div>
						<div id="distance" style="font-size:1.5em; font-weight:bold; color:white; text-align:center"></div>
					</div>
				</div>
<canvas id="myChart" width="700" height="400" style="display: none"></canvas>
				
				<input type="submit" value="送出" class="btn btn-success btn-block">
				<input type="hidden" name="action"value="insert">
				<input type="hidden" name="club_no" value="${club_no }">
				<input type="hidden" name="sg_per" value="限社團">
				<input type="hidden" name="loc_start" id="loc_start">
				<input type="hidden" name="loc_end" id="loc_end">
			</form>
		</div>
		<div class="col-xs-12 col-sm-3" id="xx"><!--社團成員列表-->
					<jsp:include page="/front-end/club_memberlist/clubmember_list.jsp" />
		</div>
	</div>
</div>

<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />






<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<!-- Popper js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
<!-- Bootstrap js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
<!-- All Plugins js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
<!-- Active js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>





<script type="text/javascript">

	//照片上傳
	$("#sg_pic").change(function(){
		readURL(this);
	});

	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				var img = document.getElementById("showPic");
				img.src=e.target.result;
// 				img.height=auto;
// 				img.width=100%;

				
			}
			reader.readAsDataURL(input.files[0]);
		}
	}





	//設定活動時間表
	
	$("#sg_date").click(function(){
		if($('#apl_end').val() == null){
			var sg_date = new Date();
		}else{
			var sg_date = new Date($('#apl_end').val());
		}
	 	$('#sg_date').datetimepicker({
	 		timepicker: true,
	 		format: 'Y-m-d H:i',
	 	    beforeShowDay: function(date) {
	 	  	  if (  date.getYear() <  sg_date.getYear() || 
	 		           (date.getYear() == sg_date.getYear() && date.getMonth() <  sg_date.getMonth()) || 
	 		           (date.getYear() == sg_date.getYear() && date.getMonth() == sg_date.getMonth() && date.getDate() < sg_date.getDate())
	 	        ) {
	 	             return [false, ""]
	 	        }
	 	        return [true, ""];
	 	}});
	});
	
	
	//設定報名結束日期表
	$("#apl_end").click(function(){
		
		var somedate1 = new Date();
        var somedate2 = new Date($('#sg_date').val());
        $('#apl_end').datetimepicker({
        	timepicker: false,
        	format: 'Y-m-d',
            beforeShowDay: function(date) {
          	  if (  date.getYear() <  somedate1.getYear() || 
   		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
   		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
   		             ||
   		            date.getYear() >  somedate2.getYear() || 
   		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
   		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
                ) {
                     return [false, ""]
                }
                return [true, ""];
        }});
		
	});

    
    
         
   	//篩選只有慢跑及自行車可以編輯地圖
   	//載入時判斷
   	var value = $("#sp_no option:selected").val();
	if(value == "SP006" || value == "SP007"){
		$("#mapSetting").css("display","");
	}
	//選取時判斷
   	$("#sp_no").change(function(){
   		var value = $("#sp_no option:selected").val();
   		if(value == "SP006" || value == "SP007"){
   			$("#mapSetting").css("display","");
   		}else{
   			$("#mapSetting").css("display","none");
   		}
   	});     
         
         
   	//google map設定
   	
   	
   	function initMap(){
   		navigator.geolocation.getCurrentPosition(myLoc);
   	}
   	function myLoc(pos){
   		var map;
   	   	var directionsService;
   	    var directionsDisplay;
   		var loc = {lat: pos.coords.latitude, lng: pos.coords.longitude};
   	
   		map = new google.maps.Map(document.getElementById('map'), {
   			center: loc,
   			zoom: 16
   		});
   		//設置marker
   		var marker = new google.maps.Marker({
   			position: loc,
   			map: map,
   			animation: google.maps.Animation.DROP,
   			draggable: true
   		});
   		
   		
   	//定位場館位置
   		$("#v_no").change(function(){
   			var v_no = $("#v_no").val();
   			$.ajax({
				type: "POST",
				url: "<%= request.getContextPath()%>/venue/venue.do",
				data: {"action" : "getLoc", "v_no" : v_no},
				dataType: "json",
				error: function(){
					alert("發生錯誤!");
				},
				success: function(data){
					var v_lat = parseFloat(data.v_lat);
					var v_long = parseFloat(data.v_long);
					map = new google.maps.Map(document.getElementById('map'), {
						center: {lat: v_lat, lng: v_long},
						zoom:14
					});
					var marker = new google.maps.Marker({
			   			position: {lat: v_lat, lng: v_long},
			   			map: map,
			   			animation: google.maps.Animation.DROP,
			   			draggable: false
			   		});
				}
			});
   		});
   		
   		
   		var loc_start;
        var loc_end
        // 地圖查詢定位 Geocoding API
        var geocoder = new google.maps.Geocoder();
        var startSearchBtn = document.getElementById("startSearchBtn");
        var endSearchBtn = document.getElementById("endSearchBtn");
		//起點座標查詢
        startSearchBtn.addEventListener("click", function(){
            var startAddr = document.getElementById("startAddr").value;
            //重置地圖座標
        	map = new google.maps.Map(document.getElementById('map'), {
       			center: loc,
       			zoom: 16
       		});
            geocoder.geocode({'address': startAddr}, function(results, status){
                if(status == 'OK'){
                    var loc = results[0].geometry.location;
                    map.setCenter(loc);
                    //將座標JSON物件轉成字串
					$("#loc_start").val(JSON.stringify(results[0].geometry.location));
                    var markerRoute = new google.maps.Marker({
                        position: loc,
                        map: map
                    });
					loc_start = loc;
                }else{
                    console.log(status);
                }
            });
        }, false);
      //終點座標查詢
        endSearchBtn.addEventListener("click", function(){
            var endAddr = document.getElementById("endAddr").value;
            //重置地圖座標
        	map = new google.maps.Map(document.getElementById('map'), {
       			center: loc,
       			zoom: 16
       		});
            geocoder.geocode({'address': endAddr}, function(results, status){
                if(status == 'OK'){
                    var loc = results[0].geometry.location;
                    map.setCenter(loc);
                  	//將座標JSON物件轉成字串
					$("#loc_end").val(JSON.stringify(results[0].geometry.location));
                    var markerRoute = new google.maps.Marker({
                        position: loc,
                        map: map
                    });
                    loc_end = loc;
                }else{
                    console.log(status);
                }
            });
        }, false);



        // 載入路線服務與路線顯示圖層 Directions API
        directionsService = new google.maps.DirectionsService();
        directionsDisplay = new google.maps.DirectionsRenderer();
        var path=[];
        
        var road = document.getElementById("road");
        road.addEventListener("click", function(){
        // 放置路線圖層
	        directionsDisplay.setMap(map);
	        // 路線相關設定
	        var request = {
	         origin: loc_start,
	         destination: loc_end,
	         travelMode: 'WALKING' //腳踏車模式無法使用?
	        };
	        
	        // 繪製路線
	        directionsService.route(request,function(result, status){
	         if(status == 'OK'){
	             directionsDisplay.setDirections(result);
	             //顯示路線距離
	             $("#distance").text("總距離為： "+result.routes[0].legs[0].distance.text);
	        	
	           //先清空path
	          	 path=[];
	             //抓取路線各個點座標存入path陣列供計算海拔用
				var pathobj = result.routes[0].overview_path;
				for(var i = 0; i < pathobj.length; i++){
					path.push(pathobj[i]);
				}
	             //開始計算海拔高度
	            displayPathElevation(path,elevator);
	         }else{
	             console.log(status);
	         }
	        });
	        
	      //計算海拔高度
	        var elevator = new google.maps.ElevationService;
	        
	        function displayPathElevation(path, elevator) {
	          elevator.getElevationAlongPath({
	            'path': path,
	            'samples': 100
	          }, plotElevation);
	        }
	        
	        function plotElevation(elevations, status) {
	        	var meterValue = [];
	        	//抓到各個點的海拔高度(M)存入meterValue陣列
	        	for (var i = 0; i < elevations.length; i++) {
	        		meterValue.push(elevations[i].elevation);
// 	console.log(elevations[i].elevation);
	              }
	        	$("#myChart").css("display","");
	        	drawChart(meterValue);
	        }

        }, false);//road click
        
   	} //myLoc
   	
    
   	
	function drawChart(meterValue){
   		var labelArr = [];
   	   	for(i=0;i<100;i++){
   	   		labelArr.push("");
   	   	}
   	   	
   	   	var ctx = document.getElementById("myChart").getContext('2d');
   	   	var myChart = new Chart(ctx, {
   	   	    type: 'line',
   	   	    data: {
   	   	        labels: labelArr,
	   	   	     datasets : [
	   	             {
	   	                 label: "路線坡度",  //当前数据的说明
	   	                 fill: true,  //是否要显示数据部分阴影面积块  false:不显示
	   	                 borderColor: "rgba(75,192,192,1)",//数据曲线颜色
	   	                 data: meterValue,  //填充的数据
	   	              	pointRadius:0,
	   	             }
	   	         ]
   	   	    },
   	   	    options: {
   	   	        scales: {
   	   	            yAxes: [{
   	   	                ticks: {
   	   	              		callback: function(value, index, values) {
                        	return value + "m";
 	   	              		},
 	   	                    beginAtZero:true
   	   	                }
   	   	            }]
   	   	        }
   	   	    }
   	   	});
   	}
   	
	
	
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"
        async defer></script>



</body>
</html>