<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
<%@ page import="com.sg_like.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Sg_infoGetByPkForHead</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>

<style type="text/css">
	th{
		text-align:center;
	}
	td{
		width: 65%;
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
	
</style>
 
</head>
<body>
<%@ include file="/front-end/CA105G1_header.file" %>


<% 
	String sg_no = (String)request.getParameter("Sg_no");
	Sg_infoService svc = new Sg_infoService();
	Sg_infoVO vo = svc.GetByPK(sg_no);
	
	
	
// 	Sg_infoVO vo = (Sg_infoVO)request.getAttribute("Sg_infoVO");
    pageContext.setAttribute("Sg_infoVO", vo);
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
		
			<div role="tabpanel">
	<!------------- 標籤面板：標籤區 ------------------->
			    <ul class="nav nav-tabs" role="tablist">
			        <li role="presentation" class="active">
			            <a href="#sg_info" aria-controls="sg_info" role="tab" data-toggle="tab">揪團資訊</a>
			        </li>
			        <li role="presentation">
			            <a href="#msgBoard" aria-controls="msgBoard" role="tab" data-toggle="tab">留言板</a>
			        </li>
			    </ul>
    <!------------------ 標籤面板：內容區 ------------------------->
			    <div class="tab-content">
			        <div role="tabpanel" class="tab-pane active" id="sg_info">
			        	<div class="pic"><img src=""></div>
						<form action="<%= request.getContextPath()%>/Sg_info/Sg_info.do" method="post" enctype="multipart/form-data">
						
							<table class="table table-hover table-striped table-bordered text-center">
								<i class="glyphicon glyphicon-circle-arrow-left icon-large brown backToList"></i>  <!-- 返回按鍵 -->
								<a href="<%= request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" display="none" id="linkBack">回到揪團首頁</a>
								
								<caption class="text-center">我是Sg_infoGetByPkForHead</caption>
								<tbody>
									<tr>  <!-------- 照片 -------->
										<td colspan="2">
											<img id="showPic" class="img-responsive" src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}">
											<div class="uploadPic"></div><br>
										</td>
									</tr>
									<tr>
										<th>揪團編號</th>
										
										<td>${Sg_infoVO.sg_no}</td>
									</tr>
									<tr>
										<th>團長</th>
										<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
										<td>${memberlistSvc.getOneMem(Sg_infoVO.mem_no).mem_name}</td>
									</tr>
									<tr>
										<th>團名</th>
										<td class="writable">${Sg_infoVO.sg_name }</td>  <!-- sg_info0 -->
									</tr>
									<tr>
										<th>活動時間</th>
										<td id="sg_date"><fmt:formatDate value="${Sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/></td>
									</tr>
									<tr>
										<th>報名截止日期</th>
										<td id="apl_end"><fmt:formatDate value="${Sg_infoVO.apl_end}" pattern="yyyy-MM-dd"/></td>
									</tr>
									<tr>
										<th>報名費用</th>
										<td class="writable">${Sg_infoVO.sg_fee}</td> <!-- sg_info1 -->
									</tr> 
									<tr>
										<th>權限</th>
										<td id="sg_per">${Sg_infoVO.sg_per}</td> <!-- 下拉選單 -->
									</tr>  
									<tr>
										<th>運動種類</th>
										<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService"/>
										<td id="sp_no">${sportSvc.getByPK(Sg_infoVO.sp_no).sp_name}</td> <!-- 下拉選單 -->
									</tr> 
									<tr>
										<th>場地名稱</th>
										<jsp:useBean id="venueSvc" scope="page" class="com.venue.model.VenueService"/>
										<td id="v_no">${venueSvc.getOneVenue(Sg_infoVO.v_no).v_name}</td> <!-- 下拉選單 -->
									</tr> 
									<tr>
										<th>人數上限</th>
										<td class="writable">${Sg_infoVO.sg_maxno}</td>  <!-- sg_info2 -->
									</tr> 
									<tr>
										<th>人數下限</th>
										<td class="writable">${Sg_infoVO.sg_minno}</td> <!-- sg_info3 -->
									</tr> 
									<tr>
										<th>目前報名人數</th>
										<td>${Sg_infoVO.sg_ttlapl}</td> <!-- 之後動態增加 -->
									</tr> 
									<tr>
										<th>團長的話</th>
										<td class="writable">${Sg_infoVO.sg_extrainfo}</td> <!-- sg_info4 -->
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
							
							
							<input type="button" id="update" value="編輯" class="btn btn-info btn-block" align="center" style="display: ">
							<input type="submit" id="done" value="完成" class="btn btn-info btn-block" align="center" style="display: none">
							
							<input type="hidden" name="sg_no" value="<%= vo.getSg_no()%>" >
							<input type="hidden" name="mem_no" value="<%= vo.getMem_no()%>" >
							<input type="hidden" name="sg_pic_ext" value="<%= vo.getSg_pic_ext()%>" >
							<input type="hidden" name="loc_start" id="loc_start" value=<%= vo.getLoc_start() %>>
							<input type="hidden" name="loc_end" id="loc_end" value=<%= vo.getLoc_end() %>>	
							<input type="hidden" name="action" value="update">
						</form>
						<form id="dismissForm">
							<input type="button" class="btn btn-danger btn-block" id="dismiss" value="解散" >
							<input type="hidden" name="action" value="dismiss">
							<input type="hidden" name="sg_status" value="解散">
							<input type="hidden" name="sg_no" value="<%= vo.getSg_no()%>">
						</form>
			        </div>
			        <div role="tabpanel" class="tab-pane" id="msgBoard">
			        	<textarea id="showMsg" readonly style="resize:none;height:300px;width:100%;"> 132 </textarea>
			        	<input type="text" name="sg_msg">
			        	<input type="button" class="btn" value="送出">
			        </div>
			    </div> <!-- tab-content -->
			</div> <!-- tabpanel -->
		</div> <!-- col-sm-6 -->
		<div class="col-xs-12 col-sm-3"></div>
	</div>
