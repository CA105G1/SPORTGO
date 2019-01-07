<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.venue.model.VenueVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	VenueVO venueVO = (VenueVO)request.getAttribute("venueVO");
	pageContext.setAttribute("venueVO", venueVO);
%>
<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:listOneVenue</title>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Title Page</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<!--[if lt IE 9]>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
<style>
img{
	width:100%
}
.label-text{
	font-size:1.3em;
	width:100%;
}
.inline-text div{
	display:inline-block;
}

</style>


</head>
<body>
	<h1>This is listOneVenue.jsp</h1>
	</br>
<%-- 
		<table>
		<tr>	<th>場地編號</th><td>${venueVO.v_no}</td>				</tr>
		<tr>	<th>場地名稱</th><td>${venueVO.v_name}</td>				</tr>
		<tr>	<th>官方場地網址</th><td>${venueVO.v_weburl}</td>		</tr>
		<tr>	<th>場地停車類型</th><td>${venueVO.v_parktype}</td>		</tr>
		<tr>	<th>場地介紹</th><td>${venueVO.v_introduction}</td>		</tr>
		<tr>	<th>場地類型編號</th><td>${venueVO.vt_no}</td>			</tr>
		<tr>	<th>場地室內室外</th><td>${venueVO.v_inout}</td>			</tr>
		<tr>	<th>場地郵遞區號</th><td>${venueVO.reg_no}</td>			</tr>
		<tr>	<th>場地地址</th><td>${venueVO.v_address}</td>			</tr>
		<tr>	<th>場地電話</th><td>${venueVO.v_phoneno}</td>			</tr>
		<tr>	<th>緯度</th><td>${venueVO.v_lat}</td>					</tr>
		<tr>	<th>經度</th><td>${venueVO.v_long}</td>				</tr>
		<tr>	<th>適用對象-民眾</th><td>${venueVO.v_fitall}</td>		</tr>
		<tr>	<th>適用對象-內部</th><td>${venueVO.v_fitinter}</td>		</tr>
		<tr>	<th>開放情況</th><td>${venueVO.open_state}</td>			</tr>
		<tr>	<th>開放時間</th><td>${venueVO.open_time}</td>			</tr>
		<tr>	<th>星期一是否開放</th><td>${venueVO.openday_mon}</td>	</tr>
		<tr>	<th>星期二是否開放</th><td>${venueVO.openday_tue}</td>	</tr>
		<tr>	<th>星期三是否開放</th><td>${venueVO.openday_wed}</td>	</tr>
		<tr>	<th>星期四是否開放</th><td>${venueVO.openday_thu}</td>	</tr>
		<tr>	<th>星期五是否開放</th><td>${venueVO.openday_fri}</td>	</tr>
		<tr>	<th>星期六是否開放</th><td>${venueVO.openday_sat}</td>	</tr>
		<tr>	<th>星期日是否開放</th><td>${venueVO.openday_sun}</td>	</tr>
		<tr>	<th>相片1</th><td>${venueVO.v_photo1}</td>			</tr>
		<tr>	<th>相片1副檔名</th><td>${venueVO.v_photo1_ext}</td>	</tr>
		<tr>	<th>相片1網路來源</th><td>${venueVO.v_photo1_url}</td>	</tr>
		<tr>	<th>相片2</th><td>${venueVO.v_photo2}</td>			</tr>
		<tr>	<th>相片2副檔名</th><td>${venueVO.v_photo2_ext}</td>	</tr>
		<tr>	<th>相片2網路來源</th><td>${venueVO.v_photo2_url}</td>	</tr>
	</table>
--%>


	<div class="container-fluid">
	
		<div class="row">
			<div class="col-sm-4">
				<div class="myAlign h1">場地編號 : ${venueVO.v_no}</div>
			</div>
			<div class="col-sm-4">
			<br>
				
			</div>
			<div class="col-sm-4">
			<br>
				
			</div>
		</div>
		
		

		<div class="row">
			<div class="col-sm-3">
				<div>
					<a href="${venueVO.v_photo1_url}"><img src="${venueVO.v_photo1_url}" border="0"></a>
				</div>
				<div>
					<a href="${venueVO.v_photo2_url}"><img src="${venueVO.v_photo2_url}" border="0"></a>
				</div>
				<div>
					<div class="label label-default label-text">緯度 : ${venueVO.v_lat}</div>
					<div class="label label-default label-text">經度 : ${venueVO.v_long}</div>
				</div>
			</div>
			<div class="col-sm-9">
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text ">NAME</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.v_name}---${venueVO.vt_no}</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text ">ADRESS</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.reg_no}-${venueVO.v_address}</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">PHONE</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.v_phoneno}</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">VENUE WEB</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">
							<a href="${venueVO.v_weburl}" target="_blank">${venueVO.v_weburl}</a>
						</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">場地室內室外</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.v_inout}</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">開放狀態</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.open_state}</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">開放時間</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.open_time}</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">開放日</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">
							<c:if test="${venueVO.openday_mon=='Y'}"> 一 </c:if>
							<c:if test="${venueVO.openday_tue=='Y'}"> 二 </c:if>
							<c:if test="${venueVO.openday_wed=='Y'}"> 三 </c:if>
							<c:if test="${venueVO.openday_thu=='Y'}"> 四 </c:if>
							<c:if test="${venueVO.openday_fri=='Y'}"> 五 </c:if>
							<c:if test="${venueVO.openday_sat=='Y'}"> 六 </c:if>
							<c:if test="${venueVO.openday_sun=='Y'}"> 日 </c:if>
						</div>
						<br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">適用對象</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">
							<c:if test="${venueVO.v_fitall=='Y'}"> 全體民眾 </c:if>
							<c:if test="${venueVO.v_fitinter=='Y'}"> 內部人員 	</c:if>
						</div>
						<br>
					</div>
				</div>
				<!-- 
					<th>場地停車類型</th><td>${venueVO.v_parktype}</td>
					<th>場地介紹</th><td>${venueVO.v_introduction}</td>
					<th>場地類型編號</th><td>${venueVO.vt_no}</td>
				 -->
				
			</div>
		</div>
		
				
	</div>

		<br>
		<br>
		<br>
		<br>
		<br>
	<script src="https://code.jquery.com/jquery.js"></script>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
</body>
</html>