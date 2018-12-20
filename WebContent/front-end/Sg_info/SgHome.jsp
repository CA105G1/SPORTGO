<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.sg_info.model.*"%>
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

<style type="text/css">
	#map {
        height: 550px;  /* The height is 400 pixels */
        width: 100%;  /* The width is the width of the web page */
    }
    .inner{
    	display: flex;
    	
    	justify-content: center;
    	align-items: center;

    	border-radius: 30px;
    	cursor: pointer;
    	box-shadow: 0 3px #999;	
    }
    .inner:active {
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
	  
</style>



</head>
<body>


	<div class="container-fluid">
		<div class="row">

			<div class="col-xs-12 col-sm-4">
				
				<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
				  <!-- 區塊1 -->
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="panel1">
				      <h4 class="panel-title">
				        <a href="#aaa" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="aaa">
				          收合項目標題一
				        </a>
				      </h4>
				    </div>
				    <div id="aaa" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="panel1">
				      <div class="panel-body">
				        <a href="Sg_infoCreate.jsp">建立揪團</a>
				      </div>
				    </div>
				  </div>
				  <!-- 區塊2 -->
				  <div class="panel panel-default">
				    <div class="panel-heading" role="tab" id="panel2">
				      <h4 class="panel-title">
				        <a href="#bbb" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="bbb">
				          收合項目標題二
				        </a>
				      </h4>
				    </div>
				    <div id="bbb" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel2">
				      <div class="panel-body">
				        內容二置入在這裡
				      </div>
				    </div>
				  </div>
				  <!-- 區塊3 -->
				  <div class="panel panel-default">
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
					<div class="btn inner" style="background-color: lightpink">
						<div class="col-xs-12 col-sm-6" style="padding:0px">
							<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${Sg_infoVO.sg_no}" class="img-responsive img-rounded">
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
										<td>${Sg_infoVO.sg_date }</td>
									</tr>
									<tr>
										<td>報名截止日:</td>
										<td>${Sg_infoVO.apl_end }</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</label>
					<form method="get" action="Sg_info.do">
						<input type="hidden" name="sg_no" value="${Sg_infoVO.sg_no}">
						<input type="hidden" name="action" value="getByPK">
						<input type="submit" id="${Sg_infoVO.sg_no}"  style="display: none">
					</form>
			</c:forEach>
			<%@ include file="page2.file" %>



			</div>


		</div>
	</div>



	








</body>
</html>