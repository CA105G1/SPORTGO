<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	//session中有memberlistVO、club_no，EL直接拿了就用
	String club_no = (String)session.getAttribute("club_no");
	
	ClubService svc = new ClubService();
	ClubVO clubVO = svc.getOneClub(club_no);
	request.setAttribute("clubVO",clubVO);
%>


<html >
	<head>
	 	<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>社團簡介</title>
		
<link  rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">

<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
		
		
		<style type="text/css">
			

			.modal-footer{
			display:flex;
   			align-items:center;
    		justify-content:center; 
			}
			
		</style>
	</head>

	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	
	<jsp:include page="/front-end/CA105G1_header_bt4.jsp" />
	
	
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
                        <li class="breadcrumb-item active" aria-current="page">社團簡介</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
	
	
	
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-2" id="xx1">
					<jsp:include page="/front-end/club/club_pageRight.jsp" />
				</div>
				
				<div class="col-xs-12 col-sm-7">

<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/clubfront.do" name="form2"> --%>
<%-- 				<jsp:useBean id="clubSvc" scope="page" class="com.club.model.ClubService" /> --%>
					<div style="width:100%;height:0;position:relative;padding-bottom:66.66666667%;overflow:hidden;border-radius:10px;">
						<img src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no}"
						style="height:100%;position:absolute;">
					</div>
					<div class="card text-center" id="post" style="margin-top:10px">
						<h4 class="card-title" style="font-weight:bold; background-color:#70c745; color:#6c6c6c; ">關於這個社團</h4>
  							<div class="card-body">
  								<p>${clubVO.club_intro}</p>
  							</div>
					</div>
<!-- </FORM> -->
				</div>
				<div class="col-xs-12 col-sm-3" id="xx"><!--社團成員列表-->
					<jsp:include page="/front-end/club_memberlist/clubmember_list.jsp" />
				</div>
				</div>
			</div>
		</div>
		



		
		
<!-- 		</form> -->
	<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />
		
		
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
	
		
		
		<script>
		var status = "${no_member}";
		$(function(){
			console.log(status);
			if('no_member'===status){
				swal("不是社團成員喔！", "趕快加入吧", "warning");
			}
			
		})
		
		</script>
	</body>
</html>