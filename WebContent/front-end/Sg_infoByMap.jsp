<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="com.sg_info.model.*"%>
<%@page import="com.venue.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#map {
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
</style>
</head>
<body>

<div id="map"></div>



<script type="text/javascript">
function initMap(){
	navigator.geolocation.getCurrentPosition(myLoc);
}

function myLoc(pos){

	var loc = {lat: pos.coords.latitude, lng: pos.coords.longitude};

	map = new google.maps.Map(document.getElementById('map'), {
		center: loc,
		zoom: 16
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
	  radius: 2000,
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
	List<Sg_infoVO> list = sg_infosvc.getAll();
	for(Sg_infoVO sg_infovo : list){
		if(sg_infovo.getV_no() != null) {
			VenueVO venuevo =venuesvc.getOneVenue(sg_infovo.getV_no());
			Double v_lat = venuevo.getV_lat();
			Double v_long = venuevo.getV_long();%>
			var sg_infoLoc = <%="{\"lat\":"+v_lat+",\"lng\":"+v_long+"}"%>;
			var dist = google.maps.geometry.spherical.computeDistanceBetween(
			           new google.maps.LatLng(loc),
			           new google.maps.LatLng(sg_infoLoc)
			         )
console.log(dist);
	// 		if(dist < 2000){
				
				var marker = new google.maps.Marker({
					position: sg_infoLoc,
					map: map,
					animation: google.maps.Animation.DROP,
					draggable: false
				});
				 markerArray.push(marker);
				 
				google.maps.event.addListener(marker, 'click', function(){
				  msg = "<%=sg_infovo.getSg_no()%>";
				  infowindow.setContent(msg);
			      infowindow.open(map, this);
				});
				
	// 		}
		<%}%>
	<%}%>
	
	
	
} //myLoc
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places&libraries=geometry"
        async defer></script>

</body>
</html>