<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.sg_info.model.*" %>
<%@ page import = "com.sg_mem.model.*" %>
<%@ page import = "java.util.*" %>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%
	MemberlistService service = new MemberlistService();
	Sg_infoService sgservice = new Sg_infoService();
	session = request.getSession();
	String mem_no = (String)session.getAttribute("mem_no");
	List<Sg_infoVO> sglist = service.getSgHostByMem(mem_no);
	pageContext.setAttribute("sglist",sglist);
	List<Sg_memVO> sgmemlist = service.getSgPartByMem(mem_no);
	pageContext.setAttribute("sg_mem",sgmemlist);
	List<Sg_infoVO> sgall = sgservice.getAll();
	pageContext.setAttribute("sgall",sgall);
	session.setAttribute("loaction",request.getRequestURI());
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
				width: 90%;
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
				<!-- 揪團管理 -->
					<h1>${memberlistVO.mem_name}</h1>
					<div class="container">
						<div class="row">
							<h1>已參加的揪團</h1>
							<%pageContext.getAttribute("sg_mem");
							  pageContext.getAttribute("sgall");
							%>
							<c:forEach var="sg_memVO" items="${sg_mem}">
								<c:forEach var="sgVO" items="${sgall}">
									<c:if test="${sgVO.sg_no eq sg_memVO.sg_no}">
										<div class="col-xs-12 col-sm-2">
											<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${SgVO.sg_no}"
											style="height:100%;width:100%;border-radius:50%;">
										</div>
										<div class="col-xs-12 col-sm-6">
											<div class="list-group" id="myTab">
												<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?sg_no=${sgVO.sg_no}&action=getByPK" 
												class="list-group-item">${sgVO.sg_name}</a>
											</div>
										</div>
									</c:if>
								</c:forEach>
								<div class="col-xs-12 col-sm-2">
									<div class="list-group" id="myTab">
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" class="list-group-item">評價</a>
									</div>
								</div>
								<div class="col-xs-12 col-sm-2">
									<div class="list-group" id="myTab">
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" class="list-group-item">檢舉</a>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					
					<div class="container">
						<div class="row">
							<h1>已創建的揪團</h1>
							<%pageContext.getAttribute("sglist");%>
							<c:forEach var="sg_infoVO" items="${sglist}">
								<div class="col-xs-12 col-sm-2">
									<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}"
									style="height:100%;width:100%;border-radius:50%;">
								</div>
								<div class="col-xs-12 col-sm-6">
									<div class="list-group" id="myTab">
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" class="list-group-item">${sg_infoVO.sg_name}</a>
									</div>
								</div>
								<div class="col-xs-12 col-sm-2">
									<div class="list-group" id="myTab">
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" class="list-group-item">評價</a>
									</div>
								</div>
								<div class="col-xs-12 col-sm-2">
									<div class="list-group" id="myTab">
										<a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp" class="list-group-item">檢舉</a>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/SportyGo_Footer.html"/>
	<script>
	</script>
	</body>
</html>