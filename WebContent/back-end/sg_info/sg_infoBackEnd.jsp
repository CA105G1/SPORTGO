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
		#sg_infoTable>thead:first-child>tr:first-child>th{
        text-align:center;
		}
		
		</style>
	</head>
	<body>
		<%-- include header --%>
		<jsp:include page="/back-end/CA105G1_header_back.jsp"/>
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
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">揪團列表</a>
					        </li>
					        <li role="presentation" class="">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">檢舉列表</a>
					        </li>
					    </ul>
					
					    <div class="tab-content">
<!--------------------------------- 揪團列表 -------------------------------------------->
					        <div role="tabpanel" class="tab-pane active" id="tab1">

<%
	Sg_infoService svc = new Sg_infoService();
	List<Sg_infoVO> list = svc.getAll();
	pageContext.setAttribute("list",list);
%>
	
<table id="sg_infoTable" class="display" style="white-space: nowrap; text-align:center">
    <thead>
        <tr>
            <th style="text-align:center">揪團編號</th>
            <th style="text-align:center">揪團名稱</th>
            <th style="text-align:center">團長</th>
            <th style="text-align:center">活動時間</th>
            <th style="text-align:center">報名截止日</th>
            <th style="text-align:center">報名費用</th>
            <th style="text-align:center">權限</th>
            <th style="text-align:center">社團名稱</th>
            <th style="text-align:center">運動種類</th>
            <th style="text-align:center">場地名稱</th>
            <th style="text-align:center">人數限制</th>
            <th style="text-align:center">報名人數</th>
            <th style="text-align:center">報到人數</th>
            <th style="text-align:center">狀態</th>
            <th style="text-align:center">團長的話</th>
        </tr>
    </thead>
    <tbody>
    	<jsp:useBean id="sg_infoSvc" scope="page" class="com.sg_info.model.Sg_infoService"></jsp:useBean>
    	<jsp:useBean id="memSvc" scope="page" class="com.memberlist.model.MemberlistService"></jsp:useBean>
    	<jsp:useBean id="clubSvc" scope="page" class="com.club.model.ClubService"/>
    	<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService"></jsp:useBean>
    	<jsp:useBean id="venueSvc" scope="page" class="com.venue.model.VenueService"></jsp:useBean>
    	<c:forEach var='sg_infoVO' items='${sg_infoSvc.all }'>
    		<tr>
	            <td>${sg_infoVO.sg_no }</td>
	            <td>${sg_infoVO.sg_name }</td>
	            <td>${memSvc.getOneMem(sg_infoVO.mem_no).mem_name}</td>
	            <td><fmt:formatDate value="${sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/></td>
	            <td><fmt:formatDate value="${sg_infoVO.apl_end}" pattern="yyyy-MM-dd"/></td>
	            <td>${sg_infoVO.sg_fee }</td>
	            <td>${sg_infoVO.sg_per }</td>
	            <td>${clubSvc.getOneClub(sg_infoVO.club_no).club_name}</td>
	            <td>${sportSvc.getByPK(sg_infoVO.sp_no).sp_name }</td>
	            <td>${venueSvc.getOneVenue(sg_infoVO.v_no).v_name }</td>
	            <td>${sg_infoVO.sg_minno }-${sg_infoVO.sg_maxno }人</td>
	            <td>${sg_infoVO.sg_ttlapl }</td>
	            <td>${sg_infoVO.sg_chkno }</td>
	            <td>${sg_infoVO.sg_status }</td>
	            <td>${sg_infoVO.sg_extrainfo }</td>
        	</tr>
    	</c:forEach>
    </tbody>
</table>

					        </div>
<!---------------------------------- 檢舉列表 ------------------------------------------------->
					        <div role="tabpanel" class="tab-pane" id="tab2">
					        	
<table id="sg_repTable" class="display" style="text-align:center">
    <thead>
        <tr>
            <th style="text-align:center">檢舉編號</th>
            <th style="text-align:center">揪團名稱</th>
            <th style="text-align:center">揪團狀態</th>
            <th style="text-align:center">檢舉人</th>
            <th style="text-align:center">檢舉類型</th>
            <th style="text-align:center">說明</th>
            <th style="text-align:center">審核狀態</th>
            <th style="text-align:center">頁面內容</th>
        </tr>
    </thead>
    <tbody>
    	<jsp:useBean id="sg_repSvc" scope="page" class="com.sg_rep.model.Sg_repService"></jsp:useBean>
    	<c:forEach var='sg_repVO' items='${sg_repSvc.all }'>
    		<tr>
	            <td>${sg_repVO.rep_no }</td>
	            <td>${sg_infoSvc.GetByPK(sg_repVO.sg_no).sg_name}</td>
	            <td>${sg_infoSvc.GetByPK(sg_repVO.sg_no).sg_status}</td>
	            <td>${memSvc.getOneMem(sg_repVO.mem_no).mem_name}</td>
	            <td>${sg_repVO.rep_type }</td>
	            <td>${sg_repVO.rep_cont }</td>
	            <td>${sg_repVO.rep_status }</td>
	            <td><a href="Sg_infoGetByPkForRep.jsp?sg_no=${sg_repVO.sg_no}&rep_no=${sg_repVO.rep_no }"  class="btn btn-info">查看</a></td>
        	</tr>
    	</c:forEach>
    </tbody>
</table>
					        	
					        </div>
					        
					        
					    </div>  <!-- tab-content -->
					</div> <!-- tabpanel -->
					
					
				</div> <!-- col-xs-12 col-sm-9 -->
			</div> <!-- row -->
		</div> <!-- container-fluid -->



		<%@ include file="/back-end/CA105G1_footer_back.file" %>
		
		
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/plug-ins/1.10.19/api/page.jumpToData().js"></script>		
		<script>
		$(document).ready( function () {
		    $('#sg_infoTable').DataTable({
		    	"scrollX": true,
		    	"autoWidth": false,
		    	"lengthMenu": [10,15,20,100],
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
		    
		    
		    $('#sg_repTable').DataTable({
		    	"lengthMenu": [10,15,20,100],
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