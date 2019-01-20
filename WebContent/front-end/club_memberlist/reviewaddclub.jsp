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
		<title>Title Page</title>
		
<link  rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">

<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
		
	</head>


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
                        <li class="breadcrumb-item active" aria-current="page">社團管理</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>


		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-2">
					<jsp:include page="/front-end/club/club_pageRight.jsp" />	
				</div>
				<div class="col-xs-12 col-sm-8">
					<table class="table table-hover">
						<thead>
  							<tr>
  								<th>
  									社團加入申請
  									<span class="badge" style="cursor: pointer;color:white; background-color:red"  data-toggle="collapse" data-target="#cc1" aria-expanded="false" aria-controls="#cc1">
										+
									</span>
								</th>
  							</tr>
						</thead>	
					</table>
						<div class="collapse" id="cc1">
							<table class="table table-hover text-center">
								<thead>
									<tr>
										<th>會員</th>
										<th>審核</th>
									</tr>
								</thead>
		  						<tbody>
		  							<jsp:useBean id="club_memberlistSvc" scope="page" class="com.club_memberlist.model.Club_memberlistService"/>
									<c:forEach var="club_memberlistVO" items="${club_memberlistSvc.getByClub(club_no)}">
		  								<c:if test="${club_memberlistVO.cmem_status=='待審核'}">
		  									<tr>
		  										<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
		  										<td>
		  											<img id="sg_memPic" src="<%= request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${club_memberlistVO.mem_no}" style="width:50px;height:50px;border-radius: 50px;padding:3px;">
		  											${memberlistSvc.getOneMem(club_memberlistVO.mem_no).mem_name}
	  											</td>
		  										<td style="display:flex; flex-direction: row; justify-content:center; ">
			  										<form method="post" action="<%= request.getContextPath()%>/club_memberlist.do" style="padding-right:10px">
			  											<input type="hidden" name="club_no" value="${club_no}">
			  											<input type="hidden" name="mem_no" value="${club_memberlistVO.mem_no}">
			  											<input type="hidden" name="result" value="agree">
		  												<button class="btn btn-info joinBtn" type="submit" name="action" value="isJoinClub">加入</button>
			  										</form>
		  											<form method="post" action="<%= request.getContextPath()%>/club_memberlist.do">
		  												<input type="hidden" name="club_no" value="${club_no}">
			  											<input type="hidden" name="mem_no" value="${club_memberlistVO.mem_no}">
			  											<input type="hidden" name="result" value="disagree">
		  												<button class="btn btn-danger joinBtn" type="submit" name="action" value="isJoinClub">拒絕</button>
	  												</form>
	  											</td>
		  									</tr>
		  								</c:if>
		  							</c:forEach>
		  						</tbody>
							</table>
						</div>
						
						
						<table class="table table-hover">
						<thead>
  							<tr>
  								<th>
  									社團成員權限設定
  									<span class="badge" style="cursor: pointer;color:white; background-color:red" data-toggle="collapse" data-target="#cc2" aria-expanded="false" aria-controls="#cc2">
										+
									</span>
								</th>
  							</tr>
						</thead>	
					</table>
						<div class="collapse" id="cc2">
							<table class="table table-hover text-center">
								<thead>
									<tr>
										<th>會員</th>
										<th>權限</th>
									</tr>
								</thead>
		  						<tbody>
		  							<jsp:useBean id="club_memberlistSvc2" scope="page" class="com.club_memberlist.model.Club_memberlistService"/>
									<c:forEach var="club_memberlistVO" items="${club_memberlistSvc2.getByClub(club_no)}">
		  								<c:if test="${club_memberlistVO.cmem_status=='正式社員'}">
		  									<tr>
		  										<td>
			  										<img id="sg_memPic" src="<%= request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${club_memberlistVO.mem_no}" style="width:50px;height:50px;border-radius: 50px;padding:3px;">
			  										${memberlistSvc.getOneMem(club_memberlistVO.mem_no).mem_name}
		  										</td>
		  										<td>
		  											${club_memberlistVO.cmem_class}
	  												<button class="btn btn-primary setBtn" name="cmem_class" value="${club_memberlistVO.cmem_class}">
	  													<c:if test="${club_memberlistVO.cmem_class=='管理員'}">設為一般成員</c:if>
	  													<c:if test="${club_memberlistVO.cmem_class=='一般成員'}">設為管理員</c:if>
	  												</button>
		  											<input type="hidden" name="mem_no" value="${club_memberlistVO.mem_no}">
	  											</td>
		  									</tr>
		  								</c:if>
		  							</c:forEach>
		  						</tbody>
							</table>
						</div>

						


				</div> <!-- col-sm-8 -->
					
				<div class="col-xs-12 col-sm-2" id="xx">
					

				</div>
			</div>
		</div>
		

	
<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />
		
	</body>
	
	
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


	//設定旗標，用來回到加入申請的展開畫面
	var flag = localStorage.getItem('isReloadFromJoin');
	if(flag == 'true'){
		$("#cc1").addClass("show");
		localStorage.setItem('isReloadFromJoin', false);
	}else{
		$("#cc1").removeClass("show");
	}
	
	$(".joinBtn").click(function(){
		localStorage.setItem('isReloadFromJoin', true);
	});



	//設定旗標，用來回到權限設定的展開畫面
	var flag = localStorage.getItem('isReloadFromClass');
	if(flag == 'true'){
		$("#cc2").addClass("show");
		localStorage.setItem('isReloadFromClass', false);
	}else{
		$("#cc2").removeClass("show");
	}
	
	//點擊按鍵替換成員權限
	$(".setBtn").click(function(){
		if($(this).val() == "管理員"){
			$(this).val("一般成員");
			$(this).text("設為一般成員");
		}else if($(this).val() == "一般成員"){
			$(this).val("管理員");
			$(this).text("設為管理員");
		}
		
		var dataStr = {};
		dataStr.action = "setCmem_class";
		dataStr.club_no = "${club_no}";
		dataStr.mem_no = $(this).next().val();
		dataStr.cmem_class= $(this).val();
		$.ajax({
			type: "POST",
			url: "<%= request.getContextPath()%>/club_memberlist.do",
			data: dataStr,
			dataType: "json",
			error: function(){
				alert("發生錯誤!");
			},
			success: function(data){
				localStorage.setItem('isReloadFromClass', true);
				location.reload();
			}
		});
		
	});

</script>	
	
	
	
	
</html>