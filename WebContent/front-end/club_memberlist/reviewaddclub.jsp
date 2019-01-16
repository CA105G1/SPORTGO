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
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<title>Title Page</title>
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


	<body>
	 
	<jsp:include page="/front-end/CA105G1_header.jsp" />
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
  									<span class="badge" style="cursor: pointer; background-color:red" data-toggle="collapse" data-target="#cc1" aria-expanded="false" aria-controls="#cc1">
										+
									</span>
								</th>
  							</tr>
						</thead>	
					</table>
						<div class="collapse" id="cc1">
							<table class="table table-hover">
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
		  										<td>${memberlistSvc.getOneMem(club_memberlistVO.mem_no).mem_name}</td>
		  										<td>
			  										<form method="post" action="<%= request.getContextPath()%>/club_memberlist.do">
			  											<input type="hidden" name="club_no" value="${club_no}">
			  											<input type="hidden" name="mem_no" value="${club_memberlistVO.mem_no}">
			  											<input type="hidden" name="result" value="agree">
		  												<button class="btn btn-primary" type="submit" name="action" value="isJoinClub">加入</button>
			  										</form>
		  											<form method="post" action="<%= request.getContextPath()%>/club_memberlist.do">
		  												<input type="hidden" name="club_no" value="${club_no}">
			  											<input type="hidden" name="mem_no" value="${club_memberlistVO.mem_no}">
			  											<input type="hidden" name="result" value="disagree">
		  												<button class="btn btn-primary" type="submit" name="action" value="isJoinClub">拒絕</button>
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
  									<span class="badge" style="cursor: pointer; background-color:red" data-toggle="collapse" data-target="#cc2" aria-expanded="false" aria-controls="#cc2">
										+
									</span>
								</th>
  							</tr>
						</thead>	
					</table>
						<div class="collapse" id="cc2">
							<table class="table table-hover">
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
		  										<td>${memberlistSvc.getOneMem(club_memberlistVO.mem_no).mem_name}</td>
		  										<td>
		  											${club_memberlistVO.cmem_class}
	  												<button class="btn btn-primary setBtn" name="cmem_class" value="${club_memberlistVO.cmem_class}">設為${club_memberlistVO.cmem_class}</button>
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
		

		<jsp:include page="/front-end/CA105G1_footer.jsp" />
		
	</body>
	
	
<script>
	//設定旗標，用來回到原本的展開畫面
	var flag = localStorage.getItem('isReloadFromClass');
	if(flag == 'true'){
		$("#cc2").addClass("in");
		localStorage.setItem('isReloadFromClass', false);
	}else{
		$("#cc2").removeClass("in");
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