<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
<%@ page import="com.sg_like.model.*"%>
<%@ page import="com.sg_mem.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Sg_infoGetByPkForRep</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

<style type="text/css">
	#infoSpan{
		margin-left:30%;
	}
	.table>tbody>tr>th{
		border-top:0px;
	}
	.backToList{
		cursor: pointer;
	}
	.backToList:active {
	  	transform: translateY(1px);
	}
	#map {
		height: 400px;  /* The height is 400 pixels */
		width: 100%;  /* The width is the width of the web page */
	}
	#btnGroup{
		display:flex;
		justify-content: space-between;
	}
	.panel-title{
		text-align: center;
    	text-align-last: center;
	}
	#sg_memList{ 
 		background-color: #FFFFE0; 
		border-radius: 10px; 
    	cursor: pointer; 
     	box-shadow: 0 2px #999; 
    	width:80%; 
     	text-align: center; 
     	text-align-last: center; 
 	} 
	#sg_memList:active {
	  	box-shadow: 0 1px #666;
	  	transform: translateY(1px);
	}
	#sg_memPic{
		width:50px;
		height:50px;
		border-radius: 50px;
		padding:3px;
	}
	
</style>
 
</head>
<body>
<%@ include file="/front-end/CA105G1_header.file" %>


<% 
	String rep_no = (String)request.getParameter("rep_no");
	String sg_no = (String)request.getParameter("sg_no");
	Sg_infoService svc = new Sg_infoService();
	Sg_infoVO vo = svc.GetByPK(sg_no);
	pageContext.setAttribute("Sg_infoVO", vo);
%>

<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-3">
			<div class="panel panel-success">
				<div class="panel-heading">
					<h3 class="panel-title">團員列表</h3>
				</div>
				<div class="list-group">
					<jsp:useBean id="sg_memSvc" scope="page" class="com.sg_mem.model.Sg_memService" />
					<%pageContext.setAttribute("sg_no", vo.getSg_no());%>
					<c:forEach var="sg_memVO" items="${sg_memSvc.getAllBySg_no(sg_no)}" > 
						<div class="list-group-item">
							<a href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp?mem_no=${sg_memVO.mem_no}">
							<div id="sg_memList">
								<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
								<img id="sg_memPic" src="<%= request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${sg_memVO.mem_no}">
								${memberlistSvc.getOneMem(sg_memVO.mem_no).mem_name}
							</div>
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="col-xs-12 col-sm-6">
			<form action="<%= request.getContextPath()%>/Sg_info/Sg_info.do" method="post" enctype="multipart/form-data">
			
				<table class="table table-hover">
					<i class="glyphicon glyphicon-circle-arrow-left icon-large brown backToList"></i>  <!-- 返回按鍵 -->
					<a href="<%= request.getContextPath()%>/back-end/sg_info/sg_infoBackEnd.jsp" display="none" id="linkBack">回到後台</a>
					
					<caption style="text-align:center">
						<h3>
							<!-- 團名 -->
							<img src="<%= request.getContextPath()%>/img/sporticons/${Sg_infoVO.sp_no}.svg" style="width:20px; height:auto;">
							${Sg_infoVO.sg_name }
							<!-- 團長 -->
							<span style="font-size: 0.5em;margin-left: 15px;">
								<i class="glyphicon glyphicon-user" style="padding-right:5px"></i>
								<jsp:useBean id="memberlistSvc2" scope="page" class="com.memberlist.model.MemberlistService"/>
								${memberlistSvc2.getOneMem(Sg_infoVO.mem_no).mem_name}
							</span>
						</h3>
					</caption>
					<tbody>
						<tr>  <!-- 照片 -->
							<td>
								<img id="showPic" style="width:90%; display:block; margin:auto;" class="img-responsive" src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}">
								<div class="uploadPic"></div><br>
							</td>
						</tr>
						<tr>
							<!-- 活動時間 -->
							<th style="border-top: 1px solid #ddd;">
								<span id="infoSpan">
<!-- 									<i class="glyphicon glyphicon-calendar" style="padding-right:5px"></i> -->
									<img src="<%= request.getContextPath()%>/img/calendar.svg" style="width:20px; height:auto;">
									<fmt:formatDate value="${Sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
								</span>
								<!-- 報名費用 -->
								<span style="margin-left:20px">
<!-- 									<i class="glyphicon glyphicon-usd"></i> -->
									<img src="<%= request.getContextPath()%>/img/coin.svg" style="width:20px; height:auto;">
									${Sg_infoVO.sg_fee}元
								</span>
							</th>
						</tr>
						<tr>
							<!-- 地點 -->
							<jsp:useBean id="venueSvc" scope="page" class="com.venue.model.VenueService"/>
							<th>
								<span id="infoSpan">
