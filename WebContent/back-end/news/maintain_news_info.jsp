<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.news.model.NewsVO" %>
<%@ page import="java.util.List"%>



<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SportGo:最新消息管理</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<!-- Favicon -->
	    <link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
	
		
		<style>
		input{
			height:30px
		}
		.label-text{
			font-size:1.3em;
		}
		</style>
		
		
	</head>
	<body>
 		<%-- include header --%> 
		<%-- <%@ include file="/back-end/CA105G1_header_back.file" %> --%>
 		<%-- include show_loginBox--%> 
		<%-- <%@ include file="/back-end/emp/loginfile/showLoginBackEnd.file" %> --%>
		<jsp:include page="/back-end/CA105G1_header_back.jsp"/>
		

		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
<!-- <h1>後台共用區</h1> -->
<!-- <h2>here need include left_side_field.jsp</h2> -->
					<jsp:include page="/back-end/left_side_field.jsp"/>
					
				</div>
				
	<% 			String whichTab = (String)request.getAttribute("whichTab"); %>
				<div class="col-xs-12 col-sm-9">
					<h1>最新消息管理</h1>
					
					<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
							<!-- 使用request.getAttribute("whichtab")來分辨，哪個class is active -->
					        <li role="presentation" class="${whichTab==null?'active':(whichTab=='tab1'?'active':'') }">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">查詢、更新</a>
					        </li>
					        <li role="presentation" class="${whichTab=='tab2'?'active':'' }">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">新增</a>
					        </li>
					        
					        <% if("tab3".equals(whichTab)){ %>
								<li role="presentation" class="${whichTab=='tab3'?'active':'' }">
					            	<a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">更新</a>
					      		</li>
					      	<% } %>
					        
					        
					    </ul>
					
			<!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					    	<!-- 使用request.getAttribute("whichtab")來分辨，哪個class is active -->
					        <div role="tabpanel" class="tab-pane ${whichTab==null?'active':(whichTab=='tab1'?'active':'') }" id="tab1">
			<%-- 查詢面板  --%>	
<!-- 								<h1>查詢、更新</h1> -->
					        	<div class="panel panel-info">
									<div class="panel-heading">
<!-- 										<h3 class="panel-title">最新消息管理</h3> -->
										<div class="panel-title" role="button" data-toggle="collapse" href="#cc2" aria-expanded="false" aria-controls="#cc2">
										    最新消息管理
										</div>
									</div>
									<% if("listNewsByCompositeQuery".equals(request.getParameter("action")) || "showOneNews".equals(request.getParameter("action"))
											|| "delete_this_news".equals(request.getParameter("action")) 
											|| ("update_news_no_stutas".equals(request.getParameter("action")) && ("tab2".equals(whichTab))) ){ %>
										<div class="collapse" id="cc2">
									<% }else {%>
										<div class="collapse in" id="cc2">
									<% }%>
										<div class="panel-body">
											<form method="post" action="<%=request.getContextPath()%>/news/news.do">
												
												<table class="table table-hover table-striped table-bordered">
													<tr>
														<th><label>請輸入消息編號 : (N001)</label></th>
														<td>
															<input type="text" name="news_no" value='${newsMap.get("news_no")[0]}' class="text-left form-control"/>
														</td>
													</tr>
													
													<tr>
														<th><label>請輸入消息內容進行關鍵字查詢 :</label></th>
														<td>
															<input type="text" name="news_script" value='${newsMap.get("news_script")[0]}' class="text-left form-control"/>
														</td>
													</tr>
													
													<tr>
														<th><label>請選擇消息種類 :</label></th>
														<td>
															<select size="1" name="newstype_no" class="text-left form-control">
																<option value=""></option>
																<c:forEach var="newstypeVO" items="${applicationScope.newsTypeVOList}">
																	<option value="${newstypeVO.newstype_no}" ${newsMap.get("newstype_no")[0]==newstypeVO.newstype_no?'selected':''}>
																		${newstypeVO.newstype_name}
																	</option>
																</c:forEach>
															</select>
														</td>
													</tr>
													
													<tr>
														<th><label>請選擇消息狀態 :</label></th>
														<td>
															<select size="1" name="news_stutas"  class="text-left form-control">
																<option value=""></option>
																<option value="未發布" ${newsMap.get("news_stutas")[0]=='未發布'?'selected':''}> 未發布 </option>
																<option value="發布中" ${newsMap.get('news_stutas')[0]=='發布中'?'selected':''}> 發布中 </option>
																<option value="下架"   ${newsMap.get('news_stutas')[0]=='下架'  ?'selected':''}> 下架 </option>
															</select>
														</td>
													</tr>
													
													<tr>
														<th><label>請選擇開始發布時間 :</label></th>
														<td>
															<input type="text" name="news_release_date" id="news_release_date_tab1" 
															value="${newsMap.get('news_release_date')[0]}" class="text-left form-control"/>
														</td>
													</tr>
													
													<tr>
														<th><label>請選擇結束發布時間 :</label></th>
														<td>
															<input type="text" name="news_last_date" id="news_last_date_tab1" 
															value="${newsMap.get('news_last_date')[0]}" class="text-left form-control"/>
														</td>
													</tr>
													
													<tr>
														<th colspan="2">
														<input type="hidden" name="action" value="listNewsByCompositeQuery" />
														<input type="submit" value="送出查詢" class="btn btn-primary btn-block"/>
														</th>
													</tr>
													
												</table>
											</form>
										</div>
									</div> <!-- for collapse -->
									<%-- 錯誤表列 --%>
									<c:if test="${not empty errorMsgs_tab1}">
										<ul>
											<c:forEach var="message" items="${errorMsgs_tab1}">
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
										<% }else if("showOneNews".equals(request.getParameter("action"))){ %>
												<jsp:include page="show_one_news.jsp" flush="true"/>
										<% }else if("delete_this_news".equals(request.getParameter("action"))){ %>
												<div>${newsVO.news_no}-${newsVO.news_script}--已被刪除</div>
										<% }else if("update_news_no_stutas".equals(request.getParameter("action")) && ("tab2".equals(whichTab))){ %>
												<jsp:include page="listQueryNews.jsp" flush="true" />
										<% } %>
						        	</div>
									
									
									
								</div>
					        </div>
					        
					        
					 <%-- <%=request.getContextPath()%>/back-end/news/maintain_news_info.jsp#tab2 --%>       
					        <div role="tabpanel" class="tab-pane ${whichTab=='tab2'?'active':'' }" id="tab2">
					        	<jsp:include page="/back-end/news/add_one_news.jsp" />
					        </div>
					       <% if("tab3".equals(whichTab)){ %>
								<div role="tabpanel" class="tab-pane ${whichTab=='tab3'?'active':'' }" id="tab3">
					        		<jsp:include page="/back-end/news/update_one_news.jsp" />
					        	</div>
							<% } %>
					       
					        
					        
					        
					        
					    </div>
					</div>
					
					
				</div>
			</div>
		</div>



		<%@ include file="/back-end/CA105G1_footer_back.file" %>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
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
	
		
// 		$("#news_picture_tab2").change(function(){
// 			readURL(this);
// 		});
	
