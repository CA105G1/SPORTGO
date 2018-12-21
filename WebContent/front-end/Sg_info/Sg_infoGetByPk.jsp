<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
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

<style type="text/css">
	th{
		text-align:center;
	}
</style>

</head>
<body>

<% Sg_infoVO vo = (Sg_infoVO)request.getAttribute("Sg_infoVO");
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
			<div class="pic"><img src=""></div>
			<form action="<%= request.getContextPath()%>/Sg_info/Sg_info.do" method="post" enctype="multipart/form-data">
				<table class="table table-hover table-striped table-bordered text-center">
					<i class="glyphicon glyphicon-circle-arrow-left icon-large brown"></i><a href="<%= request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">回到揪團首頁</a>
					<caption class="text-center">我是Sg_infoGetByPk</caption>
					<tbody>
						<tr><td colspan="2">
							<img id="showPic" class="img-responsive" src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}">
							<div class="uploadPic"></div><br></td></tr>
						<tr><th>揪團編號</th><td><%= vo.getSg_no() %></td></tr>
						<tr><th>團長</th><td><%= vo.getMem_no() %></td></tr>
						<tr><th>團名</th><td class="writable"><%= vo.getSg_name() %></td></tr>  <!-- sg_info0 -->
						<tr><th>活動時間</th><td id="sg_date"><fmt:formatDate value="${Sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/></td></tr>
						<tr><th>報名開始日期</th><td id="apl_start"><fmt:formatDate value="${Sg_infoVO.apl_start}" pattern="yyyy-MM-dd"/></td></tr>
						<tr><th>報名截止日期</th><td id="apl_end"><fmt:formatDate value="${Sg_infoVO.apl_end}" pattern="yyyy-MM-dd"/></td></tr>
						<tr><th>報名費用</th><td class="writable"><%= vo.getSg_fee() %></td></tr> <!-- sg_info1 -->
						<tr><th>權限</th><td id="sg_per"><%= vo.getSg_per() %></td></tr>  <!-- 下拉選單 -->
						<tr><th>運動種類</th><td id="sp_no"><%= vo.getSp_no() %></td></tr> <!-- 下拉選單 -->
						<tr><th>場地名稱</th><td ><%= vo.getVenue_no() %></td></tr> <!-- 下拉選單 -->
						<tr><th>人數上限</th><td class="writable"><%= vo.getSg_maxno() %></td></tr> <!-- sg_info2 -->
						<tr><th>人數下限</th><td class="writable"><%= vo.getSg_minno() %></td></tr> <!-- sg_info3 -->
						<tr><th>-報名總人數</th><td><%= vo.getSg_ttlapl() %></td></tr> <!-- 之後動態增加 -->
						<tr><th>-額外資訊</th><td class="writable"><%= vo.getSg_extrainfo() %></td></tr>  <!-- sg_info4 -->
						<tr><th>-路線起點經度</th><td class="writable"><%= vo.getLoc_start_lat() %></td></tr> <!-- sg_info5 -->
						<tr><th>-路線起點緯度</th><td class="writable"><%= vo.getLoc_start_lng() %></td></tr> <!-- sg_info6 -->
						<tr><th>-路線終點經度</th><td class="writable"><%= vo.getLoc_end_lat() %></td></tr> <!-- sg_info7 -->
						<tr><th>-路線終點緯度</th><td class="writable"><%= vo.getLoc_end_lng() %></td></tr> <!-- sg_info8 -->
					</tbody>
				</table>
					<input type="button" id="update" value="編輯" class="btn btn-info btn-block" align="center" style="display: ">
					<input type="submit" id="done" value="完成" class="btn btn-info btn-block" align="center" style="display: none">
				
				
				<input type="hidden" name="sg_no" value="<%= vo.getSg_no()%>" >
				<input type="hidden" name="mem_no" value="<%= vo.getMem_no()%>" >
				<input type="hidden" name="sg_pic_ext" value="<%= vo.getSg_pic_ext()%>" >
				<input type="hidden" name="venue_no" value="<%= vo.getVenue_no()%>" >
				<input type="hidden" name="sg_ttlapl" value="<%= vo.getSg_ttlapl()%>" >
				<input type="hidden" name="action" value="update">
			</form>
			<form id="deleteForm">
				<input type="button" class="btn btn-danger btn-block" id="delete" value="刪除" >
				<input type="hidden" name="action" value="delete">
				<input type="hidden" name="sg_no" value="<%= vo.getSg_no()%>">
			</form>
		</div>
		<div class="col-xs-12 col-sm-3"></div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function(){
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
	    
	    
	    $("#update").attr("style","display:none");
	    $("#done").attr("style","");
	    
	    
	    
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
	
	  
	  
	  
	  
	});  //document.ready
	
	
	
	

</script>




</body>
</html>