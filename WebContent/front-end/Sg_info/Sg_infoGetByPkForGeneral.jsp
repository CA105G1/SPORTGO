<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="com.sg_info.model.*"%>
<%@ page import="com.sg_like.model.*"%>
<%@ page import="com.sg_mem.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ page import = "com.friend.model.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Sg_infoGetByPkForGeneral</title>
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



 
</head>
<body>
<jsp:include page="/front-end/CA105G1_header.jsp" />

<% 
	Sg_infoVO vo = (Sg_infoVO)request.getAttribute("Sg_infoVO");	
	if(vo == null){vo = (Sg_infoVO)session.getAttribute("Sg_infoVO");}
    
    MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
System.out.println("memberlistVO= "+memberlistVO);
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
        	<div class="pic"><img src=""></div>
			<form action="<%= request.getContextPath()%>/Sg_info/Sg_info.do" method="post" enctype="multipart/form-data">
			
				<table class="table table-hover">
					<!-- 返回按鍵 -->
					<i class="glyphicon glyphicon-circle-arrow-left icon-large brown backToList"></i>
					<!-- 判斷返回鍵要回到社團還是揪團 -->
					<%String club_no =request.getParameter("club_no"); %>
					<c:if test="<%=club_no%> == null"/>  
					<a href="<%= request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" display="none" id="linkBack">回到揪團列表</a>
					<c:if test="<%=club_no%> != null"/>  
					<a href="<%= request.getContextPath()%>/front-end/club/Sg_infoList.jsp?club_no=<%=club_no %>" display="none" id="linkBack">回到揪團列表</a>
					<caption style="text-align:center">
						<h3>
							<!-- 額滿圖示 -->
							<img id="joinFullPic" src="<%= request.getContextPath()%>/img/joinFull.png" style="width:80px; height:auto; display:none">
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
									<img src="<%= request.getContextPath()%>/img/calendar.svg" style="width:20px; height:auto;">
									<fmt:formatDate value="${Sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
								</span>
								<!-- 報名費用 -->
								<span style="margin-left:20px">
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
								<div id="distance" style="font-size:1.5em; font-weight:bold; color:red"></div>
						</div>
					</div>
<canvas id="myChart" width="700" height="400" style="display: none"></canvas>
				
			</form>
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
			
			<button class="btn" id="joinbtn">
				<img src="<%= request.getContextPath()%>/img/add.png">
				加入揪團
			</button>
			
			<button class="btn" id="sharebtn">
				<img src="<%= request.getContextPath()%>/img/share.png">
				分享給好友
			</button>
			
			<button class="btn" id="repbtn">
				<img src="<%= request.getContextPath()%>/img/warning.png">
				檢舉
			</button>
		</div>
		<div class="col-xs-12 col-sm-3">
		<!--------------------------------------------- TEST ---------------------------------------------->
<%if(memberlistVO!=null){
// String mem_notest = memberlistVO.getMem_no();
// FriendService friendSvc = new FriendService();
// List<FriendVO> friendlist = friendSvc.findMyFriend(mem_notest);
// MemberlistService service2 = new MemberlistService();
// List<MemberlistVO> memberlist2 = service2.getAllMem();
// pageContext.setAttribute("friendlist",friendlist);  	
// pageContext.setAttribute("memberlist2",memberlist2);
%>
<%-- <form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do"> --%>
<!-- <input type="hidden" name="action" value="shareSg_info"> -->
<%-- <input type="hidden" name="mem_no" value="${memberlistVO.mem_no}"> --%>
<%-- <input type="hidden" name="sg_no" value="${Sg_infoVO.sg_no}"> --%>
<%-- 	<c:forEach var="friend" items="${friendlist}"> --%>
<%-- 		<c:forEach var="member" items="${memberlist2}"> --%>
<%-- 			<c:if test="${memberlistVO.mem_no eq friend.mem1_no}"> --%>
<%-- 				<c:if test="${friend.mem2_no eq member.mem_no}" > --%>
<%-- 							<input type="checkbox" name="mem2_no"  value="${member.mem_no}"> --%>
<%-- 							<img src="<%=request.getContextPath()%> --%>
<%-- 							/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}" --%>
<!-- 							style="width:40px;height:40px;border-radius:50%;"> -->
<%-- 							<label>${member.mem_name}</label><br> --%>
<%-- 				</c:if> --%>
<%-- 			</c:if> --%>
<%-- 			<c:if test="${memberlistVO.mem_no eq friend.mem2_no}"> --%>
<%-- 				<c:if test="${friend.mem1_no eq member.mem_no}" > --%>
<%-- 							<input type="checkbox" name="mem2_no"  value="${member.mem_no}"> --%>
<%-- 							<img src="<%=request.getContextPath()%> --%>
<%-- 							/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}" --%>
<!-- 							style="width:40px;height:40px;border-radius:50%"> -->
<%-- 							<label>${member.mem_name}</label><br> --%>
<%-- 				</c:if> --%>
<%-- 			</c:if> --%>
<%-- 		</c:forEach> --%>
<%-- 	</c:forEach> --%>
<!-- 	<input type="submit" value="送出分享"> -->
<!-- </form> -->
	<%} %>
