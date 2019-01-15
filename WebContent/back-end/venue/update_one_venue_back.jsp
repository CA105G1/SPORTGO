<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:update_one_venue_back</title>

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
	<h1>this is update one venue page for back</h1>
<%

%>
<div>
	<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
	 	<input type="hidden" name="action" value="update_reset"/>
	 	<input type="submit" value="update_reset"/>
	</form>
</div>
<!-- <div> -->
<%-- 	<form method="post" action="<%=request.getContextPath()%>/venue/venue.do"> --%>
<!-- 	 	<input type="hidden" name="action" value="update_cancel"/> -->
<!-- 	 	<input type="submit" value="update_cancel"/> -->
<!-- 	</form> -->
<!-- </div> -->
<div>
	<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
	 	<input type="hidden" name="action" value="update_commit"/>
	 	<input type="submit" value="update_commit"/>
	</form>
</div>
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs_tab3}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs_tab3}">  <!-- 等同於${errorMsgs.entrySet()} -->
			<li style="color:red">${message.value}</li>  <!-- 等同於${message.getValue()} -->
		</c:forEach>
	</ul>
</c:if>

<div class="container-fluid">
	<div class="row">
		<form action="<%=request.getContextPath()%>/venue/venue.do" method="post" enctype="multipart/form-data">
			<table class="table table-hover table-striped table-bordered text-center">
				<caption class="text-center">this is add venue page</caption>
				<tbody>
					<tr>
						<th><div class="mytitle">場地編號</div></th>
						<td>
						
						</td>
					</tr>
					<tr>
						<th><div class="mytitle">場地類型</div></th>
						<td>
							<jsp:useBean id="venueTypeService" scope="page" class="com.venuetype.model.VenueTypeService" />
							<select size="1" name="vt_no" id="vt_no">
								<option value=""></option>
								<c:forEach var="venueTypeVO" items="${venueTypeService.all}">
									<option value="${venueTypeVO.vt_no}" ${venueTypeVO.vt_no==venueVO_tab2.vt_no?'selected':''}>${venueTypeVO.vt_name}</option>
								</c:forEach>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("vt_no")}</div>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地名稱</div></th>
						<td>
							<input type="text" name="v_name" value="${venueVO_tab2.v_name}"/><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("v_name")}</div> 
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">室內or室外</div></th>
						<td>
							<select size="1" name="v_inout" id="v_inout">
								<option value=""></option>
								<option value="室內設施" ${'室內設施'==venueVO_tab2.v_inout?'selected':''}>室內設施</option>
								<option value="室外設施" ${'室外設施'==venueVO_tab2.v_inout?'selected':''}>室外設施</option>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("v_inout")}</div>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地地區</div></th>
						<td>
							<jsp:useBean id="regService" scope="page" class="com.region.model.RegService" />
							<select size="1" name="reg_no" id="reg_no">
								<option value=""></option>
								<c:forEach var="regVO" items="${regService.all}">
									<option value="${regVO.reg_no}" ${regVO.reg_no==venueVO_tab2.reg_no?'selected':''}>${regVO.reg_name}-${regVO.getReg_dist().trim()}</option>
								</c:forEach>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("reg_no")}</div>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地地址</div></th>
						<td>
							<input type="text" name="v_address" value="${venueVO_tab2.v_address}"/><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("v_address")}</div> 
						</td>
					</tr>
					
					
					<tr>
						<th><div class="mytitle">場地電話</div></th>
						<td>
							<input type="text" name="v_phoneno" value="${venueVO_tab2.v_phoneno}"/><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("v_phoneno")}</div> 
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">開放狀態</div></th>
						<td>
							<select size="1" name="open_state" id="open_state">
								<option value=""></option>
								<option value="不開放對外使用" ${'不開放對外使用'==venueVO_tab2.open_state?'selected':''}>不開放對外使用</option>
								<option value="免費對外開放使用" ${'免費對外開放使用'==venueVO_tab2.open_state?'selected':''}>免費對外開放使用</option>
								<option value="付費對外開放使用" ${'付費對外開放使用'==venueVO_tab2.open_state?'selected':''}>付費對外開放使用</option>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("open_state")}</div>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">開放日</div></th>
						<td>
							<div style="display:inline-flex">
								<div>
									<div class='p'>星期一</div>
									<select size="1" name="openday_mon" id="openday_mon">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab2.openday_mon?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab2.openday_mon?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期二</div>
									<select size="1" name="openday_tue" id="openday_tue">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab2.openday_tue?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab2.openday_tue?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期三</div>
									<select size="1" name="openday_wed" id="openday_wed">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab2.openday_wed?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab2.openday_wed?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期四</div>
									<select size="1" name="openday_thu" id="openday_thu">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab2.openday_thu?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab2.openday_thu?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期五</div>
									<select size="1" name="openday_fri" id="openday_fri">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab2.openday_fri?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab2.openday_fri?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期六</div>
									<select size="1" name="openday_sat" id="openday_sat">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab2.openday_sat?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab2.openday_sat?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期日</div>
									<select size="1" name="openday_sun" id="openday_sun">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab2.openday_sun?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab2.openday_sun?'selected':''}>休館</option>
									</select>
								</div>
							</div>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("openday_weak")}</div>
						</td>
					</tr>
					
					<% //TODO: 引入時間選擇器 ---> 確認OK送出 %>
					<tr>
						<th><div class="mytitle">開放時間</div></th>
						<td>
							<div>無法填入-->TODO:引入時間選擇器 ---> 確認OK送出</div>
						</td>
					</tr>
					
					
					<tr>
						<th><div class="mytitle">是否顯示</div></th>
						<td>
							<select size="1" name="v_display" id="v_display">
								<option value=""></option>
								<option value="顯示" ${'顯示'==venueVO_tab2.v_display?'selected':''}>顯示</option>
								<option value="不顯示" ${'不顯示'==venueVO_tab2.v_display?'selected':''}>不顯示</option>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("v_display")}</div>
						</td>
					</tr>
					<tr>
						<th><div class="mytitle">適用對象-民眾</div></th>
						<td>
							
							<select size="1" name="v_fitall" id="v_fitall">
								<option value=""></option>
								<option value="Y" ${'Y'==venueVO_tab2.v_fitall?'selected':''}>開放</option>
								<option value="N" ${'N'==venueVO_tab2.v_fitall?'selected':''}>不開放</option>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("v_fitall")}</div>
						</td>
					</tr>
					<tr>
						<th><div class="mytitle">適用對象-內部人員</div></th>
						<td>
							
							<select size="1" name="v_fitinter" id="v_fitinter">
								<option value=""></option>
								<option value="Y" ${'Y'==venueVO_tab2.v_fitinter?'selected':''}>開放</option>
								<option value="N" ${'N'==venueVO_tab2.v_fitinter?'selected':''}>不開放</option>
							</select><br>
							<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("v_fitinter")}</div>
						</td>
					</tr>
					
					
				</tbody>
			</table>
			<input type="hidden" name="action"value="insert_one_venue">
			<input type="submit" value="送出" class="btn btn-success btn-block">
			<table>
				<tbody>				
					<!------------ 圖片上傳 ------------>
					<tr>
						<td colspan="2" class="uploadPicTd">
							<div>
								<input type="file" id="v_photo1_tab2" name="v_photo1" />
								<div class="pull-left errorMsgs-color">${errorMsgs_tab2.get("v_photo1")}</div>
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


