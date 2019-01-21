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
		#openday_week > div{
			padding-right:7px;
			padding-left:7px;
		}
		
	</style>
</head>
<body>
<!-- 	<h1>this is update one venue page for back</h1> -->
<%

%>
<!-- <div> -->
<%-- 	<form method="post" action="<%=request.getContextPath()%>/venue/venue.do"> --%>
<!-- 	 	<input type="hidden" name="action" value="update_reset"/> -->
<!-- 	 	<input type="submit" value="update_reset"/> -->
<!-- 	</form> -->
<!-- </div> -->
<!-- <div> -->
<%-- 	<form method="post" action="<%=request.getContextPath()%>/venue/venue.do"> --%>
<!-- 	 	<input type="hidden" name="action" value="update_cancel"/> -->
<!-- 	 	<input type="submit" value="update_cancel"/> -->
<!-- 	</form> -->
<!-- </div> -->
<!-- <div> -->
<%-- 	<form method="post" action="<%=request.getContextPath()%>/venue/venue.do"> --%>
<!-- 	 	<input type="hidden" name="action" value="update_commit"/> -->
<!-- 	 	<input type="submit" value="update_commit"/> -->
<!-- 	</form> -->
<!-- </div> -->
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
		
		<table class="table table-hover table-striped table-bordered text-center">
<%-- 			<caption class="text-center"> --%>
<%-- 					<div class='h3'>${venueVO.v_no}-${venueVO.v_name}-${venueTypeVO.vt_name}-詳細資料</div> --%>
<%-- 			</caption> --%>
			<thead>
				<tr>
					<th colspan="2">
						<div class="col-xs-12 col-sm-6">
							<form method="post" action="<%=request.getContextPath()%>/venue/venue.do">
								<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
		     					<input type="hidden" name="whichPage"	value="${param.whichPage}" />
		     					<input type="hidden" name="v_no" value="${venueVO_tab3.v_no}" />
		     					<input type="hidden" name="action" value="update_reset" />
								<input type="submit" value="回復原設定" class="btn btn-success btn-block" />
							</form>
						</div>
						<div class="col-xs-12 col-sm-6">
						</div>
					</th>			
				</tr>
			</thead>
			<tbody>
				<form action="<%=request.getContextPath()%>/venue/venue.do" method="post" enctype="multipart/form-data">
					<tr>
						<th><div class="mytitle">場地編號</div></th>
						<td><div class="pull-left" style="padding-left:17px">${venueVO_tab3.v_no}</div></td>
					</tr>
					<tr>
						<th><div class="mytitle">場地類型<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<jsp:useBean id="venueTypeService" scope="page" class="com.venuetype.model.VenueTypeService" />
							<select size="1" name="vt_no" id="vt_no_tab3" class="form-control text-center">
								<option value=""></option>
								<c:forEach var="venueTypeVO" items="${venueTypeService.all}">
									<option value="${venueTypeVO.vt_no}" ${venueTypeVO.vt_no==venueVO_tab3.vt_no?'selected':''}>${venueTypeVO.vt_name}</option>
								</c:forEach>
							</select>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("vt_no")}</div>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地名稱<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<input type="text" name="v_name" value="${venueVO_tab3.v_name}"  class="form-control"/>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("v_name")}</div> 
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">室內or室外<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<select size="1" name="v_inout" id="v_inout_tab3"  class="form-control text-center">
								<option value=""></option>
								<option value="室內設施" ${'室內設施'==venueVO_tab3.v_inout?'selected':''}>室內設施</option>
								<option value="室外設施" ${'室外設施'==venueVO_tab3.v_inout?'selected':''}>室外設施</option>
							</select>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("v_inout")}</div>
						</td>
					</tr>
					
