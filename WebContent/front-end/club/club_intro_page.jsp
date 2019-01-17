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
		<style type="text/css">
			
			textarea {
  			resize : none; 
			}

			.modal-footer{
			display:flex;
   			align-items:center;
    		justify-content:center; 
			}
			
			#club_name{
			font-family:Microsoft JhengHei
			}
		</style>
	</head>

	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	
	<jsp:include page="/front-end/CA105G1_header.jsp" />
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-2" id="xx1">
					<jsp:include page="/front-end/club/club_pageRight.jsp" />
				</div>
				
				<div class="col-xs-12 col-sm-8">
					<br>

<%

//   ClubService clubService = new ClubService();
// //   clubVO = clubService.getOneClub("C0001");

// String club_intro = request.getParameter("club_intro");
// clubVO = clubService.getOneClub(request.getParameter("club_no"));

   System.out.print(clubVO);
%>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/clubfront.do" name="form2">
<%-- 				<jsp:useBean id="clubSvc" scope="page" class="com.club.model.ClubService" /> --%>
	  							<div style="width:100%;height:0;position:relative;padding-bottom:66.66666667%;overflow:hidden;border-radius:10px;">
								<img src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubVO.club_no}"
								style="height:100%;position:absolute;">
								</div>
					<div class="card text-center" id="post">
						<h3 class="card-title">關於這個社團</h3>
  							<div class="card-body">
  								<p>${clubVO.club_intro}</p>
  							</div>
					</div>
</FORM>
				</div>
				<div class="col-xs-12 col-sm-2" id="xx">
<%-- 					<div>clubVO = ${clubVO }</div> --%>
				</div>
			</div>
		</div>
		



		
		
		</form>
		<jsp:include page="/front-end/CA105G1_footer.jsp" />
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
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