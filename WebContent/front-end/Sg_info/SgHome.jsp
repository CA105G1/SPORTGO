<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.sg_info.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
    
    
<% 
List<Sg_infoVO> list = null;
//取得複合查詢後的list
list = (List<Sg_infoVO>)request.getAttribute("list");
//若沒有值就代表是第一次載入頁面，直接getAll
if(list == null){
	Sg_infoService svc = new Sg_infoService(); 
	list = svc.getAllForPublic();
	pageContext.setAttribute("list",list);
}
	
%>

<html>
<head>
<meta charset="utf-8">
<title>揪團專區</title>


<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
   
</head>
<body>

<jsp:include page="/front-end/CA105G1_header_bt4.jsp" />




<!-- 麵包屑 -->
<div class="breadcrumb-area">
    <!-- Top Breadcrumb Area -->
    <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/sgpic/sportbg2.jpg);">
    </div>

    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/index.jsp"><i class="fa fa-home"></i> 首頁</a></li>
                   		<li class="breadcrumb-item active" aria-current="page">揪團專區</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>



	<div class="container-fluid">
		<div class="row">

			<div class="col-sm-3 offset-1">
				
<!-------------------- 建立揪團區塊 ---------------------->
		 		<a class="btn btn-success btn-block" href="<%= request.getContextPath()%>/front-end/Sg_info/Sg_infoCreate.jsp" style="margin-bottom:10px;">建立揪團</a>
<!------------------------------------ 查詢區塊 ----------------------------------->
			    <!-- Shop Widget -->
                   <div class="shop-widget price mb-50">
                    <button type="button" class="btn btn-secondary btn-block" disabled>揪團查詢</button>
                   	<div class="widget-desc">
				      	<form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do">
			      			<!-------- 運動種類查詢 --------->
			      			<label style="font-weight:bold">運動種類</label>
	      					<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
	      					<select size="1" name="sp_no" class="text-center form-control">
	      						<option value="">請選擇運動種類
								<c:forEach var="sportVO" items="${sportSvc.all}" > 
									<option value="${sportVO.sp_no}">${sportVO.sp_name}
								</c:forEach>   
							</select>
			      			<!-------- 縣市查詢 --------->
		      				<label style="font-weight:bold">縣市</label>
	      					<jsp:useBean id="regSvc" scope="page" class="com.region.model.RegService" />
	      					<select id="reg_name" size="1" name="reg_name" class="text-center form-control">
	      						<option value="">請選擇縣市
	      						<c:forEach var="reg_name" items="${regSvc.reg_nameList }">
	      							<option value="${reg_name }">${reg_name}
	      						</c:forEach>
							</select>
	      					<!-------- 地區查詢 --------->
		      				<label style="font-weight:bold">地區</label>
	      					<select size="1" name="reg_dist" class="text-center form-control">
	      						<option id="reg_dist" value="">請選擇地區
							</select>
				      		<!-------- 場地名稱查詢 --------->
		      				<label style="font-weight:bold">場地名稱</label>
	      					<jsp:useBean id="venueSvc" scope="page" class="com.venue.model.VenueService" />
	      					<select size="1" name="v_no" class="text-center form-control">
	      						<option value="">請選擇場地名稱
	      						<c:forEach var= "venueVO" items="${venueSvc.all}" >
	      							<option value="${venueVO.v_no }">${venueVO.v_name }
	      						</c:forEach>
							</select>
		      				
				      		<!-------- 活動日期查詢 --------->
			      			<label for="sg_date" style="font-weight:bold">活動日期</label>
	      					<input name="sg_date" id="sg_date" type="text"  class="text-center form-control" placeholder="請選擇日期">
			      			<!-------- 關鍵字查詢 --------->
		      				<label for="keyword" style="font-weight:bold">關鍵字查詢</label>
      						<input name="keyword" id="keyword" type="text" class="text-center form-control" placeholder="請輸入關鍵字">
			      			<!-------- 送出查詢 --------->
		      				<div class="text-center"  style="margin-top:10px;">
			      				<input type="hidden" name="action" value="sg_infoCompositeQuery">
			      				<input type="hidden" name="sg_per" value="公開">
			      				<input type="submit" value="送出查詢" class="btn btn-outline-success">
		      				</div>
						      			
				      	</form>
			      	</div>
	      		</div>
			</div> <!-- col-sm-3 -->
			
			
			
			<div class="col-sm-7 outer">
			
			<%@ include file="page1.file" %>
			<br>
			<c:forEach var="Sg_infoVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<!-- ---------------------------------------------------- -->
				<label for="${Sg_infoVO.sg_no}">
                    <!-- 	判斷時間是否正在揪團 -->
					<%pageContext.setAttribute("date", new Date());%>
					<c:if test="${Sg_infoVO.sg_date > date}">
					<div class="btn sg_infoList" style="background-color: white;border: 1px solid">
					</c:if>
					<c:if test="${Sg_infoVO.sg_date < date}">
					<div class="btn sg_infoList" style="background-color: #DDDDDD">
					</c:if>
						<div class="col-xs-12 col-sm-8 sg_picDiv">
							<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}" class="portrait img-responsive img-rounded">
						</div>
						<div class="col-xs-12 col-sm-4">
							<table class="table table-borderless" background="1" style="border-color:#FF0000">
								<thead >
									<tr>
										<th colspan="2" style="border-bottom: 2px solid #dee2e6;font-weight: bold;">
											<img src="<%= request.getContextPath()%>/img/sporticons/${Sg_infoVO.sp_no}.svg" style="width:20px; height:auto;">
											${Sg_infoVO.sg_name }
										</th>
									</tr>
								</thead>
								<tbody>
									<tr>
