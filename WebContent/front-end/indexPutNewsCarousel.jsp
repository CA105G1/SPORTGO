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
		
		
	   <!-- Favicon -->
	   <link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
	
	   <!-- Core Stylesheet -->
	   <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
		
		
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
		  	
		  	
		  	
		  	
		  	
		  	<!-- 輪播 -->
		    <section class="hero-area">
		        <div class="hero-post-slides owl-carousel">
		
		            <!-- Single Hero Post -->
		            <div class="single-hero-post bg-overlay">
		                <!-- Post Image -->
		                <div class="slide-img bg-img" style="background-image: url(<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/PN001.jpeg);"></div>
		                <div class="container h-100">
		                    <div class="row h-100 align-items-center">
		                        <div class="col-12">
		                            <!-- Post Content -->
		                            <div class="hero-slides-content text-center">
		                                <h2>如果運動可以讓你更美更健康，你還會拒絕嗎？</p>
		<!--                                 <div class="welcome-btn-group"> -->
		<%--                                     <a href="<%=request.getContextPath()%>/index.jsp" class="btn alazea-btn mr-30">馬上體驗</a> --%>
		<!--                                 </div> -->
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		            <!-- Single Hero Post -->
		            <div class="single-hero-post bg-overlay">
		                <!-- Post Image -->
		                <div class="slide-img bg-img" style="background-image: url(<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/PN002.jpeg);"></div>
		                <div class="container h-100">
		                    <div class="row h-100 align-items-center">
		                        <div class="col-12">
		                            <!-- Post Content -->
		                            <div class="hero-slides-content text-center">
		                                <h2>現在就加入運動的行列吧!</p>
		<!--                                 <div class="welcome-btn-group"> -->
		<%--                                     <a href="<%=request.getContextPath()%>/index.jsp" class="btn alazea-btn mr-30">立即開始體驗!</a> --%>
		<!--                                 </div> -->
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		            
					<% for(int carousel_item = 0 ; carousel_item < newsVOList.size();carousel_item++){   %>
				    <% 		NewsVO newsVO = newsVOList.get(carousel_item);							     %>
				    <% 		request.setAttribute("newsVO", newsVO);									     %>
			            <!-- Single Hero Post --> 
			            <div class="single-hero-post bg-overlay">
			                <!-- Post Image -->
			                <div class="slide-img bg-img" style="background-image: url(<%=request.getContextPath()%>/news/newsImg.do?news_no=<%=newsVO.getNews_no()%>);"></div>
			                <div class="container h-100">
			                    <div class="row h-100 align-items-center">
			                        <div class="col-12">
			                            <!-- Post Content -->
			                            <div class="hero-slides-content text-center">
			                                <h2>
				                				<c:forEach var="newstypeVO" items="${newsTypeVOList}">
				                    				${newstypeVO.newstype_no==newsVO.newstype_no?newstypeVO.newstype_name:""}
						                    	</c:forEach>
						                    </h2>
<%-- 				                    		<p><%=newsVO.getNews_script() %></p> --%>
			<!--                                 <div class="welcome-btn-group"> -->
			<%--                                     <a href="<%=request.getContextPath()%>/index.jsp" class="btn alazea-btn mr-30">立即開始體驗!</a> --%>
			<!--                                 </div> -->
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
					<% } %>
		        </div>
		    </section>
	</body>
</html>