// 		function readURL(input){
// 			if(input.files && input.files[0]){
// 				var reader = new FileReader();
// 				reader.onload = function(e){
// 					$('#showPic_tab2').attr({"src":e.target.result, "width":"200px"});
// 					console.log("#showPic_tab2 : "+($('#showPic_tab2').attr("src")));
// 				}
// 				reader.readAsDataURL(input.files[0]);
// 			}
// 		}
	
		//設定時間
		$.datetimepicker.setLocale('zh'); // kr ko ja en
		//news_release_date 開始
		//news_last_date 結束
		var news_release_date = new Date();
		$('#news_release_date_tab1').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
//  			beforeShowDay: function(date) {
//   		  		if (date.getYear() <  news_release_date.getYear() || 
//   			    	(date.getYear() == news_release_date.getYear() && date.getMonth() <  news_release_date.getMonth()) || 
//   			    	(date.getYear() == news_release_date.getYear() && date.getMonth() == news_release_date.getMonth() && date.getDate() < news_release_date.getDate())
//   		        ){
//   		             return [false, ""]
//   		      	}
//   		      	return [true, ""];
//   			},
			format:'Y-m-d H:i',
 				onShow:function( date ){
  					this.setOptions({
        			maxDate:jQuery('#news_last_date_tab1').val()?jQuery('#news_last_date_tab1').val():false
   				})
  			},
  			closeOnDateSelect:true
  			
 		});
 		$('#news_last_date_tab1').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
			format:'Y-m-d H:i',
  			onShow:function( date ){
   				this.setOptions({
    				minDate:jQuery('#news_release_date_tab1').val()?jQuery('#news_release_date_tab1').val():false
   				})
  			},
  			closeOnDateSelect:true
 		});

	</script>
	
	<script type="text/javascript">
	
	//照片上傳
	var temp_My_pic;
	var test = $(":file").change(function(){
		temp_My_pic = "#"+$(this).context.id;
		readURL(this);
		if(temp_My_pic=="#news_picture_tab3"){
			$('#hasChangePicture_tab3').val("true");
		}
// 	原始		<input type="hidden" name="hasChangePicture" id="hasChangePicture_tab3" value="false">
// 			<input type="file" id="news_picture_tab3" name="news_picture" />
	});
	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$(temp_My_pic).parent().next().empty();
				$(temp_My_pic).parent().next().append("<img/>");
				$(temp_My_pic).parent().next().children().attr({"src":e.target.result, "class":"img-responsive img-rounded center-block"});
			};
			reader.readAsDataURL(input.files[0]);
		};
	}

	</script>
	
	
	
</html>