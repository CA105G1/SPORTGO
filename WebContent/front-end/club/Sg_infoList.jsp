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
<link  rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
		
		<style type="text/css">
/* 			#listDiv{ */
/* 				display:flex; */
/* 				flex-direction: row; */
/* 				flex-wrap: wrap; */
/* 			} */
/* 			#sg_infoDiv{ */
/* 				padding:5px;  */
/* 				width:33%; */
/* 				height:auto; */
/* 			} */
/* 			#sg_picDiv{ */
/* 				height:200px; */
/* 			} */
			
		</style>
		
		
	</head>


	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	<jsp:include page="/front-end/CA105G1_header_bt4.jsp" />
<%
//  session中有memberlistVO、club_no，EL直接拿了就用
	String club_no = (String)session.getAttribute("club_no");
	ClubService svc = new ClubService();
	ClubVO clubVO = svc.getOneClub(club_no);
	request.setAttribute("clubVO",clubVO);
%>

<!-- 麵包屑 -->
<div class="breadcrumb-area">
    <!-- Top Breadcrumb Area -->
    <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/sgpic/sportbg2.jpg);">
    </div>

    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/index.jsp"><i class="fa fa-home"></i> 首頁</a></li>
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp">社團專區</a></li>
                        <li class="breadcrumb-item active" aria-current="page">專屬揪團</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>


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
							 <div class="col-12 col-lg-6" style="height:300px">
							 	<!-- 照片 -->
                                <div class="post-thumbnail mb-30" style="padding-top:10px">
                                    <a href="<%= request.getContextPath()%>/Sg_info/Sg_info.do?sg_no=${sg_infoVO.sg_no}&club_no=${club_no}&action=getByPK">
                                    	<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}" alt="" style="border-radius: 30px;">
                                   	</a>
                                </div>
                                <div class="post-content" style="position:absolute;bottom: 10px; text-align:center; width:100%">
                                	<!-- 團名 -->
                                    <a href="#" class="post-title">
                                        <h4 style="font-weight:bold">
                                        	<img src="<%= request.getContextPath()%>/img/sporticons/${sg_infoVO.sp_no}.svg" style="width:20px; height:auto;">
                                    		${sg_infoVO.sg_name }
                                    	</h4>
                                    </a>
                                    <div class="post-meta">
                                    	<!-- 團長 -->
                                        <a href="#" style="padding-right:10px">
                                        	<img src="<%= request.getContextPath()%>/img/sgmem.jpg"  style="width:20px; height:auto;"> 
	                                        <jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
	                                    	${memberlistSvc.getOneMem(sg_infoVO.mem_no).mem_name}
                                    	</a>
                                    	<!-- 揪團日期 -->
                                        <a href="#">
                                        	<img src="<%= request.getContextPath()%>/img/calendar.svg" style="width:20px; height:auto;"> 
                                        	<fmt:formatDate value="${sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
                                        </a>
                                    </div>
                                   
                                </div>
	                        </div>
							
<%-- 							<form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do"> --%>
<%-- 								<input type="hidden" name="sg_no" value="${sg_infoVO.sg_no}"> --%>
<%-- 								<input type="hidden" name="club_no" value="${club_no}"> --%>
<!-- 								<input type="hidden" name="action" value="getByPK"> -->
<%-- 								<input type="submit" id="${sg_infoVO.sg_no }" style="display:none" value="前往察看"> --%>
<!-- 							</form> -->
					</c:forEach>
				</div>
				<div class="col-xs-12 col-sm-2" id="xx">
<%-- 					<div>clubVO = ${clubVO }</div> --%>
				</div>
			</div>
		</div>
		



		
		
		<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />
		
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<!-- Popper js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
<!-- Bootstrap js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
<!-- All Plugins js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
<!-- Active js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>

		
	

	</body>
</html>