<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Sg_infoGetByPk</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

</script>

<style type="text/css">
	th{
		text-align:center;
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
	.showMsg{
		resize:none;
		height:500px;
		width:100%;
	}
</style>
 
</head>
<body>
<%@ include file="/front-end/CA105G1_header.file" %>


<% 
	Sg_infoVO vo = (Sg_infoVO)session.getAttribute("Sg_infoVO_Session");
	if(vo == null){
		vo = (Sg_infoVO)request.getAttribute("Sg_infoVO");
	}
    pageContext.setAttribute("Sg_infoVO", vo);
    
    MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("MemberlistVO");
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
								
								<caption class="text-center">我是Sg_infoGetByPk</caption>
								<tbody>
									<tr>  <!-------- 照片 -------->
										<td colspan="2">
											<img id="showPic" class="img-responsive" src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}">
											<div class="uploadPic"></div><br>
										</td>
									</tr>
									<tr>
										<th>揪團編號</th>
										<td><%= vo.getSg_no() %></td>
									</tr>
									<tr>
										<th>團長</th>
										<td><%= vo.getMem_no() %></td>
									</tr>
									<tr>
										<th>團名</th>
										<td class="writable"><%= vo.getSg_name() %></td>  <!-- sg_info0 -->
									</tr>
									<tr>
										<th>活動時間</th>
										<td id="sg_date"><fmt:formatDate value="${Sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/></td>
									</tr>
									<tr>
										<th>報名開始日期</th>
										<td id="apl_start"><fmt:formatDate value="${Sg_infoVO.apl_start}" pattern="yyyy-MM-dd"/></td>
									</tr>
									<tr>
										<th>報名截止日期</th>
										<td id="apl_end"><fmt:formatDate value="${Sg_infoVO.apl_end}" pattern="yyyy-MM-dd"/></td>
									</tr>
									<tr>
										<th>報名費用</th>
										<td class="writable"><%= vo.getSg_fee() %></td> <!-- sg_info1 -->
									</tr> 
									<tr>
										<th>權限</th>
										<td id="sg_per"><%= vo.getSg_per() %></td> <!-- 下拉選單 -->
									</tr>  
									<tr>
										<th>運動種類</th>
										<td id="sp_no"><%= vo.getSp_no() %></td> <!-- 下拉選單 -->
									</tr> 
									<tr>
										<th>場地名稱</th>
										<td ><%= vo.getV_no() %></td> <!-- 下拉選單 -->
									</tr> 
									<tr>
										<th>人數上限</th>
										<td class="writable"><%= vo.getSg_maxno() %></td>  <!-- sg_info2 -->
									</tr> 
									<tr>
										<th>人數下限</th>
										<td class="writable"><%= vo.getSg_minno() %></td> <!-- sg_info3 -->
									</tr> 
									<tr>
										<th>目前報名人數</th>
										<td><%= vo.getSg_ttlapl() %></td> <!-- 之後動態增加 -->
									</tr> 
									<tr>
										<th>團長的話</th>
										<td class="writable"><%= vo.getSg_extrainfo() %></td> <!-- sg_info4 -->
									</tr>  
									<tr><th>-路線起點座標</th><td class="writable"><%= vo.getLoc_start() %></td></tr> <!-- sg_info5 -->
									<tr><th>-路線終點座標</th><td class="writable"><%= vo.getLoc_end() %></td></tr> <!-- sg_info6 -->
								</tbody>
							</table>
							<!-------------GOOGLE地圖 -------------->
								<div class="panel panel-default">
									<div class="panel-heading">
										<h4 class="panel-title text-center">
											顯示地圖
										</h4>
									</div>
									<div>
											<div id="map"></div>
											<div id="distance"></div>
									</div>
								</div>
							
							
							<input type="button" id="update" value="編輯" class="btn btn-info btn-block" align="center" style="display: ">
							<input type="submit" id="done" value="完成" class="btn btn-info btn-block" align="center" style="display: none">
							
							<input type="hidden" name="sg_no" value="<%= vo.getSg_no()%>" >
							<input type="hidden" name="mem_no" value="<%= vo.getMem_no()%>" >
							<input type="hidden" name="sg_pic_ext" value="<%= vo.getSg_pic_ext()%>" >
							<input type="hidden" name="v_no" value="<%= vo.getV_no()%>" >
							<input type="hidden" name="sg_ttlapl" value="<%= vo.getSg_ttlapl()%>" >
							<input type="hidden" name="action" value="update">
						</form>
						<form id="deleteForm">
							<input type="button" class="btn btn-danger btn-block" id="delete" value="刪除" >
							<input type="hidden" name="action" value="delete">
							<input type="hidden" name="sg_no" value="<%= vo.getSg_no()%>">
						</form>
			        </div>
			        <div role="tabpanel" class="tab-pane" id="msgBoard">
			        	<textarea id="showMsg" readonly style="resize:none;height:300px;width:100%;">123</textarea>
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
			<div class="btn" id="likebtn">
				<img src="<%= request.getContextPath()%>/img/love.png" id="like" style="display:none">
				<img src="<%= request.getContextPath()%>/img/love_white.png" id="dislike" style="display:">
				加入收藏
			</div>
			
			<div class="btn" id="joinbtn">
				<img src="<%= request.getContextPath()%>/img/add.png">
				加入揪團
			</div>
			
			<div class="btn" id="sharebtn">
				<img src="<%= request.getContextPath()%>/img/share.png">
				分享給好友
			</div>
			
			<div class="btn" id="repbtn" data-toggle="modal" data-target="#smallShoes">
				<img src="<%= request.getContextPath()%>/img/warning.png">
				檢舉
			</div>
		</div>
		<div class="col-xs-12 col-sm-3">
		</div>
	</div>
