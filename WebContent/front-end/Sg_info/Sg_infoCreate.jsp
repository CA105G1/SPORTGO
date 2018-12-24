<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
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
		height:100%;
	}
</style>


</head>
<body>
<% Sg_infoVO vo = (Sg_infoVO)request.getAttribute("Sg_infoVO");
%>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsg}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsg}">
			<li style="color:red">${message}</li>
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
								<input type="text" name="mem_no" value="M001">
							</td>
						</tr>
						<tr>
							<th>團名</th>
							<td>
								<input type="text" name="sg_name" 
									value="<%= (vo==null)? "" : vo.getSg_name()%>">
							</td>
						</tr>
						<tr>
							<th>活動時間</th>
							<td>
								<input type="text" id="sg_date" name="sg_date" 
									value="<%= (vo==null)? "" : vo.getSg_date()%>">
							</td>
						</tr>
						<tr>
							<th>報名開始日期</th>
							<td>
								<input type="text" id="apl_start" name="apl_start" 
									value="<%= (vo==null)? "" : vo.getApl_start()%>">
							</td>
						</tr>
						<tr>
							<th>報名截止日期</th>
							<td>
								<input type="text" id="apl_end" name="apl_end" 
									value="<%= (vo==null)? "" : vo.getApl_end()%>">
							</td>
						</tr>
						<tr>
							<th>報名費用</th>
							<td>
								<input type="text" name="sg_fee" 
									value="<%= (vo==null)? "" : vo.getSg_fee()%>">
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
								<select size="1" name="sp_no">
									<c:forEach var="sportVO" items="${sportSvc.all}" > 
										<option value="${sportVO.sp_no}">${sportVO.sp_name}
									</c:forEach>   
								</select>
							</td>
						</tr> 
						<tr>
							<th>場地名稱</th> <!-- 下拉選單 -->
							<td>	
								<input type="text" name="v_no" value="V000003">
							</td>
						</tr> 
						<tr>
							<th>人數上限</th>
							<td>
								<input type="text" name="sg_maxno" 
									value="<%= (vo==null)? "" : vo.getSg_maxno()%>">
							</td>
						</tr> 
						<tr>
							<th>人數下限</th>
							<td>
								<input type="text" name="sg_minno" 
									value="<%= (vo==null)? "" : vo.getSg_minno()%>">
							</td>
						</tr> 
						<tr>
							<th>團長的話</th>
							<td>
								<textarea name="sg_extrainfo" id="sg_extrainfo">
									<%= (vo==null)? "" : vo.getSg_extrainfo()%>
								</textarea>
							</td>
						</tr>  
					</tbody>
				</table>
				
				<!-------------GOOGLE地圖 -------------->
				<div>
					起點：<input type="text" name="startAddr" id="startAddr">
			        <input type="button" name="startSearchBtn" value="查詢" id="startSearchBtn">
					終點：<input type="text" name="endAddr" id="endAddr">
			        <input type="button" name="endSearchBtn" value="查詢" id="endSearchBtn">
				</div>
				<div>
			        <input type="button" name="road" id="road" value="規劃路線">
				</div>
				<div id="map"></div>
				
				<input type="submit" value="送出" class="btn btn-success btn-block">
				<input type="hidden" name="action"value="insert">
<input type="hidden" name="test" id="test">
			</form>
		</div>
		<div class="col-xs-12 col-sm-3"></div>
	</div>
</div>

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
// 				img.height=100;
// 				img.width=200;

				
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
   		
   		var startloc;
        var endloc
        // 地圖查詢定位 Geocoding API
        var geocoder = new google.maps.Geocoder();
        var startSearchBtn = document.getElementById("startSearchBtn");
        var endSearchBtn = document.getElementById("endSearchBtn");

        startSearchBtn.addEventListener("click", function(){
            var startAddr = document.getElementById("startAddr").value;
            // console.log(addr);
            //若重新設定起點則重置地圖
        	map = new google.maps.Map(document.getElementById('map'), {
       			center: loc,
       			zoom: 16
       		});
            geocoder.geocode({'address': startAddr}, function(results, status){
                if(status == 'OK'){
                    var loc = results[0].geometry.location;
                    map.setCenter(loc);
console.log(loc);
                    var markerRoute = new google.maps.Marker({
                        position: loc,
                        map: map
                    });
startloc = loc;
$("#test").val(loc);
                }else{
                    console.log(status);
                }
            });
        }, false);
        
        endSearchBtn.addEventListener("click", function(){
            var endAddr = document.getElementById("endAddr").value;
            // console.log(addr);
            //若重新設定起點則重置地圖
        	map = new google.maps.Map(document.getElementById('map'), {
       			center: loc,
       			zoom: 16
       		});
            geocoder.geocode({'address': endAddr}, function(results, status){
                if(status == 'OK'){
                    var loc = results[0].geometry.location;
                    map.setCenter(loc);
console.log(loc);
                    var markerRoute = new google.maps.Marker({
                        position: loc,
                        map: map
                    });
                    endloc = loc;
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
         origin: startloc,
         destination: endloc,
         travelMode: 'WALKING' //腳踏車模式無法使用?
        };
        // 繪製路線
        directionsService.route(request,function(result, status){
         if(status == 'OK'){
             directionsDisplay.setDirections(result);
             console.log(result);
         }else{
             console.log(status);
         }
        });

        }, false);
   		
   	}
   	
    
	
	
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"
        async defer></script>


</body>
</html>