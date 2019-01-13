<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.news.model.NewsVO"%>
<%@ page import="com.newstype.model.NewstypeVO"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>CA105G1:SportyGo!</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
		
		</style>

	</head>
	<body>
		<%-- header目前尚缺連結點 --%>
<%-- 	<%@ include file="/front-end/CA105G1_header.file" %> <!--請更正成下一行--> --%>
		<jsp:include page="/front-end/CA105G1_header.jsp" />
		<%  List<NewsVO> newsVOList = (List<NewsVO>)getServletContext().getAttribute("newsVOList"); 
		  	pageContext.setAttribute("newsVOList", newsVOList); 
		  	List<NewstypeVO> newsTypeVOList = (List<NewstypeVO>)getServletContext().getAttribute("newsTypeVOList");
		  	pageContext.setAttribute("newsTypeVOList", newsTypeVOList); %>

<%-- 		<div class="container-fluid">${newsVOList.size()}</div> --%>
		<%-- 最新消息---跑馬燈 --%>
<%-- 		<div>--------${newsTypeVOList}</div> --%>
		<div class="container-fluid">
			<div id="carousel-id" class="carousel slide" data-ride="carousel">
			    <!-- 幻燈片小圓點區 -->
			    <ol class="carousel-indicators">
			        <% for(int carousel_item = 0 ; carousel_item < newsVOList.size();carousel_item++){ %>
			        	<li data-target="#carousel-id" data-slide-to="4" class="<%=carousel_item==0? "active":"" %>"></li>
			    	<% } %>
			    </ol>
			    <!-- 幻燈片主圖區 -->
			    <div class="carousel-inner">			    
			        <% for(int carousel_item = 0 ; carousel_item < newsVOList.size();carousel_item++){   %>
				    <% 		NewsVO newsVO = newsVOList.get(carousel_item);							   %>
				    <% 		request.setAttribute("newsVO", newsVO);									   %>
				        <div class="item <%=carousel_item==0? "active":"" %>">
				            <img src="<%=request.getContextPath()%>/news/newsImg.do?news_no=<%=newsVO.getNews_no()%>" 
				            class="img-responsive img-rounded center-block" alt="" style="width:1000px; height:500px"/>
				            <div class="container">
				                <div class="carousel-caption">
				                	<h1>
				                		<c:forEach var="newstypeVO" items="${newsTypeVOList}">
				                    		${newstypeVO.newstype_no==newsVO.newstype_no?newstypeVO.newstype_name:""}
				                    	</c:forEach>
				                    </h1>
				                    <p><%=newsVO.getNews_script() %></p>
<!-- 				   <p><a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a></p> -->
				                </div>
				            </div>
				        </div>
			    	<% } %>
			    </div>
			    <!-- 上下頁控制區 -->
			    <a class="left carousel-control" href="#carousel-id" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
			    <a class="right carousel-control" href="#carousel-id" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
			</div>
		</div>
		<div style="height:50px"></div>
		<%-- 推薦揪團區 --%>
		<%-- 左側MAP --%>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-1"></div>
				<div class="col-xs-12 col-sm-10">
					<jsp:include page="/front-end/Sg_infoByMap.jsp" />			
				</div>
				<div class="col-xs-12 col-sm-1"></div>
			</div>
		</div>
		
		<%-- 右側推薦揪團列表 --%>

		<%-- 各個運動連結 --%>
		<div style="height:500px"></div>
		<div class="container-fluid">
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP001.jpg">
						<img src="img/indexImg/SP001.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="https://www.youtube.com/watch?v=oY2nVQNlUB8">
						<img src="img/indexImg/fun01.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/fun03.jpg">
						<img src="img/indexImg/fun03.jpg" class="img-responsive img-rounded"/>
					</a>					
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP004.jpg">
						<img src="img/indexImg/SP004.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP005.png">
					<img src="img/indexImg/SP005.png" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP006.jpg">
					<img src="img/indexImg/SP006.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/no-image.PNG">
					<img src="img/no-image.PNG" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/no-image.PNG">
						<img src="img/no-image.PNG" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
		</div>
		
		<%-- footer目前尚缺連結點 --%>
<%-- 		<%@ include file="front-end/CA105G1_footer.file" %> <!--請更正成下一行-->--%>
		<jsp:include page="/front-end/CA105G1_footer.jsp" />
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>