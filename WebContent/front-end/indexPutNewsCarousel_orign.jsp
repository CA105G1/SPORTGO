<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
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
<!-- 		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
		
		</style>

	</head>
	<body>

		<%  String newsVOListName = null;
// 			System.out.println("request.getRequestURI() :　"+request.getRequestURI());
			if("/CA105G1/index.jsp".equals(request.getRequestURI())){
				newsVOListName = "newsVOList";
			}else{
				newsVOListName = "newsVOProductList";
			}
			
			List<NewsVO> newsVOList = (List<NewsVO>)getServletContext().getAttribute(newsVOListName); 
		  	pageContext.setAttribute("newsVOList", newsVOList); 
		  	List<NewstypeVO> newsTypeVOList = (List<NewstypeVO>)getServletContext().getAttribute("newsTypeVOList");
		  	pageContext.setAttribute("newsTypeVOList", newsTypeVOList); %>
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




		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>