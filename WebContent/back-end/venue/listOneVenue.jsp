<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.venue.model.VenueVO"%>
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
<%-- 
	<br>
	<table>
		<tr>
			<th>場地編號</th>
			<th>場地名稱</th>
			<th>場地類型編號</th>
			<th>郵遞區碼</th>
			<th>緯度</th>
			<th>經度</th>
			<th>圖片</th>
			<th>地址</th>
			<th>電話</th>
			<th>場地狀態</th>
			<th>場地功能</th>
		</tr>
		<tr>
			<td>${venueVO.v_no}</td>
			<td>${venueVO.v_name}</td>
			<td>${venueVO.vt_no}</td>
			<td>${venueVO.reg_no}</td>
			<td>${venueVO.v_lat}</td>
			<td>${venueVO.v_long}</td>
			<td>${venueVO.v_pic}</td>
			<td>${venueVO.v_address}</td>
			<td>${venueVO.v_phoneno}</td>
			<td>${venueVO.v_status}</td>
			<td>${venueVO.v_func}</td>
		</tr>
	</table>
--%>
	<div class="container-fluid">
	
		<div class="row">
			<div class="col-sm-4">
				<div class="myAlign h1">場地編號 : ${venueVO.v_no}</div>
			</div>
			<div class="col-sm-4">
			<br>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="update" />
					<input type="submit" value="${venueVO.v_no}_update_btn" class="form-control btn-warning"/>
				</form>
			</div>
			<div class="col-sm-4">
			<br>
				<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
					<input type="hidden" name="action" value="delete" />
					<input type="hidden" name="v_no" value="${venueVO.v_no}" />
					<input type="submit" value="${venueVO.v_no}_delete_btn" class="form-control btn-danger"/>
				</form>
			</div>
		</div>
		
		

		<div class="row">
			<div class="col-sm-3">
				<div>
					<a href="${venueVO.v_pic}"><img src="${venueVO.v_pic}" border="0"></a>
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
						<div class="label label-info label-text">${venueVO.v_address}</div><br>
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
						<div class="label label-default label-text">STATUS</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.v_status}</div><br>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-2 inline-text" >
						<div class="label label-default label-text">FUNC</div><br>
					</div>
					<div class="col-sm-10 inline-text">
						<div class="label label-info label-text">${venueVO.v_func}</div><br>
					</div>
				</div>					
			</div>
		</div>
		
				
	</div>
		<br>
		<br>
		<br>
		<br>
		<br>
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>