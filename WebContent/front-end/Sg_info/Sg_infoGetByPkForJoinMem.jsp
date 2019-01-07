<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
<%@ page import="com.sg_like.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Sg_infoGetByPkForJoinMem</title>
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
// MemberlistService memsvc = new MemberlistService();
// MemberlistVO memberlistVO = memsvc.getOneMem("M002");


// 	Sg_infoVO vo = (Sg_infoVO)request.getAttribute("Sg_infoVO");
	pageContext.setAttribute("Sg_infoVO", vo);
 	MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
%>

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
								
								<caption class="text-center">我是Sg_infoGetByPkForJoinMem</caption>
								<tbody>
									<tr>  <!-------- 照片 -------->
										<td colspan="2">
											<img id="showPic" class="img-responsive" src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}">
										</td>
									</tr>
									<tr>
										<th>團長</th>
										<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
										<td>${memberlistSvc.getOneMem(Sg_infoVO.mem_no).mem_name}</td>
									</tr>
									<tr>
										<th>團名</th>
										<td class="writable">${Sg_infoVO.sg_name }</td>  
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
										<td class="writable">${Sg_infoVO.sg_fee}</td> 
									</tr> 
									<tr>
										<th>運動種類</th>
										<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService"/>
										<td id="sp_no">${sportSvc.getByPK(Sg_infoVO.sp_no).sp_name}</td> 
									</tr> 
									<tr>
										<th>場地名稱</th>
										<jsp:useBean id="venueSvc" scope="page" class="com.venue.model.VenueService"/>
										<td id="v_no">${venueSvc.getOneVenue(Sg_infoVO.v_no).v_name}</td> 
									</tr> 
									<tr>
										<th>目前報名人數</th>
										<td>${Sg_infoVO.sg_ttlapl}</td> <!-- 之後動態增加 -->
									</tr> 
									<tr>
										<th>團長的話</th>
										<td class="writable">${Sg_infoVO.sg_extrainfo}</td> 
									</tr>  
								</tbody>
							</table>
							<!-------------GOOGLE地圖 -------------->
								<div class="panel panel-default">
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




<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-3">
		</div>
		<div class="col-xs-12 col-sm-6" id="btnGroup">
			<div class="btn like" id="likebtn" style="display:none">
				<img src="<%= request.getContextPath()%>/img/love.png" id="like">
				加入收藏
			</div>
			<div class="btn like" id="dislikebtn" style="display:">
				<img src="<%= request.getContextPath()%>/img/love_white.png" id="dislike">
				加入收藏
			</div>
			
			<div class="btn" id="outbtn">
				<img src="<%= request.getContextPath()%>/img/exit.png">
				退出揪團
			</div>
			
			<div class="btn" id="sharebtn">
				<img src="<%= request.getContextPath()%>/img/share.png">
				分享給好友
			</div>
			
			<div class="btn" id="repbtn">
				<img src="<%= request.getContextPath()%>/img/warning.png">
				檢舉
			</div>
		</div>
		<div class="col-xs-12 col-sm-3">
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
	  
		/////////////////收藏按鍵設定////////////////////////
		//若該會員有收藏該揪團則顯示實心
		<% Sg_likeService likesvc = new Sg_likeService();%>
		if(<%= likesvc.isLike(vo.getSg_no(), memberlistVO.getMem_no())%>){  
			$("#likebtn").css("display","");
			$("#dislikebtn").css("display","none");
		}else{
			$("#likebtn").css("display","none");
			$("#dislikebtn").css("display","");
		}
		$("#likebtn").click(function(){
			 $("#dislikebtn").css("display","");
			 $("#likebtn").css("display","none");
			$.ajax({
				type: "POST",
				url: "<%= request.getContextPath()%>/Sg_like/Sg_like.do",
				data: {"action" : "delete", "sg_no" : "<%= vo.getSg_no()%>", "mem_no" : "<%= memberlistVO.getMem_no()%>"},
				dataType: "json",
				error: function(){
					alert("發生錯誤!");
				},
				success: function(data){
					alert("取消收藏");
				}
			});
		});
		
		$("#dislikebtn").click(function(){
			 $("#likebtn").css("display","");
			 $("#dislikebtn").css("display","none");
			$.ajax({
				type: "POST",
				url: "<%= request.getContextPath()%>/Sg_like/Sg_like.do",
				data: {"action" : "insert", "sg_no" : "<%= vo.getSg_no()%>", "mem_no" : "<%= memberlistVO.getMem_no()%>"},
				dataType: "json",
				error: function(){
					alert("發生錯誤!");
				},
				success: function(data){
					alert("成功加入收藏");
				}
			});
		});
		//////////////////加入揪團按鍵設定///////////////////////////
		$("#outbtn").click(function(){
			swal({
			  title: "確定退出?", type: "warning", showCancelButton: true, showCloseButton: true,
			}).then(
				function (result) {
				if(result){
					document.location.href="<%= request.getContextPath()%>/front-end/memberlist/MemManager.do?action=Member_Sg";
					$.ajax({
						type: "POST",
						url: "<%= request.getContextPath()%>/Sg_mem/Sg_mem.do",
						data: {"action" : "delete", "sg_no" : "<%= vo.getSg_no()%>", "mem_no" : "<%= memberlistVO.getMem_no()%>"},
						dataType: "json",
						error: function(){
							alert("發生錯誤!");
						},
						success: function(data){
							
						}
					});
				}
			});
		});
		
		
		$("#repbtn").click(function(){
			swal({
				title: '正義之士就是你!',type: "warning",showCancelButton: true, showCloseButton: true,
				html:
	    			'<form>' +
	    			  '<div class="form-group">' +
	    			    '<label class="pull-left">檢舉原因：</label>' +
	    			    '<select id="rep_type" class="form-control">' +
	    			    '<option value="不雅言語">不雅言語</option>'+
					    '<option value="廣告推銷">廣告推銷</option>'+
					    '<option value="其他">其他</option>'+
					    '</select>'+
	    			  '</div>' +
	    			  '<div class="form-group">' +
	    			    '<label for="rep_cont" class="pull-left">其他原因說明：</label>' +
	    			    '<textarea id="rep_cont" style="resize:none;height:100px;width:100%;"></textarea>' +
	    			  '</div>' +
	    			'</form>',	
			}).then(
				function (result) {
					if(result){
						var dataStr = {};
						dataStr.action = "insert";
						dataStr.sg_no = "${Sg_infoVO.sg_no}";
						dataStr.mem_no = "<%= memberlistVO.getMem_no()%>";
						dataStr.rep_type = $("#rep_type").val().trim();
						dataStr.rep_cont = $("#rep_cont").val().trim();
						$.ajax({
							type: "POST",
							url: "<%= request.getContextPath()%>/Sg_rep/Sg_rep.do",
							data: dataStr,
							dataType: "json",
							error: function(){
								alert("發生錯誤!");
							},
							success: function(data){
								
							}
						});
					};
				});
		}); //repbtn click
		
		
		
	
	

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"
        async defer></script>



</body>
</html>