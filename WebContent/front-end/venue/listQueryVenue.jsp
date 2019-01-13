<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.venue.model.VenueVO"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	List<VenueVO> list = (List<VenueVO>)request.getAttribute("myList");
	//pageContext.setAttribute("myList", list);
	//System.out.println("list : "+list);
%>
<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:listAllVenue</title>

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
	
	.myAlign{
		vertical-align:top;
	}
	.table > tbody > tr > th{
            vertical-align: middle;
            text-align:center
        }
	</style>


</head>
<body>
<jsp:useBean id="venueTypeService" scope="page" class="com.venuetype.model.VenueTypeService" />
<!-- 	<h1>This is listAllVenue.jsp</h1> -->

<!-- one card -->
<%if(list.size()!=0){ %><%----------------start to show-----------------------------------------------------------------------------------------%>
	<%@ include file="pages/page1_forVenue.file" %>
	<table class="table table-hover table-striped table-bordered table-condensed">
	<tbody>	
		<% int countItem=0;%> 
		<c:forEach var="venueVO" items="${myList}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr>
			<th>
				<div class="col-sm-1 h5" style="width:20px"><%=(++countItem)+(whichPage-1)*(rowsPerPage) %></div>
			</th>
			<td>
				<div class="col-sm-11">
				<div class="panel panel-default">
					<div class="panel-body">
						<%-- 先尋找vt_name --%>
						<c:forEach var="venueTypeVO" items="${venueTypeService.all}">
							<c:if test="${venueVO.vt_no==venueTypeVO.vt_no}">
								<c:set var="vt_name" value="${venueTypeVO.vt_name}" scope="page"/>
							</c:if>											
						</c:forEach>
						<h4>${venueVO.v_name}---${pageScope.vt_name}</h4>
						<div class="col-sm-9">
							<table class="table table-hover table-bordered table-condensed text-center">
								<tbody>
									<tr>
										<th>場地編號</th>
										<td>${venueVO.v_no}</td>
									</tr>
									<tr>
										<th>場地名稱</th>
										<td>${venueVO.v_name}</td>
									</tr>
									<tr>
										<th>場地種類</th>
										<%-- 工程師畫面寫法--%>
										<%--<td>${venueVO.vt_no}</td> --%>
										<%-- 只使用一下寫法，前面有<jsp:useBean...>--%>
										<!-- 	<td> -->
										<%-- 		<c:forEach var="venueTypeVO" items="${venueTypeService.all}"> --%>
										<%-- 			<c:if test="${venueVO.vt_no==venueTypeVO.vt_no}"> --%>
										<%-- 				${venueTypeVO.vt_name} --%>
										<%-- 			</c:if>											 --%>
										<%-- 		</c:forEach> --%>
										<!-- 	</td> -->
										<%-- 有兩次以上使用，所以前面除了有<jsp:useBean...>還有<c:set...> --%>
										<td>${pageScope.vt_name}</td>
									</tr>
									<tr>
										<th>場地地址</th>
										<td>${venueVO.reg_no}-${venueVO.v_address}</td>
									</tr>
									<tr>
										<th>場地電話</th>
										<td>${venueVO.v_phoneno}</td>
									</tr>
									<tr>
										<th>場地開放狀態</th>
										<td>${venueVO.open_state}</td>
									</tr>
									<tr>
										<th>場地開放日期</th>
										<td>
											<c:if test="${venueVO.openday_mon=='Y'}"> 一 </c:if>
											<c:if test="${venueVO.openday_tue=='Y'}"> 二 </c:if>
											<c:if test="${venueVO.openday_wed=='Y'}"> 三 </c:if>
											<c:if test="${venueVO.openday_thu=='Y'}"> 四 </c:if>
											<c:if test="${venueVO.openday_fri=='Y'}"> 五 </c:if>
											<c:if test="${venueVO.openday_sat=='Y'}"> 六 </c:if>
											<c:if test="${venueVO.openday_sun=='Y'}"> 日 </c:if>
										</td>
									</tr>
									<tr>
										<th></th>
										<td style="text-align:right">
											<a href="<%=request.getContextPath()%>/venue/venue.do?action=get_one_venue&v_no=${venueVO.v_no}"> more...... </a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-sm-3">
<!-- 							<p>URL</p> -->
<!-- 							<div> -->
<%-- 								<a href="${venueVO.v_photo1_url}"><img src="${venueVO.v_photo1_url}" class="img-responsive img-rounded"></a> --%>
<!-- 							</div> -->
							<p>DB</p>
							<div>
								<img src="<%=request.getContextPath()%>/venue/venueImg.do?v_no=${venueVO.v_no}" class="img-responsive img-rounded" alt="WTF"/>
							<div>
						</div>
					</div>
				</div>
				</div>
			</td>
<!-- 			<div style="height:5px"></div> -->
		</tr>
		</c:forEach>
	</tbody>
	</table>
	<%@ include file="pages/page2_forVenue.file" %> 
<% }else{%><%----------------end to show-----------------------------------------------------------------------------------------%>
	<table class="table table-hover table-striped table-bordered table-condensed">
		<tbody>
			<tr><th>---查無資料---</th></tr>
		</tbody>
	</table>
<% }%>


	<br>
	<br>
	<br>
	<script src="https://code.jquery.com/jquery.js"></script>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>