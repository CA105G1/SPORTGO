<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.sg_info.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Sg_infoCreate</title>
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
			<form action="Sg_info.do" method="post" enctype="multipart/form-data">
				<table class="table table-hover table-striped table-bordered text-center">
					<caption class="text-center">我是Sg_infoCreate</caption><a href="SgHome.jsp">回到揪團首頁</a>
					<tbody>
						<tr><td colspan="2" style="flex-direction: column">
							<div ><img src="" id="showPic"></div>
							<input type="file" id="sg_pic" name="sg_pic"><br>
							</td></tr>
						<tr><th>團長</th><td><input type="text" name="mem_no" value="M001"></td></tr>
						<tr><th>團名</th><td><input type="text" name="sg_name" 
							value="<%= (vo==null)? "" : vo.getSg_name()%>"></td></tr>
						<tr><th>活動時間</th><td><input type="text" id="sg_date" name="sg_date" 
							value="<%= (vo==null)? "" : vo.getSg_date()%>"></td></tr>
						<tr><th>報名開始日期</th><td><input type="text" id="apl_start" name="apl_start" 
							value="<%= (vo==null)? "" : vo.getApl_start()%>"></td></tr>
						<tr><th>報名截止日期</th><td><input type="text" id="apl_end" name="apl_end" 
							value="<%= (vo==null)? "" : vo.getApl_end()%>"></td></tr>
						<tr><th>報名費用</th><td><input type="text" name="sg_fee" 
							value="<%= (vo==null)? "" : vo.getSg_fee()%>"></td></tr> <!-- sg_info1 -->
						<tr><th>權限</th><td>
							<select name="sg_per">
								<option value="公開">公開</option>
								<option value="僅限社團">僅限社團</option>
							</select>
						</td></tr>
						<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
						<tr><th>運動種類</th>
							<td>
								<select size="1" name="sp_no">
									<c:forEach var="sportVO" items="${sportSvc.all}" > 
										<option value="${sportVO.sp_no}">${sportVO.sp_name}
									</c:forEach>   
								</select>
							</td></tr> <!-- 下拉選單 -->
<!-- 						<tr><th>運動種類</th><td><input type="text" name="sp_no" value="SP001"></td></tr> 下拉選單 -->
						<tr><th>場地名稱</th><td><input type="text" name="venue_no" value="V000003"></td></tr> <!-- 下拉選單 -->
						<tr><th>人數上限</th><td><input type="text" name="sg_maxno" 
							value="<%= (vo==null)? "" : vo.getSg_maxno()%>"></td></tr> 
						<tr><th>人數下限</th><td><input type="text" name="sg_minno" 
							value="<%= (vo==null)? "" : vo.getSg_minno()%>"></td></tr> 
						<tr><th>額外資訊</th><td><input type="text" name="sg_extrainfo" 
							value="<%= (vo==null)? "" : vo.getSg_extrainfo()%>"></td></tr>  
					</tbody>
				</table>
				<input type="submit" value="送出" class="btn btn-success btn-block">
				<input type="hidden" name="action"value="insert">
				
			</form>
		</div>
		<div class="col-xs-12 col-sm-3"></div>
	</div>
</div>

<script type="text/javascript">
	
	//照片上傳
	$("#sg_pic").change(function(){
		readURL(this);
	});

	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				var img = document.getElementById("showPic");
				img.src=e.target.result;
// 				img.height=100;
// 				img.width=200;
				
			}
			reader.readAsDataURL(input.files[0]);
		}
	}





	//設定活動時間表
	var sg_date = new Date();
	$('#sg_date').datetimepicker({
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
    $('#apl_start').datetimepicker({
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
//     var startDay = new Date($('#apl_start').val());
    var startDay = new Date($('#apl_start').val());
         var endDay = new Date($('#sg_date').val());
         $('#apl_end').datetimepicker({
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
    
	
	
</script>



</body>
</html>