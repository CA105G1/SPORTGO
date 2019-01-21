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
<!-- 		<h1>this is add one news page</h1> -->
<%-- 錯誤表列 --%>
<%-- <c:if test="${not empty errorMsgs_tab2}"> --%>
<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs_tab2}">  <!-- 等同於${errorMsgs_tab2.entrySet()} --> --%>
<%-- 			<li style="color:red">${message.value}</li>  <!-- 等同於${message.getValue()} --> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>
<div class="container-fluid">
	<div class="row">
		<form action="<%=request.getContextPath()%>/news/news.do" method="post" enctype="multipart/form-data">
			<table class="table table-hover table-striped table-bordered text-center">
				<caption class="text-center">新增最新消息</caption>
				<tbody>
				
					<tr>
						<th><div class="mytile">消息種類<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<jsp:useBean id="newstypeService" scope="page" class="com.newstype.model.NewstypeService" />
							<select size="1" name="newstype_no" id="newstype_no" class="form-control">
								<option value=""></option>
								<c:forEach var="newstypeVO" items="${newstypeService.all}">
									<option value="${newstypeVO.newstype_no}" ${newsVO.newstype_no==newstypeVO.newstype_no?'selected':''}>${newstypeVO.newstype_name}</option>
								</c:forEach>
							</select>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("newstype_no")}</div>
						</td>
					</tr>
					<tr>
						<th><div class="mytile">消息內容</div></th>
						<td>
							<input type="text" name="news_script" value="${newsVO.news_script}" class="form-control"/>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("news_script")}</div> 
						</td>
					</tr>
					<tr>
						<th><div class="mytile">發布開始時間</div></th>
						<td>
							<c:if test="${newsVO==null}">
								<input type="text" id="news_release_date_tab2" name="news_release_date" value='' class="form-control"/>
							</c:if>
							<c:if test="${newsVO!=null}">
								<input type="text" id="news_release_date_tab2" name="news_release_date" class="form-control"
									value='<fmt:formatDate value="${newsVO.news_release_date}" pattern="yyyy-MM-dd HH:mm"/>'/>
								<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("news_release_date")}</div> 
							</c:if>
						</td>
					</tr>
					<tr>
						<th><div class="mytile">發布截止時間</div></th>
						<td>
							<c:if test="${newsVO==null}">
								<input type="text" id="news_last_date_tab2" name="news_last_date" value='' class="form-control"/>
							</c:if>
							<c:if test="${newsVO!=null}">
								<input type="text" id="news_last_date_tab2" name="news_last_date" class="form-control"
									value='<fmt:formatDate value="${newsVO.news_last_date}" pattern="yyyy-MM-dd HH:mm"/>'/>
								<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("news_last_date")}</div> 
							</c:if>						
						</td>
					</tr>
<!-- 				</tbody> -->
<!-- 			</table> -->
					<tr><th colspan="2">
						<input type="hidden" name="action"value="insert_one_news" />
						<input type="submit" value="送出" class="btn btn-success btn-block" class="form-control text-center" />
					</th></tr>
<!-- 			<table> -->
<!-- 				<tbody>				 -->
					<!------------ 圖片上傳 ------------>
					<tr>
						<th><div class="mytile">消息圖片上傳<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td colspan="2" class="uploadPicTd">
							<div>
								<input type="file" id="news_picture_tab2" name="news_picture" class="form-control text-center"/>
								<div class="pull-left errorMsgs-color">${errorMsgs_tab2.get("news_picture")}</div>
							</div>
							<div>
								<img src="<%=request.getContextPath()%>/img/no-image.PNG" id="showPic_tab2"
								class="img-responsive img-rounded center-block" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
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
		$('#news_release_date_tab2').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
 			beforeShowDay: function(date) {
  		  		if (date.getYear() <  news_release_date.getYear() || 
  			    	(date.getYear() == news_release_date.getYear() && date.getMonth() <  news_release_date.getMonth()) || 
  			    	(date.getYear() == news_release_date.getYear() && date.getMonth() == news_release_date.getMonth() && date.getDate() < news_release_date.getDate())
  		        ){
  		             return [false, ""]
  		      	}
  		      	return [true, ""];
  			},
			format:'Y-m-d H:i',
 				onShow:function( date ){
  					this.setOptions({
        			maxDate:jQuery('#news_last_date_tab2').val()?jQuery('#news_last_date_tab2').val():false
   				})
  			},
  			closeOnDateSelect:true
  			
 		});
 		$('#news_last_date_tab2').datetimepicker({
			theme: '',
 			step: 10,
 			timepicker: true,
			format:'Y-m-d H:i',
  			onShow:function( date ){
   				this.setOptions({
    				minDate:jQuery('#news_release_date_tab2').val()?jQuery('#news_release_date_tab2').val():false
   				})
  			},
  			closeOnDateSelect:true
 		});

	</script>
	
</html>