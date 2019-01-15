<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.venuetype.model.VenueTypeVO"%>
<%@ page import="com.venue.model.VenueVO"%>

<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:show_one_venue_back</title>

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
		.errorMsgs-color{
			color:red
		}
		table th div.mytitle{
			display: flex;
			justify-content:center;
		}
	</style>
</head>
<body>
	<h1>this is show one venue page for back</h1>
<%
	VenueVO venueVO = (VenueVO)request.getAttribute("venueVO");
	VenueTypeVO venueTypeVO = (VenueTypeVO)request.getAttribute("venueTypeVO");
%>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs_tab1}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs_tab1}">  <!-- 等同於${errorMsgs.entrySet()} -->
			<li style="color:red">${message.value}</li>  <!-- 等同於${message.getValue()} -->
		</c:forEach>
	</ul>
</c:if>
<div class="container-fluid">
	<div class="row">
			<table class="table table-hover table-striped table-bordered text-center">
				<caption class="text-center">this is show one news page</caption>
				<thead>
					<tr>
						<th colspan="2">
						
							<div class="col-xs-12 col-sm-6">
								<form method="post" action="<%=request.getContextPath()%>/news/news.do">
									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
			     					<input type="hidden" name="v_no" value="${venueVO.v_no}" />
									<input type="hidden" name="action" value="delete" />
									<input type="submit" value="刪除" class="btn btn-success btn-block" />
								</form>
							</div>
						
							<div class="col-xs-12 col-sm-6">
								<form method="post" action="<%=request.getContextPath()%>/news/news.do">
									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
			     					<input type="hidden" name="whichPage"	value="${param.whichPage}" />
			     					<input type="hidden" name="v_no" value="${venueVO.v_no}" />
			     					<input type="hidden" name="action" value="show_one_venue_back" />
									<input type="submit" value="更新" class="btn btn-success btn-block" />
								</form>
							</div>
							
<!-- 							TODO: QUESSTION: why news_no is not parameter  -->
<!-- 							<div class="col-xs-12 col-sm-4"> -->
<%-- 								<form method="post" action="<%=request.getContextPath()%>/news/news.do"> --%>
<%-- 									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller--> --%>
<%-- 			     					<input type="hidden" name="whichPage"	value="${param.whichPage}" /> --%>
<%-- 			     					<input type="hidden" name="news_no" value="${newsVO.news_no}" /> --%>
<!-- 			     					<input type="hidden" name="action" value="listNewsByCompositeQuery" /> -->
<!-- 									<input type="submit" value="查看" class="btn btn-success btn-block" /> -->
<!-- 								</form> -->
<!-- 							</div> -->
							
						</th>			
					</tr>
				</thead>
				<tbody>
					<tr>
						<th><div class="mytitle">場地編號</div></th>
						<td>${venueVO.v_no}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地類型</div></th>
						<td>${venueTypeVO.vt_name}</td>
					</tr>					
					
					<tr>
						<th><div class="mytitle">場地名稱---類型</div></th>
						<td>${venueVO.v_name}---${venueTypeVO.vt_name}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地是否顯示</div></th>
						<td>${venueVO.v_display}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地評價</div></th>
						<td>${venue_score}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">(郵遞區)-場地地址</div></th>
						<td>(${regVO.reg_no})-${venueVO.v_address}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地電話</div></th>
						<td>${venueVO.v_phoneno}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地室內室外</div></th>
						<td>${venueVO.v_inout}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">開放狀態</div></th>
						<td>${venueVO.open_state}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">開放日</div></th>
						<td>
							${venueVO.openday_mon=='Y'?' 一 ':''}
							${venueVO.openday_tue=='Y'?' 二 ':''}
							${venueVO.openday_wed=='Y'?' 三 ':''}
							${venueVO.openday_thu=='Y'?' 四 ':''}
							${venueVO.openday_fri=='Y'?' 五 ':''}
							${venueVO.openday_sat=='Y'?' 六 ':''}
							${venueVO.openday_sun=='Y'?' 日 ':''}
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">開放時間</div></th>
						<td>${venueVO.open_time}</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地適用對象</div></th>
						<td>
							${venueVO.v_fitall=='Y'?' 全體民眾 ':''}
							${venueVO.v_fitinter=='Y'?' 內部人員 ':''}
						</td>
					</tr>
					
					<tr>
						<td colspan="2">
							<div>
								<img src="<%=request.getContextPath()%>/venue/venueImg.do?v_no=${venueVO.v_no}"  
								class="img-responsive img-rounded center-block" />
							</div>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地簡介</div></th>
						<td>${venueVO.v_introduction}</td>
					</tr>
					
				</tbody>
				
			</table>
	</div>
</div>


	
	<script src="https://code.jquery.com/jquery.js"></script>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
	

	
</html>