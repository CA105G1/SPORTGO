<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.sg_info.model.*" %>
<%@ page import = "com.sg_mem.model.*" %>
<%@ page import = "com.friend.model.*" %>
<%@ page import = "com.club_memberlist.model.*" %>
<%@ page import = "com.club.model.*" %>
<%@ page import = "com.sport.model.*" %>
<%@ page import = "java.util.*" %>
<jsp:useBean id="memberlistService" class="com.memberlist.model.MemberlistService"/>
<jsp:useBean id="clubService" class="com.club.model.ClubService"/>
<jsp:useBean id="sportService" class="com.sport.model.SportService"/>
<%
	String mem_no = (String)request.getParameter("mem_no");
	MemberlistService service = new MemberlistService();
	FriendService friendservice = new FriendService();
	MemberlistVO memberlistVO = service.getOneMem(mem_no);
	
	pageContext.setAttribute("type", 1);//public
	if(memberlistVO==null){
		memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
		pageContext.setAttribute("type", 0);//private
		if(memberlistVO==null){
			response.sendRedirect("Login.jsp");
			return;
		}
	}
	mem_no = memberlistVO.getMem_no();
	pageContext.setAttribute("member", memberlistVO);
	List<Sg_infoVO> sglist = service.getSgHostByMem(mem_no);
	pageContext.setAttribute("sglist", sglist);
	List<Sg_infoVO> sgall = service.getAllSg();
	pageContext.setAttribute("sgall", sgall);
	List<Sg_memVO> sg_mem = service.getSgPartByMem(mem_no);
	pageContext.setAttribute("sg_mem",sg_mem);
	List<FriendVO> friend = friendservice.findWhoAdd(mem_no);
	pageContext.setAttribute("friend",friend);
	List<MemberlistVO> memberlist = service.getAllMem();
	pageContext.setAttribute("memberlist",memberlist);
	Club_memberlistService clubmemservice = new Club_memberlistService();
	List<Club_memberlistVO> clubmember = clubmemservice.getByMemPart(mem_no);
	pageContext.setAttribute("clubmember",clubmember);
	List<Club_memberlistVO> clubhost = clubmemservice.getByMemHost(mem_no);
	pageContext.setAttribute("clubhost", clubhost);

	String status = (String)request.getAttribute("status");
	if(status==null)
		pageContext.setAttribute("status","");
	else
		pageContext.setAttribute("status",status);
	
%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!-- Font Awesome -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<title>SPORTGO 會員頁面</title>
		<style type="text/css">
			
			.list-group-item{
				text-align: center;
				font-size: large;
				height: 80px;
				display: flex;
				justify-content: space-around;
				align-items: center;
			}
			.center{
				display:flex;
				justify-content:center;
			}
			h1{
				text-align: center;
			}
			.grid-container{
				grid-template-columns:repeat(3,33.33%);
				grid-gap:50px;
			}
			.alert-info {
			    border-radius: 0;
				background: #0061E8;
				border: 0;
				color: white;
			}
			
			.alert-body {
				font-size: 15px;
			}
			
			.alert-title {
				font-size: 15px;
				font-weight: bold;
			}
			
			.alert-warning {
			    border-radius: 0;
			    background: orange;
				border: 0;
				color: white;
			}
		</style>
	</head>
	<body>
		<jsp:include page="/front-end/CA105G1_header.jsp"/>

		<!-- 右選單 -->
		<div class="container-fluid" style="width:90%;">
			<div class="row">
				<!-- 個人頁面 -->
				<div class="col-xs-12 col-sm-3">
						<h1>${member.mem_name}</h1>
						<div class="center">
						<img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"
						style="max-width:100%;max-height:250px;border-radius:50%;">
						</div>
						<c:if test="${type==1}">
						<form method="post" action="Friend.do" class="center">
							<input type="hidden" name="action" value="add_Friend">
							<input type="hidden" name="mem2_no" value="${member.mem_no}">
							<input type="submit" class="btn btn-info"
							 value="好友加加">
						</form>
						<div class="list-group" id="myTab">
							<a href="#sg" data-toggle="tab" class="list-group-item" style="display:flex;text-align:center;">揪團</a>
							<a href="#club" data-toggle="tab" class="list-group-item" style="display:flex;text-align:center;">社團</a>
							<a href="#information" data-toggle="tab" class="list-group-item" style="display:flex;text-align:center;">個人簡介</a>
						</div>
						</c:if>
						<c:if test="${type==0}">
							<jsp:include page="list_group.jsp"></jsp:include>
						</c:if>
				</div>	
				
				
				<div class="col-xs-12 col-sm-9" id="detail" style="padding:15px;">
					<div class="container notation" style="width:100%;display:none;">
	            	
	       			</div>
						<h2>揪團</h2>