</div>
			<%@ include file="Sg_repPage.file" %>

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
	    //編輯報名開始日期
	    $("#apl_start").html(function(index, content){
		    return "<input type='text' id='apl_start2' name='apl_start' value='"+content+"'>";
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
	    <jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
    	 $("#sp_no").html(function(index, content){
 		    return "<select name='sp_no'><c:forEach var='sportVO' items='${sportSvc.all}' > <option value='${sportVO.sp_no}'>${sportVO.sp_name}</c:forEach>";
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
        
      //設定報名開始日期表
	    var apl_start = new Date();
        $('#apl_start2').datetimepicker({
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
        var startDay = new Date($('#apl_start2').val());
             var endDay = new Date($('#sg_date2').val());
             $('#apl_end2').datetimepicker({
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
	    
	  });  //update click
	  
		
	  // Double check是否刪除
	  $("#delete").click(function(){
		  if (confirm("確定刪除嗎!")) {
			$("#deleteForm").submit();
		  } else {
		    
		  }
	  });
	  
	  
	  //點擊收藏按鍵變換愛心
	  var like = false;
	  $("#likebtn").click(function(){
		  if(like){
			 $("#dislike").css("display","");
			 $("#like").css("display","none");
			 like = false;
		  }else{
			 $("#like").css("display","");
			 $("#dislike").css("display","none");
			 like = true;
		  }
	  });
	  
	  

	
	  
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
		//取得座標(JSON字串)
		var loc_start = <%= vo.getLoc_start()%>;
		var loc_end = <%= vo.getLoc_end()%>;
		if(loc_start == null || loc_end == null){
			//若沒有路線資料則設定本機定位(之後改成場館位置)////////////////////////////////////////////////////////////////
			var marker = new google.maps.Marker({
	   			position: loc,
	   			map: map,
	   			animation: google.maps.Animation.DROP,
	   			draggable: true
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
	         travelMode: 'DRIVING' //腳踏車模式無法使用?
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
	  
	//判斷4按鍵是否已登入
	<%if(memberlistVO == null){
		session.setAttribute("location", request.getRequestURI());
		session.setAttribute("Sg_infoVO_Session", vo);%>
		$("#likebtn").click(function(){
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
		});
		$("#joinbtn").click(function(){
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
		});
		$("#sharebtn").click(function(){
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
		});
		$("#repbtn").click(function(){
			document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
		});
	<%}else{%>
		$("#joinbtn").click(function(){
			swal({
			  title: "成功加入!",
			  text: "馬上到我的揪團查看",
			  icon: "success",
 			  buttons: ["退出", "前往!"],
			});
//////////////////////////debug500,404//////////////////////////////////////////////
			$.ajax({
				type: "POST",
				url: "<%= request.getContextPath()%>/Sg_mem/Sg_mem.do",
				data: {"action" : "insert", "sg_no" : "<%= vo.getSg_no()%>", "mem_no" : "<%= memberlistVO.getMem_no()%>"},
				dataType: "json",
				error: function(){
					alert("發生錯誤!");
				},
				success: function(data){
					console.log(data);
				}
			});
			
			
		});
		
		
	<%}%>
	
	
	
	

</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"
        async defer></script>



</body>
</html>