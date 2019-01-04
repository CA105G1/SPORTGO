<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Sg_infoCreate</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style type="text/css">
	th{
		text-align:center;
	}
	#map {
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
	#sg_extrainfo{
		resize:none;
		height:100px;
		width:100%;
	}
</style>



</head>
<body>
<%@ include file="/front-end/CA105G1_header.file" %>

<%
MemberlistService memsvc = new MemberlistService();
MemberlistVO memberlistVO = memsvc.getOneMem("M002");


// 	MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO"); 
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

<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-3"></div>
		<div class="col-xs-12 col-sm-6">
			<form action="<%= request.getContextPath()%>/Sg_info/Sg_info.do" method="post" enctype="multipart/form-data">
				<table class="table table-hover table-striped table-bordered text-center">
					<a href="<%= request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">回到揪團首頁</a>
					<caption class="text-center">我是Sg_infoCreate</caption>
					<tbody>
					<!------------ 圖片上傳 ------------>
						<tr>
							<td colspan="2" class="uploadPicTd">
								<img src="<%= request.getContextPath()%>/img/no-image.PNG" id="showPic">
								<input type="file" id="sg_pic" name="sg_pic"><br>
							</td>
						</tr>
						<tr>
							<th>團長</th>
							<td>
								<%=memberlistVO.getMem_name()%>
								<input type="hidden" name="mem_no" value="<%=memberlistVO.getMem_no()%>">
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
							<th>報名開始日期</th>
							<td>
								<input type="text" id="apl_start" name="apl_start" 
									value="${param.apl_start }">
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
						<tr>
							<th>權限</th>
							<td>
								<select name="sg_per">
									<option value="公開">公開</option>
									<option value="僅限社團">僅限社團</option>
								</select>
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
							<select name='v_no'>
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
					<div>
						起點：<input type="text" name="startAddr" id="startAddr">
				        <input type="button" name="startSearchBtn" value="查詢" id="startSearchBtn">
						終點：<input type="text" name="endAddr" id="endAddr">
				        <input type="button" name="endSearchBtn" value="查詢" id="endSearchBtn">
					</div>
					<div>
				        <input type="button" name="road" id="road" value="規劃路線">
					</div>
				</div>
				<div id="distance"></div>
				<div id="map"></div>
				
				<input type="submit" value="送出" class="btn btn-success btn-block">
				<input type="hidden" name="action"value="insert">
				<input type="hidden" name="loc_start" id="loc_start">
				<input type="hidden" name="loc_end" id="loc_end">
			</form>
		</div>
		<div class="col-xs-12 col-sm-3"></div>
	</div>
</div>

<%@ include file="/front-end/CA105G1_footer.file" %>

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
	$.datetimepicker.setLocale('zh'); // kr ko ja en
	
	var sg_date = new Date();
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
	
	
	//設定報名開始日期表
    var apl_start = new Date();
    $('#apl_start').datetimepicker({
    	timepicker: false,
    	format: 'Y-m-d',
        beforeShowDay: function(date) {
      	  if (  date.getYear() <  apl_start.getYear() || 
		           (date.getYear() == apl_start.getYear() && date.getMonth() <  apl_start.getMonth()) || 
		           (date.getYear() == apl_start.getYear() && date.getMonth() == apl_start.getMonth() && date.getDate() < apl_start.getDate())
            ) {
                 return [false, ""]
            }
            return [true, ""];
    }});
    
    
    //設定報名結束日期表@@@@@@@@@@@@@@@@@@@@@@@@開始日期抓不到!!!!!!!!!
    var startDay = new Date($('#apl_start').val());
         var endDay = new Date($('#sg_date').val());
         $('#apl_end').datetimepicker({
        	 timepicker: false,
         	format: 'Y-m-d',
             beforeShowDay: function(date) {
           	  if (  date.getYear() <  startDay.getYear() || 
    		           (date.getYear() == startDay.getYear() && date.getMonth() <  startDay.getMonth()) || 
    		           (date.getYear() == startDay.getYear() && date.getMonth() == startDay.getMonth() && date.getDate() < startDay.getDate())
    		             ||
    		            date.getYear() >  endDay.getYear() || 
    		           (date.getYear() == endDay.getYear() && date.getMonth() >  endDay.getMonth()) || 
    		           (date.getYear() == endDay.getYear() && date.getMonth() == endDay.getMonth() && date.getDate() > endDay.getDate())
                 ) {
                      return [false, ""]
                 }
                 return [true, ""];
         }});
         
         
        
         
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
	         }else{
	             console.log(status);
	         }
	        });

        }, false);
        
   	} //myLoc
   	
    
	
	
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"
        async defer></script>


</body>
</html>