<!-- 						參加的揪團 -->
						<div class=" tab-pane" style="display:flex;flex-flow:row wrap;">
							<c:forEach var="sg_memVO" items="${sg_mem}">
								<c:forEach var="sg_infoVO" items="${sgall}">
									<c:if test="${sg_infoVO.sg_no eq sg_memVO.sg_no}">
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForJoinMem.jsp?Sg_no=${sg_infoVO.sg_no}" 
										style="display:flex;flex-direction:column;width:calc(100% / 3 - 20px);margin:10px;">
										<div style="width:100%;height:0;position:relative;padding-bottom:70%;overflow:hidden;border-radius:10px;">
										<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}"
										style="height:100%;position:absolute;">
										</div>
										<label class="center">${sg_infoVO.sg_name}</label>
										<label class="center">團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}</label>
										<label class="center">${sg_infoVO.sg_date}</label>
										</a>
									</c:if>
								</c:forEach>
							</c:forEach>
<!-- 							創建的揪團 -->
								<c:forEach var="sg_infoVO" items="${sglist}">
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForHead.jsp?Sg_no=${sg_infoVO.sg_no}" 
										style="display:flex;flex-direction:column;width:calc(100% / 3 - 20px);margin:10px;">
										<div style="width:100%;height:0;position:relative;padding-bottom:70%;overflow:hidden;border-radius:10px;">
										<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}"
										style="height:100%;position:absolute;">
										</div>
										<label class="center">${sg_infoVO.sg_name}</label>
										<label class="center">團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}</label>
										<label class="center">${sg_infoVO.sg_date}</label>
										</a>
								</c:forEach>
							
							
							
						</div>
							
						<h2>社團</h2>
<%-- 							<%System.out.println(clublist.get(1).getClub_no()); %> --%>
						<div class=" tab-pane" style="display:flex;flex-flow:row wrap;">
							<c:forEach var="clubmember" items="${clubmember}">
							
										<a href="<%=request.getContextPath()%>/clubfront.do?actionfront=getOneClub&club_no=${clubmember.club_no}" 
										style="display:flex;flex-direction:column;width:calc(100% / 3 - 20px);margin:10px;">
										<div style="width:100%;height:auto;position:relative;padding-bottom:70%;overflow:hidden;border-radius:10px;">
										<img src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubmember.club_no}"
										style="height:100%;position:absolute;"><br>
										</div>
										<label class="center"><i class="fa fa-users"></i>${clubService.getOneClub(clubmember.club_no).club_name}</label>
												<label class="center"><i class="fa fa-arrow-circle-o-right"></i>${sportService.getByPK(clubService.getOneClub(clubmember.club_no).sp_no).sp_name}</label>
										</a>
							</c:forEach>
							<c:forEach var="clubhost" items="${clubhost}">
											<a href="<%=request.getContextPath()%>/clubfront.do?actionfront=getOneClub&club_no=${clubhost.club_no}"
											style="display:flex;flex-direction:column;width:calc(100% / 3 - 20px);margin:10px;">
											<div style="width:100%;height:auto;position:relative;padding-bottom:70%; overflow:hidden;border-radius:10px;">
												<img class="img-responsive card-img-top" src="<%=request.getContextPath()%>/clubImg.do?club_no=${clubhost.club_no}"
												style="height:100%;position:absolute;"><br>
											</div>
											<label class="center"><i class="fa fa-users"></i>${clubService.getOneClub(clubhost.club_no).club_name}</label>
											<label class="center"><i class="fa fa-arrow-circle-o-right"></i>${clubService.getOneClub(clubhost.club_no).club_name}</label>
											</a>
								</c:forEach>
						</div>
						
						
			
						
				</div>
			</div>
		</div>
	<script>
	var status = "${status}";
	var mem_no = "${mem_no}";
	console.log(mem_no);
	$(function(){
		console.log(status);
		if('succeed'===status){
			swal("加入成功！", "等待好友的回應吧", "success");
		}else if('false'===status){
			swal("加入失敗！", "可憐小蟲蟲", "error");
		}else if('duplicate'===status){
			swal("已經是好友了！", "就算很愛他也不可以這樣喔", "warning");
		}
		
	})
		var mem_no ='${mem_no}';
		var MemPoint = "/MemEchoServer/"+mem_no;
		var host = window.location.host;
		var path = window.location.pathname;
		var webCtx = path.substring(0,path.indexOf('/',1));
		var endPointURL = "ws://"+host+webCtx+MemPoint;
		var type = ${type};
		
		var webSocket;
		
		$(function(){
			if(type==0)
				connect();
		})
		function connect(){
			webSocket = new WebSocket(endPointURL);
			console.log(webSocket);
			
			webSocket.onopen = function(event){
				//alert(event.data);
				console.log("WebSocket connected successful");
			};
			
			webSocket.onmessage = function(event){
				$(".notation").show();
				var jsonObj = JSON.parse(event.data);
					if(jsonObj.type==='notation'){
						$(".notation").append("<div class='alert alert-info alert-dismissable' role='alert'>"+
						"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"+
			         	"<span aria-hidden='true' style='color: deeppink;'>好</span></button>"+
		            	"<p class='alert-title'>"+jsonObj.to+"</p><p class='alert-body'>"+
		            	jsonObj.message+"</p></div>");
					}
			};
			
			webSocket.onclose = function(event){
				webSocket.close();
				console.log("WebSocket disconnected");
			};
		}
		
		function sendMessage(){
			webSocket.send('${memberlistVO.mem_no}');
			console.log('${memberlistVO.mem_no}');
		}
	</script>
	<jsp:include page="/front-end/CA105G1_footer.jsp"/>
	</body>
</html>