</div>




<%@ include file="/front-end/CA105G1_footer.file" %>


<script type="text/javascript">
		
		
	  $("#update").click(function(){
		//編輯照片
		$(".uploadPic").html(function(index, content){
			return "<input type='file' id='sg_pic' class='img-responsive' name='sg_pic'>"
		});
		//開始編輯
	    $(".writable").html(function(index, content){
	    return "<input type='text' id='content"+ index + "' name='sg_info"+index + "' value='"+content+"'>";
	    });
	    //編輯活動時間
	    $("#sg_date").html(function(index, content){
		    return "<input type='text' id='sg_date2' name='sg_date' value='"+content+"'>";
		    });
	    //編輯報名結束日期
	    $("#apl_end").html(function(index, content){
		    return "<input type='text' id='apl_end2' name='apl_end' value='"+content+"'>";
		    });
	    //編輯權限
	    $("#sg_per").html(function(index, content){
		    return "<select name='sg_per'><option value='公開'>公開</option><option value='僅限社團'>僅限社團</option></select>";
		    });
	    //編輯運動種類
	    ////////////////////////////////////////下拉選單值帶不回來//////////////////////////////////////
    	 $("#sp_no").html(function(index, content){
 		    return "<select name='sp_no' id='sp_no'><c:forEach var='sportVO' items='${sportSvc.all}' > <option value='${sportVO.sp_no}' ${(Sg_infoVO.sp_no == sportVO.sp_no)? 'selected' : ''}>${sportVO.sp_name}</c:forEach></select>";
 		    });
    	//編輯場地
    	 $("#v_no").html(function(index, content){
 		    return "<select name='v_no' id='v_no'><option value=''>請選擇場地<c:forEach var='venueVO' items='${venueSvc.all}' > <option value='${venueVO.v_no}' ${(Sg_infoVO.v_no == venueVO.v_no)? 'selected' : ''}>${venueVO.v_name}</c:forEach></select>";
 		    });
    	//篩選只有慢跑及自行車可以編輯地圖
    	$("#sp_no").change(function(){
    		var value = $("#sp_no option:selected").val();
    		if(value == "SP006" || value == "SP007"){
    			$("#mapSetting").css("display","");
    		}else{
    			$("#mapSetting").css("display","none");
    		}
    	});
	    	   
	
	    
	    
	    //設定活動時間表
	    var sg_date = new Date();
        $('#sg_date2').datetimepicker({
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
        
      //設定報名結束日期表
        var somedate2 = new Date($('#sg_date').val());
           $('#apl_end').datetimepicker({
        	   timepicker: false,
        	   format: 'Y-m-d',
               beforeShowDay: function(date) {
             	  if (  date.getYear() >  somedate2.getYear() || 
      		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
      		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
                   ) {
                        return [false, ""]
                   }
                   return [true, ""];
           }});
	    
	    
	    $("#update").css("display","none");
	    $("#done").css("display","");
	    
	    
	    
	  //照片預覽
		$("#sg_pic").change(function(){
			readURL(this);
		});
		function readURL(input){
			if(input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e){
					var showPic = document.getElementById("showPic");
					showPic.src=e.target.result;
//	 				showPic.height=100;
//	 				showPic.width=200;
					
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	    
		
		
		
		
		
		
		// 編輯時地圖查詢定位 Geocoding API
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
		
		
		
		
	  });  //update click
	  
		
	  // Double check是否刪除
	  $("#dismiss").click(function(){
		  if (confirm("確定解散嗎!")) {
			$("#dismissForm").submit();
		  } else {
		  }
	  });
	  
	  
	  
	//載入時google map設定
	var map;
	var loc;
	function initMap(){
		navigator.geolocation.getCurrentPosition(myLoc);
	}
	function myLoc(pos){
	
		loc = {lat: pos.coords.latitude, lng: pos.coords.longitude};
	
		map = new google.maps.Map(document.getElementById('map'), {
			center: loc,
			zoom:14
		});
		//取得座標(JSON字串)
		var loc_start = <%= vo.getLoc_start()%>;
		var loc_end = <%= vo.getLoc_end()%>;
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
		}
		
		
		
		 
		
		
	} //myLoc
	  
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"
        async defer></script>



</body>
</html>