<!-- 					<tr> -->
<!-- 						<th><div class="mytitle">場地地區</div></th> -->
<!-- 						<td> -->
<%-- 							<jsp:useBean id="regService" scope="page" class="com.region.model.RegService" /> --%>
<!-- 							<select size="1" name="reg_no" id="reg_no_tab3"  class="form-control text-center"> -->
<!-- 								<option value=""></option> -->
<%-- 								<c:forEach var="regVO" items="${regService.all}"> --%>
<%-- 									<option value="${regVO.reg_no}" ${regVO.reg_no==venueVO_tab3.reg_no?'selected':''}>${regVO.reg_name}-${regVO.getReg_dist().trim()}</option> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->
<%-- 							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("reg_no")}</div> --%>
<!-- 						</td> -->
<!-- 					</tr> -->
					
					
					<tr>
						<th><div class="mytitle">請選擇縣市</div></th>
						<td>
							<jsp:useBean id="regSvc" scope="page" class="com.region.model.RegService" />
	      					<select id="reg_name_tab3" size="1" name="reg_name" class="reg_name_class text-center form-control">
	      						<option value="">請選擇縣市</option>
	      						<c:forEach var="reg_name" items="${regSvc.reg_nameList }">
	      							<option value="${reg_name}">${reg_name}
	      						</c:forEach>
							</select>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">請選擇地區</div></th>
						<td>
							<select size="1" name="reg_dist" class="reg_dist_class text-center form-control" id="reg_dist_tab3">
	      						<option id="reg_dist_tab3Option" value="">請選擇地區</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">郵遞區號</div></th>
						<td>
							<div id="reg_no_show_tab3" class="pull-left"  style="padding-left:10px;">${venueVO_tab3.reg_no}</div>
							<input type="hidden" name='reg_no' value='' id='reg_no_tab3' class="form-control" />
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">場地地址<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<div id="v_address_show_tab3" class="pull-left"  style="padding-left:10px;"></div>
							<input type="text" id="v_address_temp_tab3" class="v_address_class form-control" value="${venueVO_tab3.v_address}"/>
							<input type="hidden" name="v_address" id="v_address_tab3" value="${venueVO_tab3.v_address}"/>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("v_address")}</div> 
						</td>
					</tr>
					
					
					<tr>
						<th><div class="mytitle">場地電話</div></th>
						<td>
							<input type="text" name="v_phoneno" value="${venueVO_tab3.v_phoneno}"  class="form-control"/>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("v_phoneno")}</div> 
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">開放狀態<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<select size="1" name="open_state" id="open_state_tab3"  class="form-control text-center">
								<option value=""></option>
								<option value="不開放對外使用" ${'不開放對外使用'==venueVO_tab3.open_state?'selected':''}>不開放對外使用</option>
								<option value="免費對外開放使用" ${'免費對外開放使用'==venueVO_tab3.open_state?'selected':''}>免費對外開放使用</option>
								<option value="付費對外開放使用" ${'付費對外開放使用'==venueVO_tab3.open_state?'selected':''}>付費對外開放使用</option>
							</select>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("open_state")}</div>
						</td>
					</tr>
					
					<tr>
						<th><div class="mytitle">開放日<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<div style="display:inline-flex" id="openday_week">
								<div >
									<div class='p'>星期一</div>
									<select size="1" name="openday_mon" id="openday_mon_tab3" class="form-control text-center">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab3.openday_mon?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab3.openday_mon?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期二</div>
									<select size="1" name="openday_tue" id="openday_tue_tab3" class="form-control text-center">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab3.openday_tue?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab3.openday_tue?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期三</div>
									<select size="1" name="openday_wed" id="openday_wed_tab3" class="form-control text-center">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab3.openday_wed?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab3.openday_wed?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期四</div>
									<select size="1" name="openday_thu" id="openday_thu_tab3" class="form-control text-center">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab3.openday_thu?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab3.openday_thu?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期五</div>
									<select size="1" name="openday_fri" id="openday_fri_tab3" class="form-control text-center">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab3.openday_fri?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab3.openday_fri?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期六</div>
									<select size="1" name="openday_sat" id="openday_sat_tab3" class="form-control text-center">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab3.openday_sat?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab3.openday_sat?'selected':''}>休館</option>
									</select>
								</div>
								
								<div>
									<div class='p'>星期日</div>
									<select size="1" name="openday_sun" id="openday_sun_tab3" class="form-control text-center">
										<option value=""></option>
										<option value="Y" ${'Y'==venueVO_tab3.openday_sun?'selected':''}>開放使用</option>
										<option value="N" ${'N'==venueVO_tab3.openday_sun?'selected':''}>休館</option>
									</select>
								</div>
							</div>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("openday_weak")}</div>
						</td>
					</tr>
					
					<% //TODO: 引入時間選擇器 ---> 確認OK送出 %>
<!-- 					<tr> -->
<!-- 						<th><div class="mytitle">開放時間</div></th> -->
<!-- 						<td> -->
<!-- 							<div>無法填入  TODO:引入時間選擇器   確認OK送出</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					
					
					<tr>
						<th><div class="mytitle">是否顯示<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<select size="1" name="v_display" id="v_display_tab3"  class="form-control text-center">
								<option value=""></option>
								<option value="顯示" ${'顯示'==venueVO_tab3.v_display?'selected':''}>顯示</option>
								<option value="不顯示" ${'不顯示'==venueVO_tab3.v_display?'selected':''}>不顯示</option>
							</select>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("v_display")}</div>
						</td>
					</tr>
					<tr>
						<th><div class="mytitle">適用對象-民眾<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							<select size="1" name="v_fitall" id="v_fitall_tab3"  class="form-control text-center">
								<option value=""></option>
								<option value="Y" ${'Y'==venueVO_tab3.v_fitall?'selected':''}>開放</option>
								<option value="N" ${'N'==venueVO_tab3.v_fitall?'selected':''}>不開放</option>
							</select>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("v_fitall")}</div>
						</td>
					</tr>
					<tr>
						<th><div class="mytitle">適用對象-內部人員<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td>
							
							<select size="1" name="v_fitinter" id="v_fitinter_tab3"  class="form-control text-center">
								<option value=""></option>
								<option value="Y" ${'Y'==venueVO_tab3.v_fitinter?'selected':''}>開放</option>
								<option value="N" ${'N'==venueVO_tab3.v_fitinter?'selected':''}>不開放</option>
							</select>
							<div class="center-block errorMsgs-color">${errorMsgs_tab3.get("v_fitinter")}</div>
						</td>
					</tr>
					<!------------ 圖片上傳 ------------>
					<tr>
						<th><div class="mytitle">圖片上傳<div style="color:red; padding-left:5px;"> * </div></div></th>
						<td class="uploadPicTd">
							<div>
								<input type="hidden" name="hasChangePictiure" id="hasChangePictiure_tab3" value="false">
								<input type="file" id="v_photo1_tab3" name="v_photo1"  class="form-control text-center"/>
								<div class="pull-left errorMsgs-color">${errorMsgs_tab3.get("v_photo1")}</div>
							</div>
							<div>
								<img id="showPic_tab3" class="img-responsive img-rounded center-block" 
								src="<%=request.getContextPath()%>/venue/venueImg.do?v_no=${venueVO_tab3.v_no}" />
							</div>
						</td>
					</tr>
					<tr>
						<th colspan='2'>
							<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>" /><!--送出本網頁的路徑給Controller-->
			     			<input type="hidden" name="whichPage"	value="${param.whichPage}" />
							<input type="hidden" name="v_no" value="${venueVO_tab3.v_no}" />
							<input type="hidden" name="action"value="update_commit">
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




