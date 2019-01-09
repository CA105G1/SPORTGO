<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	</style>
</head>
<body>
	<h1>this is add one news page</h1>
<!-- 	<from> -->
<!-- 		選擇輸入類型<input type="text" name="" value="" /> -->
<!-- 		<input type="text" name="" value="" /> -->
<!-- 		<input type="text" name="" value="" /> -->
<!-- 		<input type="text" name="" value="" /> -->
<!-- 		<input type="text" name="" value="" /> -->
<!-- 		<input type="text" name="" value="" /> -->
<!-- 		<input type="text" name="" value="" /> -->
<!-- 		<input type="text" name="" value="" /> -->
<!-- 	</from> -->
<%

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
		<form action="<%=request.getContextPath()%>/news/news.do" method="post" enctype="multipart/form-data">
			<table class="table table-hover table-striped table-bordered text-center">
				<caption class="text-center">this is add news page</caption>
				<tbody>
				<!------------ 圖片上傳 ------------>
					<tr>
						<td colspan="2" class="uploadPicTd">
							<img src="<%=request.getContextPath()%>/img/no-image.PNG" style="width:100%"  id="showPic">
							<input type="file" id="news_picture" name="news_picture"><br>
							<div class="pull-left errorMsgs-color">${errorMsgs.get("news_picture")}</div><br>
						</td>
					</tr>
					<tr>
						<th>消息種類</th>
						<td>
							<jsp:useBean id="newstypeService" scope="page" class="com.newstype.model.NewstypeService" />
							<select size="1" name="newstype_no" id="newstype_no">
								<option value=""></option>
								<c:forEach var="newstypeVO" items="${newstypeService.all}">
									<option value="${newstypeVO.newstype_no}" ${newsVO.newstype_no==newstypeVO.newstype_no?'selected':''}>${newstypeVO.newstype_name}</option>
<%--				<option value="${sportVO.sp_no}" ${(param.sp_no == sportVO.sp_no)? 'selected':'' }>${sportVO.sp_name} --%>
								</c:forEach>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs.get("newstype_no")}</div>
						</td>
					</tr>
					<tr>
						<th>消息內容</th>
						<td>
							<input type="text" name="news_script" value="${newsVO.news_script}"/><br>
							<div class="center-block errorMsgs-color">${errorMsgs.get("news_script")}</div> 
						</td>
					</tr>
					<tr>
						<th>發布開始時間</th>
						<td>
							<input type="text" id="news_release_date" name="news_release_date" value='${newsVO.getNews_release_date()}'/><br>
							<div class="center-block errorMsgs-color">${errorMsgs.get("news_release_date")}</div> 
						</td>
					</tr>
					<tr>
						<th>發布截止時間</th>
						<td>
							<input type="text" id="news_last_date" name="news_last_date" value="${newsVO.getNews_last_date()}"/><br>
							<div class="center-block errorMsgs-color">${errorMsgs.get("news_last_date")}</div> 
						</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="action"value="insert_one_news">
			<input type="submit" value="送出" class="btn btn-success btn-block">
		</form>
	</div>
	<div class="col-xs-12 col-sm-3"></div>
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
	
		//照片上傳
		$("#news_picture").change(function(){
			readURL(this);
		});
	
		function readURL(input){
			if(input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e){
					var img = document.getElementById("showPic");
					img.src=e.target.result;
// 					img.maxHeight = "300px";
//  					img.width = 100%;
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	
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