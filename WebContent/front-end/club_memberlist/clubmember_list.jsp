<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.memberlist.model.MemberlistService"%>
<%@page import="com.memberlist.model.MemberlistVO"%>
<%@ page import="com.club_memberlist.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<%@ page import="com.post_info.model.*"%>
<%@ page import="com.respones.model.*"%>
<%@ page import="com.club.model.*"%>
<%@ page import="java.util.*"%>
<%

// 	String club_no = (String)session.getAttribute("club_no");
	pageContext.setAttribute("club_no", "C0001");
	ClubService clubSvc = new ClubService();
	ClubVO clubVO = clubSvc.getOneClub("C0001");
	pageContext.setAttribute("clubVO", clubVO);

// 	Club_memberlistVO club_memberlistVO = (Club_memberlistVO)session.getAttribute("club_memberlistVO");

	
%>
<!DOCTYPE html>
	<head>
		<title>clubmember_list</title>
<!--     	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<!--    		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<!--     	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<!-- 		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
		
		<style type="text/css">
 			#cmem_list{  
		 		background-color: #fcfcfc;  
 				border-radius: 10px;  
/*  		    	cursor: pointer;   */
/*   		     	box-shadow: 0 2px #999;    */
 		    	width:80%;  
 		     	text-align: center; 
 		     	text-align-last: center; 
  			}  
 			
  			#photo{ 
 				width:50px; 
				height:50px; 
				border-radius: 50px; 
 				padding:3px; 
 			} 
			
		</style>
	</head>
	<body>
		<!-- 社團成員列表 -->
		<div class="container-fluid">
			<div class="card text-center">
				<h5 class="card-header ">社團成員</h5>
				<div class="card-body">
					<div class="list-group">
						<jsp:useBean id="cmemSvc" scope="page" class="com.club_memberlist.model.Club_memberlistService" />
						<c:forEach var="club_memberlistVO" items="${cmemSvc.getByClub(club_no)}" > 
							<div class="list-group-item">
<%-- 							<h5>${club_no }</h5> --%>
								<a href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp?mem_no=${club_memberlistVO.mem_no}">
									<div id="cmem_list" style="padding-left: 28px;">
										<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
										<img id="photo" src="<%= request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${club_memberlistVO.mem_no}">
<%-- 										${memberlistSvc.getOneMem(club_memberlistVO.mem_no).mem_name} --%>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</body>
	
</html>