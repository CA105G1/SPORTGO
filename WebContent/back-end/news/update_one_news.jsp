<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:update_one_news</title>

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
	<h1>this is update one news page</h1>
<%

%>
<div class="container-fluid">
	<div class="row">
		<table class="table table-hover table-striped table-bordered text-center">
			<caption class="text-center">this is update news page</caption>
			<thead>
				<tr>
					<th colspan="2">
						<div class="col-xs-12 col-sm-6">
							<form method="post" action="<%=request.getContextPath()%>/news/news.do">
								<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
		     					<input type="hidden" name="whichPage"	value="${param.whichPage}" />
		     					<input type="hidden" name="news_no" value="${newsVO.news_no}" />
		     					<input type="hidden" name="action" value="getOne_For_Update" />
								<input type="submit" value="回復原設定" class="btn btn-success btn-block" />
							</form>
						</div>
						<div class="col-xs-12 col-sm-6">
						</div>
					</th>			
				</tr>
			</thead>
			<form action="<%=request.getContextPath()%>/news/news.do" method="post" enctype="multipart/form-data">
				<tbody>
					<tr>
						<th><div class="mytile">消息編號</div></th>
						<td>${newsVO.news_no}</td>
					</tr>
					<tr>
						<th><div class="mytile">消息種類</div></th>
						<td>
							<jsp:useBean id="newstypeService" scope="page" class="com.newstype.model.NewstypeService" />
							<select size="1" name="newstype_no" id="newstype_no">
								<option value=""></option>
								<c:forEach var="newstypeVO" items="${newstypeService.all}">
									<option value="${newstypeVO.newstype_no}" ${newsVO.newstype_no==newstypeVO.newstype_no?'selected':''}>${newstypeVO.newstype_name}</option>
								</c:forEach>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("newstype_no")}</div>
						</td>
					</tr>
					<tr>
						<th><div class="mytile">消息內容</div></th>
						<td>
							<input type="text" name="news_script" value="${newsVO.news_script}"/><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("news_script")}</div> 
						</td>
					</tr>
					<tr>
						<th><div class="mytile">發布開始時間</div></th>
						<td>
							<c:if test="${newsVO==null}">
								<input type="text" id="news_release_date_tab3" name="news_release_date" value=''/>
							</c:if>
							<c:if test="${newsVO!=null}">
								<input type="text" id="news_release_date_tab3" name="news_release_date" 
									value='<fmt:formatDate value="${newsVO.news_release_date}" pattern="yyyy-MM-dd HH:mm"/>'/><br>
								<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("news_release_date")}</div> 
							</c:if>
						</td>
					</tr>
					<tr>
						<th><div class="mytile">發布截止時間</div></th>
						<td>
							<c:if test="${newsVO==null}">
								<input type="text" id="news_last_date_tab3" name="news_last_date" value=''/>
							</c:if>
							<c:if test="${newsVO!=null}">
								<input type="text" id="news_last_date_tab3" name="news_last_date" 
									value='<fmt:formatDate value="${newsVO.news_last_date}" pattern="yyyy-MM-dd HH:mm"/>'/><br>
								<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("news_last_date")}</div> 
							</c:if>	
						</td>
					</tr>
					<!------------ 圖片上傳 ------------>
					<tr>
						<td colspan="2" class="uploadPicTd">
							<div>
								<input type="hidden" name="hasChangePicture" id="hasChangePicture_tab3" value="false">
								<input type="file" id="news_picture_tab3" name="news_picture" />
								<div class="pull-left errorMsgs-color">${errorMsgs_tab3.get("news_picture")}</div>
							</div>
							<div>
								<img  id="showPic_tab3s" class="img-responsive img-rounded center-block" 
								src="<%=request.getContextPath()%>/news/newsImg.do?news_no=${newsVO.news_no}" />
							</div>
						</td>
					</tr>
					<tr>
						<th colspan='2'>
							<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
			     			<input type="hidden" name="whichPage"	value="${param.whichPage}" />
							<input type="hidden" name="news_no" value="${newsVO.news_no}" />
							<input type="hidden" name="action" value="update_news_no_stutas">
							<input type="submit" value="確定更新" class="btn btn-success btn-block">
						</th>
					</tr>
				</tbody>
			</form>
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
	
// 		//照片上傳
// 		$("#news_picture_tab3").change(function(){
// 			readURL_tab3(this);
// 			$('#hasChangePicture_tab3').val("true");
// 			console.log("hasChangePicture : "+($('#hasChangePicture_tab3').val()));
// 		});
	
// 		function readURL_tab3(input){
// 			if(input.files && input.files[0]){
// 				var reader = new FileReader();
// 				reader.onload = function(e){
// 					$('#showPic_tab3').attr({"src":e.target.result, "width":"200px"})
// 					console.log("#showPic_tab3 : "+($('#showPic_tab3').attr("src")));
// 				}
// 				reader.readAsDataURL(input.files[0]);
// 			}
// 		}
		
		
	
		//設定時間
		$.datetimepicker.setLocale('zh'); // kr ko ja en
		//news_release_date 開始
		//news_last_date 結束
		var news_release_date_tab3 = new Date();
		$('#news_release_date_tab3').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
			format:'Y-m-d H:i',
 				onShow:function( date ){
  					this.setOptions({
        			maxDate:jQuery('#news_last_date_tab3').val()?jQuery('#news_last_date_tab3').val():false
   				})
  			},
  			beforeShowDay: function(date) {
  		  		if (date.getYear() <  news_release_date_tab3.getYear() || 
  			    	(date.getYear() == news_release_date_tab3.getYear() && date.getMonth() <  news_release_date_tab3.getMonth()) || 
  			    	(date.getYear() == news_release_date_tab3.getYear() && date.getMonth() == news_release_date_tab3.getMonth() && date.getDate() < news_release_date_tab3.getDate())
  		        ){
  		             return [false, ""]
  		      	}
  		      	return [true, ""];
  			}
 		});
 		$('#news_last_date_tab3').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
			format:'Y-m-d H:i',
  			onShow:function( date ){
   				this.setOptions({
    				minDate:jQuery('#news_release_date_tab3').val()?jQuery('#news_release_date_tab3').val():false
   				})
  			},
 		});

	</script>
	
</html>