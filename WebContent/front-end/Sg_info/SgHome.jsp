<!-- 代辦事項 -->
<!-- 查詢功能servlet還沒寫 -->


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.sg_info.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.*"%>
    
<% 
	Sg_infoService svc = new Sg_infoService(); 
	List<Sg_infoVO> list = svc.getAll();
	pageContext.setAttribute("list",list);
%>

<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

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
    	background-color: lightpink;	
    }
    .sg_infoList:active {
	  	box-shadow: 0 1px #666;
	  	transform: translateY(1px);
	}
    .outer{
    	display: flex;
    	flex-direction: column;
    	flex-wrap: wrap;
    	justify-content: center;
    	align-items: center;
    }
    .img-responsive{
    	border-radius: 50px;
    }
    #lightBox{
	    position: fixed;
	    width: 100%;
	    height: 100%;
	    background: rgba(66,66,66,.6);
	}
	th{
		text-align:center;
	}
	select{
		width:100%;
		text-align: center;
    	text-align-last: center;
	}
	.sg_picDiv{
		padding:0px;
	}
	  
</style>



</head>
<body>


	<div class="container-fluid">
		<div class="row">

			<div class="col-xs-12 col-sm-4">
				
				<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
<!-------------------- 建立揪團區塊 ---------------------->
				  <div class="panel panel-info">
				    <div class="panel-heading" role="tab" id="panel1">
				      <h4 class="panel-title">
				          <a href="<%= request.getContextPath()%>/front-end/Sg_info/Sg_infoCreate.jsp">建立揪團</a>
				      </h4>
				    </div>
				  </div>
<!------------------------------------ 查詢區塊 ----------------------------------->
				  <div class="panel panel-info">
				    <div class="panel-heading" role="tab" id="panel2">
				      <h4 class="panel-title">
				        <a href="#bbb" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="bbb">
				          <div>揪團查詢</div>
				        </a>
				      </h4>
				    </div>
				    <div id="bbb" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel2">
				      <div class="panel-body">
				      	<form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do">
				      		<div class="table-responsive">
					      		<table class="table table-hover text-center" align="center">
					      			<thead >
					      			<!-------- 運動種類查詢 --------->
						      			<tr>
						      				<th>運動種類</th>
						      				<th>
						      				<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService" />
						      					<select size="1" name="sp_noSearch" class="text-center">
						      						<option value="null">請選擇運動種類
													<c:forEach var="sportVO" items="${sportSvc.all}" > 
														<option value="${sportVO.sp_no}">${sportVO.sp_name}
													</c:forEach>   
												</select>
						      				</th>
						      			</tr>
						      		<!-------- 場地名稱查詢 --------->
						      			<tr>
						      				<th>場地名稱</th>
						      				<th>
						      					<select size="1" name="v_noSearch" class="text-center">
						      						<option value="null">請選擇場地名稱
												</select>
						      				</th>
						      			</tr>
				      				<!-------- 地區查詢 --------->
						      			<tr>
						      				<th>地區</th>
						      				<th>
						      					<select size="1" name="reg_noSearch" class="text-center">
						      						<option value="null">請選擇地區
												</select>
						      				</th>
						      			</tr>
						      		<!-------- 活動日期查詢 --------->
						      			<tr>
						      				<th>活動日期</th>
						      				<th>
						      					<input name="sg_dateSearch" id="sg_dateSearch" type="text"  class="text-center" placeholder="請選擇日期">
						      				</th>
						      			</tr>
					      			<!-------- 關鍵字查詢 --------->
						      			<tr>
						      				<th>關鍵字</th>
						      				<th>
						      					<input name="keyWordSearch" id="keyWordSearch" type="text" class="text-center" placeholder="請輸入關鍵字">
						      				</th>
						      			</tr>
					      			<!-------- 送出查詢 --------->
						      			<tr>
						      				<td colspan="2"><input type="submit" value="送出查詢" class="btn btn-primary"></td>
						      			</tr>
						      			
					      			</thead >
					      		</table>
				      		</div>
				      	</form>
				      </div>
				    </div>
				  </div>
<!---------------------------- 區塊3 ------------------------------->
				  <div class="panel panel-info">
				    <div class="panel-heading" role="tab" id="panel3">
				      <h4 class="panel-title">
				        <a href="#ccc" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="ccc">
				          收合項目標題三
				        </a>
				      </h4>
				    </div>
				    <div id="ccc" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel3">
				      <div class="panel-body">
				        內容三置入在這裡
				      </div>
				    </div>
				  </div>
				</div>

			</div>
			
			
			
			<div class="col-xs-12 col-sm-8 outer">
			
			<%@ include file="page1.file" %>
			<br>
			<c:forEach var="Sg_infoVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			
				<label for="${Sg_infoVO.sg_no}">
					<div class="btn sg_infoList">
						<div class="col-xs-12 col-sm-6 sg_picDiv">
							<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}" class="sg_pic img-responsive img-rounded">
						</div>
						<div class="col-xs-12 col-sm-6">
							<table class="table table-hover text-center" >
								<thead >
									<tr>
										<th colspan="2" class="text-center">${Sg_infoVO.sg_name }</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>活動時間:</td>
										<td><fmt:formatDate value="${Sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/></td>
									</tr>
									<tr>
										<td>報名截止日:</td>
										<td><fmt:formatDate value="${Sg_infoVO.apl_end}" pattern="yyyy-MM-dd"/></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</label>
					<form method="post" action="<%= request.getContextPath()%>/Sg_info/Sg_info.do">
						<input type="hidden" name="sg_no" value="${Sg_infoVO.sg_no}">
						<input type="hidden" name="action" value="getByPK">
						<input type="submit" id="${Sg_infoVO.sg_no}"  style="display: none">
					</form>
			</c:forEach>
			<%@ include file="page2.file" %>



			</div>


		</div>
	</div>



<script>

//查詢活動日期表設定
	$.datetimepicker.setLocale('zh'); // kr ko ja en
	$('#sg_dateSearch').datetimepicker({
	   theme: '',          //theme: 'dark',
	   timepicker: false,   //timepicker: false,
	   format: 'Y-m-d',
// 	   value: new Date(),
	   minDate:           '-1970-01-01', // 去除今日(不含)之前
	});

</script>







</body>
</html>