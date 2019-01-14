<%@page import="com.newstype.model.NewstypeVO"%>
<%@page import="com.news.model.NewsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:add_one_news</title>

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
		.errorMsgs-color{
			color:red
		}
		table th div.mytile{
			display: flex;
			justify-content:center;
		}
	</style>
</head>
<body>
	<h1>this is show one news page</h1>
<%
	NewsVO newsVO = (NewsVO)request.getAttribute("newsVO");
	NewstypeVO newstypeVO = (NewstypeVO)request.getAttribute("newstypeVO");
%>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">  <!-- 等同於${errorMsgs.entrySet()} -->
			<li style="color:red">${message.value}</li>  <!-- 等同於${message.getValue()} -->
		</c:forEach>
	</ul>
</c:if>
<div class="container-fluid">
	<div class="row">
			<table class="table table-hover table-striped table-bordered text-center">
				<caption class="text-center">this is show one news page</caption>
				<thead>
					<tr>
						<th colspan="2">
						
							<div class="col-xs-12 col-sm-6">
								<form method="post" action="<%=request.getContextPath()%>/news/news.do">
									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
			     					<input type="hidden" name="news_no"value="${newsVO.news_no}" />
									<input type="hidden" name="action"value="delete_this_news" />
									<input type="submit" value="刪除" class="btn btn-success btn-block" />
								</form>
							</div>
						
							<div class="col-xs-12 col-sm-6">
								<form method="post" action="<%=request.getContextPath()%>/news/news.do">
									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
			     					<input type="hidden" name="whichPage"	value="${param.whichPage}" />
			     					<input type="hidden" name="news_no"value="${newsVO.news_no}" />
			     					<input type="hidden" name="action"value="getOne_For_Update" />
									<input type="submit" value="更新" class="btn btn-success btn-block" />
								</form>
							</div>
							
<!-- 							TODO: QUESSTION: why news_no is not parameter  -->
<!-- 							<div class="col-xs-12 col-sm-4"> -->
<%-- 								<form method="post" action="<%=request.getContextPath()%>/news/news.do"> --%>
<%-- 									<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller--> --%>
<%-- 			     					<input type="hidden" name="whichPage"	value="${param.whichPage}" /> --%>
<%-- 			     					<input type="hidden" name="news_no" value="${newsVO.news_no}" /> --%>
<!-- 			     					<input type="hidden" name="action" value="listNewsByCompositeQuery" /> -->
<!-- 									<input type="submit" value="查看" class="btn btn-success btn-block" /> -->
<!-- 								</form> -->
<!-- 							</div> -->
							
						</th>			
					</tr>
				</thead>
				<tbody>
					<tr>
						<th><div class="mytile">消息編號</div></th>
						<td>${newsVO.news_no}</td>
					</tr>
					<tr>
						<th><div class="mytile">消息種類</div></th>
						<td>${newstypeVO.newstype_name}</td>
					</tr>
					<tr>
						<th><div class="mytile">消息內容</div></th>
						<td>${newsVO.news_script}</td>
					</tr>
					<tr>
						<th><div class="mytile">消息狀態</div></th>
						<td>${newsVO.news_stutas}</td>
					</tr>
					<tr>
						<th><div class="mytile">發布開始時間</div></th>
						<td>
							<fmt:formatDate value="${newsVO.news_release_date}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
					</tr>
					<tr>
						<th><div class="mytile">發布截止時間</div></th>
						<td>
							<fmt:formatDate value="${newsVO.news_last_date}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div>
								<img src="<%=request.getContextPath()%>/news/newsImg.do?news_no=${newsVO.news_no}"  
								class="img-responsive img-rounded center-block" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
	</div>
</div>


	
	<script src="https://code.jquery.com/jquery.js"></script>
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
	
		<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
	
	<style>
	  .xdsoft_datetimepicker .xdsoft_datepicker {
	           width:  300px;   /* width:  300px; */
	  }
	  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	           height: 151px;   /* height:  151px; */
	  }
	</style>
	<script type="text/javascript">
	
	
		//設定時間
		$.datetimepicker.setLocale('zh'); // kr ko ja en
		//news_release_date 開始
		//news_last_date 結束
		var news_release_date = new Date();
		$('#news_release_date').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
			format:'Y-m-d H:i',
 				onShow:function( date ){
  					this.setOptions({
        			maxDate:jQuery('#news_last_date').val()?jQuery('#news_last_date').val():false
   				})
  			},
  			beforeShowDay: function(date) {
  		  		if (date.getYear() <  news_release_date.getYear() || 
  			    	(date.getYear() == news_release_date.getYear() && date.getMonth() <  news_release_date.getMonth()) || 
  			    	(date.getYear() == news_release_date.getYear() && date.getMonth() == news_release_date.getMonth() && date.getDate() < news_release_date.getDate())
  		        ){
  		             return [false, ""]
  		      	}
  		      	return [true, ""];
  			}
 		});
 		$('#news_last_date').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
			format:'Y-m-d H:i',
  			onShow:function( date ){
   				this.setOptions({
    				minDate:jQuery('#news_release_date').val()?jQuery('#news_release_date').val():false
   				})
  			},
 		});

	</script>
	
</html>