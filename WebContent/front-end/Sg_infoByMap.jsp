<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
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
	  radius: 500,
	  strokeOpacity: 0,
	  fillColor: '#f00',
	  fillOpacity: 0.35,
	  map: map
	});


	
	<%
	Map<String, String> mapLoc = (Map<String, String>) getServletContext().getAttribute("mapLoc");
	Set<String> keys = mapLoc.keySet();
	for(String key : keys){%>
		var sg_infoLoc = <%=mapLoc.get(key)%>;
		var dist = google.maps.geometry.spherical.computeDistanceBetween(
		           new google.maps.LatLng(loc),
		           new google.maps.LatLng(sg_infoLoc)
		         )
		console.log(dist);
		if(dist < 500){
			var marker = new google.maps.Marker({
				position: sg_infoLoc,
				map: map,
				animation: google.maps.Animation.DROP,
				draggable: false
			});
			
		}
	<%}%>
	
} //myLoc
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places&libraries=geometry"
        async defer></script>

</body>
</html>