<!--------------------------------------------- TEST ---------------------------------------------->
		</div>
	</div>
</div>


<jsp:include page="/front-end/CA105G1_footer.jsp" />


<script type="text/javascript">
	//若是社團專屬揪團則調整返回鍵連結
	if('${param.club_no}'.length != 0){
		$("#linkBack").attr("href","<%= request.getContextPath()%>/front-end/club/Sg_infoList.jsp");
	}
	
	
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
			//若沒有路線資料則設定本機定位(之後改成場館位置)////////////////////////////////////////////////////////////////
			var marker = new google.maps.Marker({
	   			position: loc,
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
	         travelMode: 'WALKING' //腳踏車模式無法使用
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
	
	
	
	//若過了活動時間則關閉所有按鍵
	<%
		boolean isOver = false;
		if(vo.getSg_date().getTime() < new Date().getTime()){
			isOver = true;
		}
	%>
	
	if(<%=isOver%>){
		$("#likebtn").attr('disabled', true);
		$("#dislikebtn").attr('disabled', true);
		$("#joinbtn").attr('disabled', true);
		$("#sharebtn").attr('disabled', true);
		$("#repbtn").attr('disabled', true);
	}
	
	//若報名人數已達上限則關閉報名按鍵
	<%
		boolean isFull = false;
		if(vo.getSg_ttlapl() >= vo.getSg_maxno()){
			isFull = true;
		}
	%>
	if(<%= vo.getSg_ttlapl() >= vo.getSg_maxno()%>){
		$("#joinbtn").attr('disabled', true);
		$("#joinFullPic").css('display', '');
	}
		
	
	
	
	  
	///////4按鍵若尚未登入之設定//////////
	<%if(memberlistVO == null){
		session.setAttribute("location", request.getRequestURI());%>
		$(".like").click(function(){
			<%
	 		session.setAttribute("Sg_infoVO", vo);%> //原頁面VO由session帶著去跟回
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
			return;
		});
		$("#joinbtn").click(function(){
			<%
	 		session.setAttribute("Sg_infoVO", vo);%> //原頁面VO由session帶著去跟回
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
			return;
		});
		$("#sharebtn").click(function(){
			<%
	 		session.setAttribute("Sg_infoVO", vo);%> //原頁面VO由session帶著去跟回
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
			return;
		});
		$("#repbtn").click(function(){
			<%
	 		session.setAttribute("Sg_infoVO", vo);%> //原頁面VO由session帶著去跟回
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
			return;
		});
	<%}else{%>
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
					swal({
						  title: "取消收藏!", type: "error", timer: 1000, showConfirmButton: false
					})
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
					swal({
						  title: "成功加入收藏!", type: "success", timer: 1000, showConfirmButton: false
					})
				}
			});
		});
		//////////////////加入揪團按鍵設定///////////////////////////
		$("#joinbtn").click(function(){
			<%
				boolean isJoin = false;
				Sg_memService svc = new Sg_memService();
				List<Sg_memVO> list = svc.getAllBySg_no(vo.getSg_no());
				//判斷是否重複加入
				for(Sg_memVO sg_memvo : list) {
					if(sg_memvo.getMem_no().equals(memberlistVO.getMem_no())) {
						isJoin = true;
					}
				}
			%>
			
			if(<%=isJoin%>){  //若重複報名則跳出警訊
				swal({
					  title: "您已重複報名", html: "馬上到我的揪團查看", type: "error", showCancelButton: true, showCloseButton: true,confirmButtonText: "前往",cancelButtonText: "取消"
					}).then(
						function (result) {
							if(result){
								document.location.href="<%= request.getContextPath()%>/front-end/memberlist/MemManager.do?action=Member_Sg";
							}
							},function(dismiss) {
								location.reload();
							
						});
				return;
			}else if(<%= vo.getSg_fee()%> != 0){  //若要付費則先付費再存入資料庫
				swal({
					  title: "請填寫付款資訊", showCancelButton: true, showCloseButton: true,confirmButtonText: "確定付款",cancelButtonText: "取消",
					  html:	
						  	'<form>' +
					  			'<div><img src="<%= request.getContextPath()%>/img/credit_card.svg" style="width:auto; height:200px"></div><br>'+
							  	'<div class="form-group" style="display:flex;justify-content:center;">'+
							       	'<label class="control-label col-xs-12 col-sm-5" for="card" style="padding:0px">信用卡卡號</label>'+
							       	'<div class="col-xs-12 col-sm-5" style="padding:0px">'+
							       		'<input type="text" class="form-control" id="card" value="123456789" name="card">'+
							       	'</div>'+
				   			   	'</div>'+
								'<div class="form-group" style="display:flex;justify-content:center;">'+
								    '<label class="control-label col-xs-12 col-sm-5" style="padding:0px" for="expiry">信用卡到期日</label>'+
								    '<div class="col-xs-12 col-sm-5" style="display:flex;justify-content:space-between;padding:0px">'+
									    '<input type="text" class="form-control" id="expiry1" value="21" name="expiry1" style="width:40%">'+
									    '<label style="text-align:center;">年</label>'+
									    '<input type="text" class="form-control" id="expiry2" value="05" name="expiry2" style="width:40%">'+
									    '<label>月</label>'+
								    '</div>'+
					   			'</div>'+
							    '<div>報名費用共${Sg_infoVO.sg_fee}元</div>'+
				   			'</form>',

					}).then(
						function (result) {
							if(result){
								join();
							}
						},function(dismiss) {
							location.reload();
						});
			}else{
				join();
			}
			
			
		}); //joinbtn click
		
		function join(){
			$.ajax({
				type: "POST",
				url: "<%= request.getContextPath()%>/Sg_mem/Sg_mem.do",
				data: {"action" : "insert", "sg_no" : "<%= vo.getSg_no()%>", "mem_no" : "<%= memberlistVO.getMem_no()%>"},
				dataType: "json",
				error: function(){
					alert("發生錯誤!");
				},
				success: function(data){
					swal({
						  title: "成功加入!", html: "馬上到我的揪團查看", type: "success", showCancelButton: true, showCloseButton: true,confirmButtonText: "前往",cancelButtonText: "取消"
						}).then(
							function (result) {
							if(result){
								document.location.href="<%= request.getContextPath()%>/front-end/memberlist/MemManager.do?action=Member_Sg";
							}
							},function(dismiss) {
								location.reload();
							});
				}
			}); //ajax
		} //function join
		
		
		//分享按鍵設定
		<%
			String mem_notest = memberlistVO.getMem_no();
			FriendService friendSvc = new FriendService();
			List<FriendVO> friendlist = friendSvc.findMyFriend(mem_notest);
			MemberlistService service2 = new MemberlistService();
			List<MemberlistVO> memberlist2 = service2.getAllMem();
			pageContext.setAttribute("friendlist",friendlist);  	
			pageContext.setAttribute("memberlist2",memberlist2);
		%>
		
		
		$("#sharebtn").click(function(){
			swal({
				title: '想分享給誰呢',
				showConfirmButton: false,
				html:
					'<form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do">'+
						'<input type="hidden" name="action" value="shareSg_info">'+
						'<input type="hidden" name="mem_no" value="${memberlistVO.mem_no}">'+
						'<input type="hidden" name="sg_no" value="${Sg_infoVO.sg_no}">'+
							'<c:forEach var="friend" items="${friendlist}">'+
								'<c:forEach var="member" items="${memberlist2}">'+
									'<c:if test="${memberlistVO.mem_no eq friend.mem1_no}">'+
										'<c:if test="${friend.mem2_no eq member.mem_no}" >'+
											'<input type="checkbox" name="mem2_no"  value="${member.mem_no}">'+
											'<img src="<%=request.getContextPath()%>'+
											'/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"'+
											'style="width:40px;height:40px;border-radius:50%;">'+
											'<label>${member.mem_name}</label><br>'+
										'</c:if>'+
									'</c:if>'+
									'<c:if test="${memberlistVO.mem_no eq friend.mem2_no}">'+
										'<c:if test="${friend.mem1_no eq member.mem_no}" >'+
											'<input type="checkbox" name="mem2_no"  value="${member.mem_no}">'+
											'<img src="<%=request.getContextPath()%>'+
											'/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"'+
											'style="width:40px;height:40px;border-radius:50%">'+
											'<label>${member.mem_name}</label><br>'+
										'</c:if>'+
									'</c:if>'+
								'</c:forEach>'+
							'</c:forEach>'+
						'<input type="submit" value="送出分享">'+
					'</form>'
			})
		});
		
		
		$("#repbtn").click(function(){
			swal({
				title: '正義之士就是你!',type: "warning",showCancelButton: true, showCloseButton: true,confirmButtonText: "送出",cancelButtonText: "取消",
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
		
		
		
	<%}%> //else
	
	
	
	

</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"
        async defer></script>




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
	.list-group-item{
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
	.btn{
		background-color:white
	}
	
</style>





</body>
</html>