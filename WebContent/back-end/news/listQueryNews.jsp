<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.news.model.NewsVO"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 
	List<NewsVO> list = (List<NewsVO>)request.getAttribute("myList");
	//pageContext.setAttribute("myList", list);
	//System.out.println("list : "+list);
%>
<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:listAllNews</title>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Title Page</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<!--[if lt IE 9]>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	<style>
	img{
		width:100%
	}
	.label-text{
		font-size:1.3em;
		width:100%;
	}
	
	.myAlign{
		vertical-align:top;
	}
	.table > tbody > tr > th{
            vertical-align: middle;
            text-align:center
        }
    .showSP{
    	background-color: #FFEE99;
    }
        
	</style>


</head>
<body>
<jsp:useBean id="newstypeService" scope="page" class="com.newstype.model.NewstypeService" />
<!-- 	<h1>This is listAllVenue.jsp</h1> -->

<% if(list==null || list.size()==0){%>
	<div>查無資料</div>
<% }else{ %>
	<%@ include file="pages/page1_forNews.file" %> 
	<table class="table table-hover table-striped table-bordered table-condensed">
	<tbody>
		<% int countItem=0;%> 
		<c:forEach var="newsVO" items="${myList}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr class='${newsVO.news_no==newsVO_toUpdate.news_no?"showSP":""}'>
			<th>
				<div class="col-sm-1 h5" style="width:20px"><%=(++countItem)+(whichPage-1)*(rowsPerPage) %></div>
			</th>
			
			<td>
				<div class="col-sm-11">
				<div class="panel panel-default">
					<div class="panel-body">
						<div class="col-sm-9">
							<table class="table table-hover table-bordered table-condensed text-center">
								<tbody>
									<tr>
										<th>消息編號</th>
										<td>${newsVO.news_no}</td>
									</tr>
									
<!-- 									<tr>	 -->
<!-- 										<th>消息類型編號</th> -->
<%-- 										<td>${newsVO.newstype_no}</td> --%>
<!-- 									</tr> -->
									
									<tr>
										<th>消息類型名稱</th>
										<td>${newstypeService.getOneNewsType(newsVO.getNewstype_no()).getNewstype_name()}</td>
									</tr>	
									
									<tr>
										<th>文字內容</th>
										<td>${newsVO.news_script}</td>
									</tr>
									
<!-- 									<tr> -->
<!-- 										<th>圖片附檔名</th> -->
<%-- 										<td>${newsVO.pic_extension}</td> --%>
<!-- 									</tr> -->
									
									<tr>
										<th>消息狀態</th>
										<td>${newsVO.news_stutas}</td>
									</tr>
									
									<tr>
										<th>最初發布時間</th>
										<td><fmt:formatDate value="${newsVO.news_release_date}" pattern="yyyy-MM-dd HH:mm"/></td>
									</tr>
									
									<tr>
										<th>截止時間</th>
										<td><fmt:formatDate value="${newsVO.news_last_date}" pattern="yyyy-MM-dd HH:mm"/></td>
									</tr>
									
									<tr>
										<th colspan='2'>
										  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/news/news.do" style="margin-bottom: 0px;">
										     <input type="submit" value="修改_刪除" class="btn btn-info btn-block form-control"> 
										     <input type="hidden" name="news_no"      value="${newsVO.news_no}">
										     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
										     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
										     <input type="hidden" name="action"	    value="showOneNews">
										  </FORM>
										</th>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div class="col-sm-3">
							<div>
								<img src="<%=request.getContextPath()%>/news/newsImg.do?news_no=${newsVO.news_no}" class="img-responsive img-rounded"/>
							</div>
						</div>
						
					</div>
				</div>
				</div>
			</td>
		</tr>
		</c:forEach>
	</tbody>
	</table>
	<%@ include file="pages/page2_forNews.file" %> 
<% } %>
	
	<br>
	<br>
	<br>
	<script src="https://code.jquery.com/jquery.js"></script>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>