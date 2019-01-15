<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.club.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<html >
	<head>
	 	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		
		<style type="text/css">
			#listDiv{
				display:flex;
				flex-direction: row;
				flex-wrap: wrap;
			}
			#sg_infoDiv{
				padding:5px; 
				width:33%;
				height:auto;
			}
			#sg_picDiv{
				height:200px;
			}
			
		</style>
		
		
	</head>


	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	<jsp:include page="/front-end/CA105G1_header.jsp" />
<%
//  session中有memberlistVO、club_no，EL直接拿了就用
	String club_no = (String)session.getAttribute("club_no");
	ClubService svc = new ClubService();
	ClubVO clubVO = svc.getOneClub(club_no);
	request.setAttribute("clubVO",clubVO);
%>
		<div class="container">
			<div class="row">
				
				<div class="col-xs-12 col-sm-2" >
					<jsp:include page="/front-end/club/club_pageRight.jsp" />
				</div>
				<div class="col-xs-12 col-sm-8" id="listDiv">
					<a class="btn btn-info btn-block" href="<%= request.getContextPath()%>/front-end/club/Sg_infoCreateForClub.jsp">
						建立專屬揪團
					</a>
					<jsp:useBean id="sg_infoSvc" scope="page" class="com.sg_info.model.Sg_infoService"/>
					<c:forEach var="sg_infoVO" items="${sg_infoSvc.getAllForClub(club_no)}">
						<div id="sg_infoDiv">
							<div class="w3-container w3-red">
								<h5>
									<!-- 團名 -->
									<img src="<%= request.getContextPath()%>/img/sporticons/${sg_infoVO.sp_no}.svg" style="width:20px; height:auto;">
									${sg_infoVO.sg_name }
								</h5>
							</div>
							<div id="sg_picDiv">
								<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}" class="img-responsive img-rounded"">
							</div>
							<div class="w3-container">
								<!-- 團長 -->
								<div >
									<i class="glyphicon glyphicon-user" style="padding-right:5px"></i>
									<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
									${memberlistSvc.getOneMem(sg_infoVO.mem_no).mem_name}
								</div>
								<!-- 活動時間 -->
								<div>
									<img src="<%= request.getContextPath()%>/img/calendar.svg" style="width:20px; height:auto;">
									<fmt:formatDate value="${sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
								</div>
							</div>
							
							<form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do">
								<input type="hidden" name="sg_no" value="${sg_infoVO.sg_no}">
								<input type="hidden" name="club_no" value="${club_no}">
								<input type="hidden" name="action" value="getByPK">
								<input type="submit" class="w3-container w3-red btn btn-block" value="前往察看">
							</form>
						</div>
					</c:forEach>
				</div>
				<div class="col-xs-12 col-sm-2" id="xx">
					<div>clubVO = ${clubVO }</div>
				</div>
			</div>
		</div>
		



		
		
		<jsp:include page="/front-end/CA105G1_footer.jsp" />
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
	

	</body>
</html>