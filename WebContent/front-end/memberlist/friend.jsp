<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.friend.model.*" %>
<%@ page import = "java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberlistService service = new MemberlistService();
	List<FriendVO> friendlist =(List<FriendVO>)request.getAttribute("friendlist");
	List<MemberlistVO> memberlist = service.getAllMem();
	if(friendlist==null)
		response.sendRedirect("Login.jsp");
	pageContext.setAttribute("friendlist",friendlist);
	pageContext.setAttribute("memberlist",memberlist);
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
		<title>SPORTGO 會員頁面</title>
		<style type="text/css">
			.container{
				width: 100%;
			}
			center{
				font-size: xx-large;
				color: red;
			}
		</style>
	</head>
	<body>
		<jsp:include page="/front-end/SportyGo_Header.html"/>
		
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="list_group.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9 tab-content">
				<!-- 好友管理 -->
					<c:forEach var="friend" items="${friendlist}">
						<c:forEach var="member" items="${memberlist}">
							<c:if test="${memberlistVO.mem_no eq friend.mem1_no}">
								<c:if test="${friend.mem2_no eq member.mem_no}" >
									<a href="public_Member_page.jsp?mem_no=${member.mem_no}">
									<img src="<%=request.getContextPath()%>
									/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"
									style="width:80px;height:80px;border-radius:50%;">
									${member.mem_name}
									</a>
								</c:if>
							</c:if>
							<c:if test="${memberlistVO.mem_no eq friend.mem2_no}">
								<c:if test="${friend.mem1_no eq member.mem_no}" >
									<a href="public_Member_page.jsp?mem_no=${member.mem_no}">
									<img src="<%=request.getContextPath()%>
									/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"
									style="width:80px;height:80px;border-radius:50%">
									${member.mem_name}
									</a>
								</c:if>
							</c:if>
						</c:forEach>
						<br>
					</c:forEach>
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/SportyGo_Footer.html"/>
	<script>
	
	</script>
	</body>
</html>