<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.venuetype.model.VenueTypeVO" %>
<%@ page import="com.venue.model.VenueVO"%>
<%@ page import="java.lang.SuppressWarnings"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<title>CA105G1:SPORTYGO:listAllVenue</title>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Title Page</title>
<!-- 	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
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
	
	.myAlign-Center{
		float:none;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.myAlign-Center div{
		margin:12px;
	}
	.table > tbody > tr > th{
            vertical-align: middle;
            text-align:center
        }
	</style>


</head>
<body>
<!-- 	<h1>This is listAllVenue.jsp</h1> -->

<!-- one card -->
<c:if test="${myList.size()!=0}">
	<% @SuppressWarnings("unchecked")
	   List<VenueVO> list = (List<VenueVO>)request.getAttribute("myList");%>
	<%@ include file="pages/page1_forVenue.file" %>
	<table class="table table-hover table-striped table-bordered table-condensed">
		<tbody>	
			<% int countItem=0;%> 
			<c:forEach var="venueVO" items="${myList}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
				<tr>
					<th>
						<div class="col-sm-1 h5" style="width:20px"><%=(++countItem)+(whichPage-1)*(rowsPerPage) %></div>
					</th>
					<td>
						<div class="col-sm-11">
							<div class="panel panel-default">
								<div class="panel-body">
									<%-- 先尋找vt_name --%>
									<c:forEach var="venueTypeVO" items="${venueTypeVOList}">
										<c:if test="${venueVO.vt_no==venueTypeVO.vt_no}">
											<c:set var="vt_name" value="${venueTypeVO.vt_name}" scope="page"/>
										</c:if>											
									</c:forEach>
									<h4>${venueVO.v_name}---${pageScope.vt_name}</h4>
									<div class="row">
										<div class="col-sm-9">
											<table class="table table-hover table-bordered table-condensed text-center">
												<tbody>
													<tr>
														<th>場地編號</th>
														<td>${venueVO.v_no}</td>
													</tr>
													<tr>
														<th>場地名稱</th>
														<td>${venueVO.v_name}</td>
													</tr>
													<tr>
														<th>場地種類</th>
														<td>${pageScope.vt_name}</td>
													</tr>
													<tr>
														<th>場地地址</th>
														<td>${venueVO.reg_no}-${venueVO.v_address}</td>
													</tr>
													<tr>
														<th>場地電話</th>
														<td>${venueVO.v_phoneno}</td>
													</tr>
													<tr>
														<th>場地開放狀態</th>
														<td>${venueVO.open_state}</td>
													</tr>
													<tr>
														<th>場地開放日期</th>
														<td>
															<c:if test="${venueVO.openday_mon=='Y'}"> 一 </c:if>
															<c:if test="${venueVO.openday_tue=='Y'}"> 二 </c:if>
															<c:if test="${venueVO.openday_wed=='Y'}"> 三 </c:if>
															<c:if test="${venueVO.openday_thu=='Y'}"> 四 </c:if>
															<c:if test="${venueVO.openday_fri=='Y'}"> 五 </c:if>
															<c:if test="${venueVO.openday_sat=='Y'}"> 六 </c:if>
															<c:if test="${venueVO.openday_sun=='Y'}"> 日 </c:if>
														</td>
													</tr>
													<tr ${v_evaluationVO.v_no==venueVO.v_no?'style="background-color:#FFEE99"':''}>
														<th>場地評價</th>
														<td>${scoreMap.get(venueVO.getV_no())==-1?'尚無評價分數':scoreMap.get(venueVO.getV_no())}</td>
													</tr>
													<c:if test="${memberlistVO!=null}">
														<tr>
															<th colspan='2'>
																<a href='#modal_id_${venueVO.v_no}' data-toggle="modal" class="btn btn-primary btn-block">評價場地</a>
																<div class="modal fade" id="modal_id_${venueVO.v_no}">
																	<div class="modal-dialog">
																		<div class="modal-content">
																			<form>
																				<div class="modal-header">
																					<h4 class="modal-title">${memberlistVO.mem_name}，你好。</h4>
																					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
																				</div>
																				<div class="modal-body">
																					<div>關於場地 : ${venueVO.v_name}-${pageScope.vt_name}</div>
																					<div>請給予評價分數</div>
																					<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>" />
																					<input type="hidden" name="whichPage" value="<%=whichPage%>" />
																					<div class="myAlign-Center">
																						
																						<div class="custom-control custom-radio">
																							<input type="radio" class="custom-control-input" id="radio_id_${venueVO.v_no}_1" name="score" value="1">
																							<label class="custom-control-label" for="radio_id_${venueVO.v_no}_1">一分</label>
																						</div>
																						<div class="custom-control custom-radio">
																							<input type="radio" class="custom-control-input" id="radio_id_${venueVO.v_no}_2" name="score" value="2">
																							<label class="custom-control-label" for="radio_id_${venueVO.v_no}_2">兩分</label>
																						</div> 
																						<div class="custom-control custom-radio">
																							<input type="radio" class="custom-control-input" id="radio_id_${venueVO.v_no}_3" name="score" value="3">
																							<label class="custom-control-label" for="radio_id_${venueVO.v_no}_3">三分</label>
																						</div> 
																						<div class="custom-control custom-radio">
																							<input type="radio" class="custom-control-input" id="radio_id_${venueVO.v_no}_4" name="score" value="4">
																							<label class="custom-control-label" for="radio_id_${venueVO.v_no}_4">四分</label>
																						</div> 
																						<div class="custom-control custom-radio">
																							<input type="radio" class="custom-control-input" id="radio_id_${venueVO.v_no}_5" name="score" value="5">
																							<label class="custom-control-label" for="radio_id_${venueVO.v_no}_5">五分</label>
																						</div> 
																						
																						
																					</div>
																					<input type="hidden" name="v_no" value="${venueVO.v_no}" />
																					<input type="hidden" name="mem_no" value="${memberlistVO.mem_no}" />																				
																					<input type="hidden" name="action" value="memEvaluateVenueInFrontEnd" />
																				</div>
																				<div class="modal-footer">
																					<button type="button" class="btn btn-default" data-dismiss="modal">關閉</button>
																					<button type="submit" class="btn btn-primary">Save changes</button>
																				</div>
																			</form>
																		</div>
																	</div>
																</div>
															</th>
														</tr>
													</c:if>
													
													
			<!-- 										<tr> -->
			<!-- 											<th></th> -->
			<!-- 											<td style="text-align:right"> -->
			<%-- 												<a href="<%=request.getContextPath()%>/venue/venue.do?action=get_one_venue&v_no=${venueVO.v_no}"> more...... </a> --%>
			<!-- 											</td> -->
			<!-- 										</tr> -->
												</tbody>
											</table>
										</div>
										<div class="col-sm-3">
	<!-- 										<p>URL</p> -->
	<!-- 										<div> -->
	<%-- 											<a href="${venueVO.v_photo1_url}"><img src="${venueVO.v_photo1_url}" class="img-responsive img-rounded"></a> --%>
	<!-- 										</div> -->
											<p>場地圖片</p>
											<div>
												<img src="<%=request.getContextPath()%>/venue/venueImg.do?v_no=${venueVO.v_no}" class="img-responsive img-rounded" alt="WTF"/>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</td>
		<!-- 			<div style="height:5px"></div> -->
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%@ include file="pages/page2_forVenue.file" %> 
</c:if>
<c:if test="${myList.size()==0}" >
	<table class="table table-hover table-striped table-bordered table-condensed">
		<tbody>
			<tr><th>---查無資料---</th></tr>
		</tbody>
	</table>
</c:if>


	<br>
	<br>
	<br>
<!-- 	<script src="https://code.jquery.com/jquery.js"></script> -->
<!-- 	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
	</body>
</html>