<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>
<%@page import="com.sg_info.model.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTYGO!</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<style>
		input{
			height:30px
		}
		</style>
	</head>
	<body>
		<%-- include header --%>
		<%@ include file="/back-end/CA105G1_header_back.file" %>
		<%-- include show_loginBox--%>
		<%@ include file="/back-end/emp/loginfile/showLoginBackEnd.file" %>
		
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
<!-- <h1>後台共用區</h1> -->
<!-- <h2>here need include left_side_field.jsp</h2> -->
					<jsp:include page="/back-end/left_side_field.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9">
					<h1>後台內容，使用tabs，也可自由發揮</h1>
					
					<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">標題一</a>
					        </li>
					        <li role="presentation" class="">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">標題二</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">標題三</a>
					        </li>
					    </ul>
					
			<!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					        <div role="tabpanel" class="tab-pane active" id="tab1">

<%
	Sg_infoService svc = new Sg_infoService();
	List<Sg_infoVO> list = svc.getAll();
	pageContext.setAttribute("list",list);
%>
	
<table id="table_id" class="display" style="white-space: nowrap; ">
    <thead>
        <tr>
            <th>揪團編號</th>
            <th>揪團名稱</th>
            <th>團長</th>
            <th>活動時間</th>
            <th>報名截止日</th>
            <th>報名費用</th>
            <th>權限</th>
            <th>運動種類</th>
            <th>場地名稱</th>
            <th>人數限制</th>
            <th>報名人數</th>
            <th>報到人數</th>
            <th>團長的話</th>
            <th>狀態</th>
        </tr>
    </thead>
    <tbody>
    	<jsp:useBean id="sg_infoSvc" scope="page" class="com.sg_info.model.Sg_infoService"></jsp:useBean>
    	<c:forEach var='sg_infoVO' items='${sg_infoSvc.all }'>
    		<tr>
	            <td>${sg_infoVO.sg_no }</td>
	            <td>${sg_infoVO.sg_name }</td>
	            <td>${sg_infoVO.mem_no }</td>
	            <td>${sg_infoVO.sg_date }</td>
	            <td>${sg_infoVO.apl_end }</td>
	            <td>${sg_infoVO.sg_fee }</td>
	            <td>${sg_infoVO.sg_per }</td>
	            <td>${sg_infoVO.sp_no }</td>
	            <td>${sg_infoVO.v_no }</td>
	            <td>${sg_infoVO.sg_minno }-${sg_infoVO.sg_maxno }人</td>
	            <td>${sg_infoVO.sg_ttlapl }</td>
	            <td>${sg_infoVO.sg_chkno }</td>
	            <td>${sg_infoVO.sg_extrainfo }</td>
	            <td>${sg_infoVO.sg_status }</td>
        	</tr>
    	</c:forEach>
    </tbody>
</table>

					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab2">
					        	<h1>標題二內容</h1>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab3">
					        	<h1>標題三內容</h1>
					        </div>
					    </div>
					</div>
					
					
				</div>
			</div>
		</div>



		<%@ include file="/back-end/CA105G1_footer_back.file" %>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/plug-ins/1.10.19/api/page.jumpToData().js"></script>		
		<script>
		$(document).ready( function () {
		    $('#table_id').DataTable({
		    	"scrollX": true,
		    	"autoWidth": false,
		    	"lengthMenu": [5,10,15,20,100],
		    	"oLanguage": {
		    	      "sSearch": "搜尋",
		    	      "sLengthMenu": "每頁顯示 _MENU_ 筆資料",
		    	      "sZeroRecords": "無資料",
		    	      "sInfo": "從 _START_ 到 _END_ /共 _TOTAL_ 筆資料",
		    	      "sInfoEmpty": "無資料",
		    	      "sInfoFiltered": "(從 _MAX_ 筆資料中搜尋)",
		    	      "oPaginate": {
		    	        "sFirst": "第一頁",
		    	        "sPrevious": "前一頁",
		    	        "sNext": "下一頁",
		    	        "sLast": "最後一頁"
		    	        }
		    	},
		    	"sProcessing": "正在載入資料...",
		      	"sZeroRecords": "沒有找到資料"
			});

		    
		} );
		
		</script>
		
		
	</body>
</html>