<!-- 										<td>團長:</td> -->
										<jsp:useBean id="memberlistSvc" scope="page" class="com.memberlist.model.MemberlistService"/>
										<td>
											<img src="<%= request.getContextPath()%>/img/sgmem.jpg" style="width:30px; height:auto; padding-right:5px">
											${memberlistSvc.getOneMem(Sg_infoVO.mem_no).mem_name}
										</td>
									</tr>
									<tr>
										<td>
											<img src="<%= request.getContextPath()%>/img/calendar.svg" style="width:30px; height:auto; padding-right:5px">
											<fmt:formatDate value="${Sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
									</tr>
									<tr>
										<td>
											<img src="<%= request.getContextPath()%>/img/time.svg" style="width:30px; height:auto; padding-right:5px">
											<fmt:formatDate value="${Sg_infoVO.apl_end}" pattern="yyyy-MM-dd"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</label>
            <!-- ---------------------- -->
					<form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do">
						<input type="hidden" name="sg_no" value="${Sg_infoVO.sg_no}">
						<input type="hidden" name="action" value="getByPK">
						<input type="submit" id="${Sg_infoVO.sg_no}"  style="display: none">
					</form>
			</c:forEach>
			<%List<Sg_infoVO> list2 = (List<Sg_infoVO>)request.getAttribute("list");%>
			<c:if test="<%=list2 == null%>">
				<%@ include file="page2.file" %>
			</c:if>
			<c:if test="<%=list2 != null%>">
				<%@ include file="page2_ByCompositeQuery.file" %>
			</c:if>



			</div>


		</div>
	</div>
<!-- Footer頁尾 -->
<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />



 <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<!-- Popper js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
<!-- Bootstrap js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
<!-- All Plugins js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
<!-- Active js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>




<script>

//設定地區選單動態顯示
$("#reg_name").change(function(){
	var dataStr = {};
	dataStr.action = "getReg_dist";
	dataStr.reg_name = $("#reg_name").val();
	
	$.ajax({
		type: "POST",
		url: "<%= request.getContextPath()%>/region/region.do",
		data: dataStr,
		dataType: "json",
		contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
		error: function(){
			alert("發生錯誤!");
		},
		success: function(data){
			$(".reg_distOption").remove();
			var reg_distArr = data.reg_dist.split(',');
			for(var i in reg_distArr){
				$("#reg_dist").after("<option class='reg_distOption' value='"+reg_distArr[i]+"'>"+reg_distArr[i]);
			}
		}
	});
	
});




//查詢活動日期表設定
	$.datetimepicker.setLocale('zh'); // kr ko ja en
	$('#sg_date').datetimepicker({
	   theme: '',          //theme: 'dark',
	   timepicker: false,   //timepicker: false,
	   format: 'Y-m-d',
// 	   value: new Date(),
	   minDate:           '-1970-01-01', // 去除今日(不含)之前
	});

</script>



<style type="text/css">
	#map {
        height: 550px;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
    }
    .sg_infoList{
    	display: flex;
    	justify-content: center;
    	align-items: center;

    	border-radius: 30px;
    	cursor: pointer;
    	box-shadow: 0 3px #999;
    	width:700px;
    	height:240px;
    }
    .sg_infoList:active {
	  	box-shadow: 0 1px #666;
	  	transform: translateY(1px);
	}
    .outer{
    	display: flex;
    	flex-direction: column;
    	flex-wrap: wrap;
    	align-items: center;
    }
	th{
		text-align:center;
	}
	select{
		width:100%;
		text-align: center;
    	text-align-last: center;
	}
	.panel-title{
		text-align: center;
    	text-align-last: center;
	}
	
	.sg_picDiv {
		position: relative;
		width: 50%;
		height: 200px;
		overflow: hidden;
		border-radius: 50px;
	  
		padding:0px;
		margin-top:auto;
		margin-bottom:auto;
	}
	.sg_picDiv img {
	  position: absolute;
	  left: 50%;
	  top: 50%;
	  height: 100%;
	  width: auto;
	  -webkit-transform: translate(-50%,-50%);
	      -ms-transform: translate(-50%,-50%);
	          transform: translate(-50%,-50%);
	}
	.sg_picDiv img.portrait {
	  width: 100%;
	  height: auto;
	}
	  
</style>





</body>
</html>