<!-- <div class="container-fluid"> -->
<!-- 	<div class="row"> -->
<!-- 		<table class="table table-hover table-striped table-bordered text-center"> -->
<%-- 			<caption class="text-center">this is update news page</caption> --%>
<!-- 			<thead> -->
<!-- 				<tr> -->
<!-- 					<th colspan="2"> -->
<!-- 						<div class="col-xs-12 col-sm-6"> -->
<%-- 							<form method="post" action="<%=request.getContextPath()%>/news/news.do"> --%>
<%-- 								<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller--> --%>
<%-- 		     					<input type="hidden" name="whichPage"	value="${param.whichPage}" /> --%>
<%-- 		     					<input type="hidden" name="news_no" value="${newsVO.news_no}" /> --%>
<!-- 		     					<input type="hidden" name="action" value="getOne_For_Update" /> -->
<!-- 								<input type="submit" value="回復原設定" class="btn btn-success btn-block" /> -->
<!-- 							</form> -->
<!-- 						</div> -->
<!-- 						<div class="col-xs-12 col-sm-6"> -->
<!-- 						</div> -->
<!-- 					</th>			 -->
<!-- 				</tr> -->
<!-- 			</thead> -->
<%-- 			<form action="<%=request.getContextPath()%>/news/news.do" method="post" enctype="multipart/form-data"> --%>
<!-- 				<tbody> -->
<!-- 					<tr> -->
<!-- 						<th><div class="mytile">消息編號</div></th> -->
<%-- 						<td>${newsVO.news_no}</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th><div class="mytile">消息種類</div></th> -->
<!-- 						<td> -->
<%-- 							<jsp:useBean id="newstypeService" scope="page" class="com.newstype.model.NewstypeService" /> --%>
<!-- 							<select size="1" name="newstype_no" id="newstype_no"> -->
<!-- 								<option value=""></option> -->
<%-- 								<c:forEach var="newstypeVO" items="${newstypeService.all}"> --%>
<%-- 									<option value="${newstypeVO.newstype_no}" ${newsVO.newstype_no==newstypeVO.newstype_no?'selected':''}>${newstypeVO.newstype_name}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select><br> -->
<%-- 							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("newstype_no")}</div> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th><div class="mytile">消息內容</div></th> -->
<!-- 						<td> -->
<%-- 							<input type="text" name="news_script" value="${newsVO.news_script}"/><br> --%>
<%-- 							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("news_script")}</div>  --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th><div class="mytile">發布開始時間</div></th> -->
<!-- 						<td> -->
<%-- 							<c:if test="${newsVO==null}"> --%>
<!-- 								<input type="text" id="news_release_date_tab3" name="news_release_date" value=''/> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test="${newsVO!=null}"> --%>
<!-- 								<input type="text" id="news_release_date_tab3" name="news_release_date"  -->
<%-- 									value='<fmt:formatDate value="${newsVO.news_release_date}" pattern="yyyy-MM-dd HH:mm"/>'/><br> --%>
<%-- 								<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("news_release_date")}</div>  --%>
<%-- 							</c:if> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th><div class="mytile">發布截止時間</div></th> -->
<!-- 						<td> -->
<%-- 							<c:if test="${newsVO==null}"> --%>
<!-- 								<input type="text" id="news_last_date_tab3" name="news_last_date" value=''/> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test="${newsVO!=null}"> --%>
<!-- 								<input type="text" id="news_last_date_tab3" name="news_last_date"  -->
<%-- 									value='<fmt:formatDate value="${newsVO.news_last_date}" pattern="yyyy-MM-dd HH:mm"/>'/><br> --%>
<%-- 								<div class="center-block errorMsgs-color">${errorMsgs_tab2.get("news_last_date")}</div>  --%>
<%-- 							</c:if>	 --%>
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 					---------- 圖片上傳 ---------- -->
<!-- 					<tr> -->
<!-- 						<td colspan="2" class="uploadPicTd"> -->
<!-- 							<div> -->
<!-- 								<input type="hidden" name="hasChangePicture" id="hasChangePicture_tab3" value="false"> -->
<!-- 								<input type="file" id="news_picture_tab3" name="news_picture" /> -->
<%-- 								<div class="pull-left errorMsgs-color">${errorMsgs_tab3.get("news_picture")}</div> --%>
<!-- 							</div> -->
<!-- 							<div> -->
<!-- 								<img  id="showPic_tab3s" class="img-responsive img-rounded center-block"  -->
<%-- 								src="<%=request.getContextPath()%>/news/newsImg.do?news_no=${newsVO.news_no}" /> --%>
<!-- 							</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th colspan='2'> -->
<%-- 							<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller--> --%>
<%-- 			     			<input type="hidden" name="whichPage"	value="${param.whichPage}" /> --%>
<%-- 							<input type="hidden" name="news_no" value="${newsVO.news_no}" /> --%>
<!-- 							<input type="hidden" name="action" value="update_news_no_stutas"> -->
<!-- 							<input type="submit" value="確定更新" class="btn btn-success btn-block"> -->
<!-- 						</th> -->
<!-- 					</tr> -->
<!-- 				</tbody> -->
<!-- 			</form> -->
<!-- 		</table> -->
<!-- 	</div> -->
<!-- </div> -->


	
	
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
  			},
  			closeOnDateSelect:true
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
  			closeOnDateSelect:true
 		});

	</script>
	
</html>