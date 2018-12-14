<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script>
	var map;
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
			draggable: true
		});
	}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places" async defer></script>


<style type="text/css">
	#map {
        height: 550px;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
    }
    .inner{
    	display: flex;
		margin-bottom:10px;
		margin-right:10px;
    	border-radius: 30px;
    	
    	justify-content: center;
    	align-items: center;

    	cursor: pointer;
    	box-shadow: 0 3px #999;	
    }
    .inner:active {
	  	box-shadow: 0 1px #666;
	  	transform: translateY(1px);
	}
    .outer{
    	display: flex;
    	flex-direction: row;
    	flex-wrap: wrap;
    	justify-content: center;
    	align-items: center;
    }
    .img-responsive{
    	border-radius: 50px;
    }
</style>



</head>
<body>


	<div class="container-fluid">
		<div class="row">

			<div class="col-xs-12 col-sm-5">
				<div class="text-center">
					<form action="" class="form-horizontal">
						<input type="text" name="addr" id="addr">
						<input type="submit" name="search" value="查詢" id="btnSubmit">
					</form>
				</div>
				<div id="map"></div>
			</div>
			<div class="col-xs-12 col-sm-7 outer">
				<div class="btn inner" style="background-image:url(img/bb.png);">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>


				<div class="btn inner" style="background-color: lightpink">
					<div class="col-xs-12 col-sm-5">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-7">

						<table class="table table-hover">
							<thead>
								<tr>
									<th>鬥牛要不要</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>活動時間:</td>
									<td>2018-12-31</td>
								</tr>
								<tr>
									<td>報名截止日:</td>
									<td>2018-12-20</td>
								</tr>
							</tbody>
						</table>
						
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>

				<div class="btn inner" style="background-color: lightblue">
					<div class="col-xs-12 col-sm-4">
						<img src="img/honda.jpeg" class="img-responsive img-rounded">
					</div>
					<div class="col-xs-12 col-sm-8">
						<h2>標題</h2>
						<p>活動時間</p>
						<p>報名截止日</p>
					</div>
				</div>



			</div>


		</div>
	</div>



	








</body>
</html>