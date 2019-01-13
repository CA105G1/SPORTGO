<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.club_memberlist.model.*" %>
<%@ page import = "com.club.model.*" %>
<%@ page import = "com.sport.model.*" %>
<%@ page import = "java.util.*" %>

<% 
	MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
	if(memberlistVO==null){
		response.sendRedirect("Login.jsp");
	}
	String mem_no = memberlistVO.getMem_no();
 	Club_memberlistService service = new Club_memberlistService();
	List<Club_memberlistVO> clubmember = service.getByMemPart(mem_no);
	pageContext.setAttribute("clubmember",clubmember);
	List<Club_memberlistVO> clubhost = service.getByMemHost(mem_no);
	pageContext.setAttribute("clubhost",clubhost);
	List<Club_memberlistVO> clubwait = service.getByMemPartWait(mem_no);
	pageContext.setAttribute("clubwait",clubwait);
	ClubService clubservice = new ClubService();
	List<ClubVO> clublist = clubservice.getAll();
	pageContext.setAttribute("clublist",clublist);
	SportService sportservice = new SportService();
	List<SportVO> sportlist = sportservice.getAll();
	pageContext.setAttribute("sportlist", sportlist);
%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		
		<!-- Font Awesome -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<title>SPORTGO 會員頁面</title>
		<style type="text/css">
			.container{
				width: 100%;
			}
			center{
				font-size: xx-large;
				color: red;
			}
			.grid-container{
				grid-template-columns:1fr 2fr 1fr;
				grid-gap:20px;
				text-algin:center;
			}
			.list-group-item{
				align-items:center;
			}
		</style>
	</head>
	<body>
		<jsp:include page="/front-end/CA105G1_header.jsp"/>
		
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="list_group.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9 tab-content">
<!-- 				參加的社團 -->
					<div class="container">
						<div class="row">
							<h3>社團</h3>
							<div class=" grid-container" style="display:grid;">
								<c:forEach var="clubmember" items="${clubmember}">
									<c:forEach var="clublist" items="${clublist}">
										<c:if test="${clubmember.club_no eq clublist.club_no}">
											<div style="width:100%;height:0;position:relative;padding-bottom:80%;
											overflow:hidden;border-radius:10px;">
												<img class="img-responsive card-img-top" src="<%=request.getContextPath()%>/clubImg.do?club_no=${clublist.club_no}"
												style="height:100%;position:absolute;">
											</div>
											<a href="<%=request.getContextPath()%>/clubfront.do?actionfront=getOneClub&club_no=${clublist.club_no}"
											class="list-group-item" style="text-align:center;display:flex;height:100%;border:0;">
											<label class="center"><i class="fa fa-users"></i>${clublist.club_name}</label><br>
											<c:forEach var="sportlist" items="${sportlist}">
												<c:if test="${clublist.sp_no eq sportlist.sp_no}">
													<label class="center"><i class="fa fa-arrow-circle-o-right"></i>${sportlist.sp_name}</label><br>
													
												</c:if>
											</c:forEach>
											</a>
											<div></div>
										</c:if>	
									</c:forEach>
								</c:forEach>
							</div>
						</div>
					</div>
				
<!-- 				當管理員的社團 -->

					<div class="container">
						<div class="row">
							<h3>我管理的社團</h3>
							<div class=" grid-container" style="display:grid;">
								<c:forEach var="clubhost" items="${clubhost}">
									<c:forEach var="clublist" items="${clublist}">
										<c:if test="${clubhost.club_no eq clublist.club_no}">
											<div style="width:100%;height:0;position:relative;padding-bottom:80%;
											overflow:hidden;border-radius:10px;">
												<img class="img-responsive card-img-top" src="<%=request.getContextPath()%>/clubImg.do?club_no=${clublist.club_no}"
												style="height:100%;position:absolute;">
											</div>
											<a href="<%=request.getContextPath()%>/clubfront.do?actionfront=getOneClub&club_no=${clublist.club_no}"
											class="list-group-item" style="text-align:center;display:flex;height:100%;border:0;">
											<label class="center"><i class="fa fa-users"></i>${clublist.club_name}</label><br>
											<c:forEach var="sportlist" items="${sportlist}">
												<c:if test="${clublist.sp_no eq sportlist.sp_no}">
													<label class="center"><i class="fa fa-arrow-circle-o-right"></i>${sportlist.sp_name}</label><br>
												</c:if>
											</c:forEach>
											</a>
											<div></div>
										</c:if>	
									</c:forEach>
								</c:forEach>
							</div>
						</div>
					</div>
<!-- 					待審核 -->
					<div class="container">
						<div class="row">
							<h3>等待審核的社團</h3>
							<div class=" grid-container" style="display:grid;">
								<c:forEach var="clubwait" items="${clubwait}">
									<c:forEach var="clublist" items="${clublist}">
										<c:if test="${clubwait.club_no eq clublist.club_no}">
											<div style="width:100%;height:0;position:relative;padding-bottom:80%;
											overflow:hidden;border-radius:10px;">
												<img class="img-responsive card-img-top" src="<%=request.getContextPath()%>/clubImg.do?club_no=${clublist.club_no}"
												style="height:100%;position:absolute;">
											</div>
											<a href="<%=request.getContextPath()%>/clubfront.do?actionfront=getOneClub&club_no=${clublist.club_no}"
											class="list-group-item" style="text-align:center;display:flex;height:100%;border:0;">
											<label class="center"><i class="fa fa-users"></i>${clublist.club_name}</label><br>
											<c:forEach var="sportlist" items="${sportlist}">
												<c:if test="${clublist.sp_no eq sportlist.sp_no}">
													<label class="center"><i class="fa fa-arrow-circle-o-right"></i>${sportlist.sp_name}</label><br>
												</c:if>
											</c:forEach>
											</a>
											<div></div>
										</c:if>	
									</c:forEach>
								</c:forEach>
							</div>
						</div>
					</div>
					
					
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/CA105G1_footer.jsp"/>
	<script>
// 	var action = "${action}";
	
// 	$(function(){
// 	    $(document).on('shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
// 	        localStorage.setItem('activeTab', $(e.target).attr('href'));
// 	    })

// 	    var hash = window.location.hash;
// 	    var activeTab = localStorage.getItem('activeTab');

// 	    if(hash){
// 	          $('#project-tabs  a[href="' + hash + '"]').tab('show');   
// 	    }else if (activeTab){
// 	        $('#project-tabs a[href="' + activeTab + '"]').tab('show');
// 	    }
	    
// 	    changePage();
// 	});
	
// 	function changePage(){
// 		console.log(action);
// 		if(action === 'Member_renew'){
// 			$('#myTab').find('a[href="#renew"]').trigger('click');
// 		} else if(action === ''){
			
// 		} else {
// 			$('#myTab').find('a[href="#mem"]').trigger('click');
// 		}
// 	}
	</script>
	</body>
</html>