<!-- 									<i class="glyphicon glyphicon-map-marker"></i> -->
									<img src="<%= request.getContextPath()%>/img/location.svg" style="width:20px; height:auto;">	
									${venueSvc.getOneVenue(Sg_infoVO.v_no).v_name}
								</span>
							</th>
						</tr>
						<tr>
							<th>
								<!-- 報名截止日期 -->
								<span id="infoSpan">
									<img src="<%= request.getContextPath()%>/img/time.svg" style="width:20px; height:auto;">
									<fmt:formatDate value="${Sg_infoVO.apl_end}" pattern="yyyy-MM-dd"/>
								</span>
							</th>
						</tr> 
						<tr>
							<th style="border-top: 1px solid #ddd;">
								<div class="form-group text-center">
									<label for="exampleFormControlTextarea3">團長的話</label>
									<textarea readonly class="form-control" id="exampleFormControlTextarea3" style="resize:none;" rows="7">${Sg_infoVO.sg_extrainfo}</textarea>
								</div>
							</th>
						</tr>  
					</tbody>
				</table>
				<!-------------GOOGLE地圖 -------------->
					<div class="panel panel-info">
						<div class="panel-heading">
							<h4 class="panel-title text-center">
								位置資訊
							</h4>
						</div>
						<div>
								<div id="map"></div>
								<div id="distance"></div>
						</div>
					</div>
<canvas id="myChart" width="700" height="400" style="display: none"></canvas>
					
			</form>
			<form action="<%= request.getContextPath()%>/Sg_rep/Sg_rep.do">
				<input type="hidden" name="sg_no" value="<%= sg_no%>" >
				<input type="hidden" name="rep_no" value="<%= rep_no%>" >
				<input type="hidden" name="action" value="update" >
				<input type="submit" id="update" name="rep_status" value="無違規" class="btn btn-info btn-block" align="center">
				<input type="submit" id="update" name="rep_status" value="封鎖" class="btn btn-danger btn-block" align="center">
			</form>
<%-- 			<form action="<%= request.getContextPath()%>/Sg_rep/Sg_rep.do"> --%>
<%-- 				<input type="hidden" name="sg_no" value="<%= sg_no%>" > --%>
<%-- 				<input type="hidden" name="rep_no" value="<%= rep_no%>" > --%>
<!-- 				<input type="hidden" name="action" value="updateBlock" > -->
<!-- 				<input type="submit" id="update" value="封鎖" class="btn btn-danger btn-block" align="center"> -->
<!-- 			</form> -->
		</div> <!-- col-sm-6 -->
		<div class="col-xs-12 col-sm-3">
			<div class="panel panel-danger">
				<div class="panel-heading">
					<h3 class="panel-title">報名人數</h3>
				</div>
				<div class="list-group text-center" style="font-size:2em; font-weight:bold;">
					${Sg_infoVO.sg_ttlapl}
				</div>
			</div>
		</div>
	</div>
</div>


<%@ include file="/front-end/CA105G1_footer.file" %>





<script type="text/javascript">
		
	//google map設定
	var map;
	function initMap(){
		navigator.geolocation.getCurrentPosition(myLoc);
	}
	function myLoc(pos){
	
		var loc = {lat: pos.coords.latitude, lng: pos.coords.longitude};
	
		map = new google.maps.Map(document.getElementById('map'), {
			center: loc,
			zoom:14
		});
// 		//取得座標(JSON字串)
		
		var loc_start = <%=vo.getLoc_start()%>;
		var loc_end = <%=vo.getLoc_end()%>;
		if(loc_start == null || loc_end == null){
			//若沒有路線資料則設定場館位置
			var v_lat = parseFloat("${venueSvc.getOneVenue(Sg_infoVO.v_no).v_lat}");
			var v_long = parseFloat("${venueSvc.getOneVenue(Sg_infoVO.v_no).v_long}");
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
		}else{
			// 載入路線服務與路線顯示圖層 Directions API
	        directionsService = new google.maps.DirectionsService();
	        directionsDisplay = new google.maps.DirectionsRenderer();
	        var path=[];
	        
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
	            'samples': 50
	          }, plotElevation);
	        }
	        
	        function plotElevation(elevations, status) {
	        	var meterValue = [];
	        	//抓到各個點的海拔高度(M)存入meterValue陣列
	        	for (var i = 0; i < elevations.length; i++) {
	        		meterValue.push(elevations[i].elevation);
	              }
	        	$("#myChart").css("display","");
	        	drawChart(meterValue);
	        }
	        
		}
		
	} //myLoc
	
	
	function drawChart(meterValue){
   		var labelArr = [];
   	   	for(i=0;i<50;i++){
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