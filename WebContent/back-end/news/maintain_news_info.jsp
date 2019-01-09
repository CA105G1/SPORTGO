<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.news.model.NewsVO" %>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTYGO!</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
	</head>
	<body>
 		<%-- include header --%> 
<%-- 		<%@ include file="/back-end/CA105G1_header_back.file" %> --%>
 		<%-- include show_loginBox--%> 
<%-- 		<%@ include file="/back-end/emp/loginfile/showLoginBackEnd.file" %> --%>
		<jsp:include page="/back-end/CA105G1_header_back.jsp"/>
		
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
<!-- <h1>後台共用區</h1> -->
<!-- <h2>here need include left_side_field.jsp</h2> -->
					<jsp:include page="/back-end/left_side_field.jsp"/>
					
				</div>
				<div class="col-xs-12 col-sm-9">
					<h1>最新消息管理</h1>
					
					<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
							<!-- 使用request.getAttribute("whichtab")來分辨，哪個class is active -->
					        <li role="presentation" class="${whichTab=='tab1'?'active':'' }">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">查詢、更新</a>
					        </li>
					        <li role="presentation" class="${whichTab=='tab2'?'active':'' }">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">新增</a>
					        </li>
					    </ul>
					
			<!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					    	<!-- 使用request.getAttribute("whichtab")來分辨，哪個class is active -->
					        <div role="tabpanel" class="tab-pane ${whichTab=='tab1'?'active':'' }" id="tab1">
					        	<h1>查詢、更新</h1>
					        	<div class="panel panel-info">
									<div class="panel-heading">
										<h3 class="panel-title">最新消息管理</h3>
									</div>
									<div class="panel-body">
										<div class="h1">預計放from表單---萬用</div>
										<form method="post" action="<%=request.getContextPath()%>/news/news.do">
											<div class="label label-default label-text">請輸入消息編號 : (N001)</div>
											<% 
													Object tempObjectVO = (NewsVO)request.getAttribute("NewsVO");
													NewsVO tempVO = null;
													if(tempObjectVO!=null){
														tempVO=(NewsVO)tempObjectVO;
													}
											%>
											<input type="text" name="news_no" value="<%=tempVO==null? "":tempVO.getNews_no()%>"/>
											<br>
											
											<div class="label label-default label-text">請選擇消息種類:</div>							
											<jsp:useBean id="newstypeService" scope="session" class="com.newstype.model.NewstypeService" />
											<select size="1" name="newstype_no" class="text-center">
												<option value=""></option>
												<c:forEach var="newstypeVO" items="${newstypeService.all}">
													<option value="${newstypeVO.newstype_no}" ${(param.newtype_no==newstypeVO.newstype_no)?'selected':''}>${newstypeVO.newstype_name}</option>
												</c:forEach>
											</select>
											<br>
											
											<input type="hidden" name="action" value="listNewsByCompositeQuery" /><br>
											<input type="submit" value="submit_composite_query" class="btn-primary"/>
										</form>
									</div>
									<%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs}">
										<ul>
											<c:forEach var="message" items="${errorMsgs}">
												<li style="color:red">${message}</li>
											</c:forEach>
										</ul>
									</c:if>	
						        	<%-- 查詢回應區--%>
						        	<div class="panel panel-info">
						        		<% if(null==request.getParameter("action")){ %>
<%-- 						<a id="fistTimeShow" href="<%=request.getContextPath()%>/news/news.do?action=listNewsByCompositeQuery" >123</a> --%>
			<%-- 			<jsp:include page="listQueryNews.jsp" flush="true" />	 --%>
						        		<% }else if("listNewsByCompositeQuery".equals(request.getParameter("action"))){%>
											<jsp:include page="listQueryNews.jsp" flush="true" />	
<%-- 										<% }else if("listVenueByCompositeQuery".equals(request.getParameter("action"))){%> --%>
<%-- 											<jsp:include page="listQueryVenue.jsp"/> --%>
<%-- 										<% } %> --%>
										<% } %>
						        	</div>
									
									<div>

									</div>
									
									
									
								</div>
					        </div>
					        
					 <%-- <%=request.getContextPath()%>/back-end/news/maintain_news_info.jsp#tab2 --%>       
					        <div role="tabpanel" class="tab-pane ${whichTab=='tab2'?'active':'' }" id="tab2">
					        	<jsp:include page="/back-end/news/add_one_news.jsp" />
					        </div>
					    </div>
					</div>
					
					
				</div>
			</div>
		</div>



		<%@ include file="/back-end/CA105G1_footer_back.file" %>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	</body>
</html>