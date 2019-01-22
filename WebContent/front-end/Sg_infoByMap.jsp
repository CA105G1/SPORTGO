<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.sg_info.model.*"%>
<%@page import="com.memberlist.model.*"%>
<%@page import="com.venue.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
	#map {
		height: 500px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
	.iw-title {
	font-weight: 400;
	padding: 10px;
	background-color: #DDDDDD;
	color: white;
	margin: 0;
	border-radius: 10px;
}
</style>
</head>
<body>
<!-- <div class="form-group"> -->
<!-- 	<label for="setRadius">搜尋半徑</label> -->
<!-- 	<div class="input-group" style="width:20%"> -->
<!-- 		<input type="text" id="setRadius" value="5000" class="form-control"> -->
<!-- 		<div class="input-group-addon">公尺</div> -->
<!-- 		<div class="input-group-btn"> -->
<!-- 			<button class="btn btn-info" type="button" id="setRadiusBtn" onclick="initMap()"> -->
<!-- 				<i class="glyphicon glyphicon-search"></i> // 因為語套版衝到，需更換 -->
<!-- 			</button> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<label for="setRadius">搜尋半徑</label>
	<div class="input-group mb-3" style="width:20%">
	<input type="text" id="setRadius" value="2000" class="form-control">
 	<div class="input-group-append">
    	<span class="input-group-text">公尺</span>
  	</div>
  	<div class="input-group-btn">
		<button class="btn btn-info" type="button" id="setRadiusBtn1" onclick="initMap()">
			<i class="fa fa-search"></i>
		</button>
	</div>
</div>
					


<div id="map"></div>



<script type="text/javascript">

function initMap(){
	navigator.geolocation.getCurrentPosition(myLoc);
}

function myLoc(pos){

	var loc = {lat: 24.969367, lng: 121.190733};

	map = new google.maps.Map(document.getElementById('map'), {
		center: loc,
		zoom: 14
	});
	
	var marker = new google.maps.Marker({
		position: loc,
		map: map,
		animation: google.maps.Animation.DROP,
		draggable: false
	});


	//畫圓
	var circle = new google.maps.Circle({
	  center: loc,
	  radius: parseInt($("#setRadius").val()),
	  strokeOpacity: 0,
	  fillColor: '#76A2DC',
	  fillOpacity: 0.35,
	  map: map
	});

	
	var markerArray = [];
	var infowindow = new google.maps.InfoWindow();
	
	<%
	Sg_infoService sg_infosvc = new Sg_infoService();
	VenueService venuesvc = new VenueService();
	List<Sg_infoVO> list = sg_infosvc.getAllForPublic();
	for(Sg_infoVO sg_infovo : list){
		//判斷揪團是否有場地資料
		if(sg_infovo.getV_no() != null) {
			//取得該場地座標並計算距離
			VenueVO venuevo =venuesvc.getOneVenue(sg_infovo.getV_no());
			Double v_lat = venuevo.getV_lat();
			Double v_long = venuevo.getV_long();%>
			var sg_infoLoc = <%="{\"lat\":"+v_lat+",\"lng\":"+v_long+"}"%>;
			var dist = google.maps.geometry.spherical.computeDistanceBetween(
			           new google.maps.LatLng(loc),
			           new google.maps.LatLng(sg_infoLoc)
			         )
console.log(dist);
			//距離低於搜尋範圍才標示marker
			if(dist < parseInt($("#setRadius").val())){
				
				var marker = new google.maps.Marker({
					position: sg_infoLoc,
					map: map,
					animation: google.maps.Animation.DROP,
					draggable: false,
					icon:{
						url:'<%= request.getContextPath()%>/img/sporticons/<%=sg_infovo.getSp_no() %>.svg',
						scaledSize: new google.maps.Size(20, 32),
					}
				});
				 markerArray.push(marker);
<%MemberlistService memsvc = new MemberlistService();%>
				google.maps.event.addListener(marker, 'click', function(){
				  msg = '<div class="iw-title">'+
				  			'<a href="<%= request.getContextPath()%>/Sg_info/Sg_info.do?action=getByPK&sg_no=<%=sg_infovo.getSg_no()%>">'+
				  				'<%=sg_infovo.getSg_name()%>'+
			  				'</a>'+
		  				'</div>'+
		  				'<div style="padding:5px 5px 0px 5px;">'+
// 		  					'<i class="glyphicon glyphicon-user" style="padding-right:5px"></i>'+
		  					'<i class="fa fa-user" style="padding-right:5px"></i>'+
		  					'<%=memsvc.getOneMem(sg_infovo.getMem_no()).getMem_name()%>'+
  						'</div>'+
		  				'<div style="padding:5px;">'+
		  					'<i class="fa fa-clock-o" style="padding-right:5px"></i>'+
		  					'<fmt:formatDate value="<%=sg_infovo.getSg_date()%>" pattern="yyyy-MM-dd HH:mm"/>'+
	  					'</div>';
				  infowindow.setContent(msg);
			      infowindow.open(map, this);
				});
				
			}
		<%}%>
	<%}%>
	
	
	
} //myLoc
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places&libraries=geometry"
        async defer></script>

</body>
</html>