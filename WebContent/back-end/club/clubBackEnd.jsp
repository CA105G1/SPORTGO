<%@page import="com.club_memberlist.model.Club_memberlistVO"%>
<%@page import="com.club_memberlist.model.Club_memberlistService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>
<%@ page import="com.club.model.*"%>
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
		#clubTable>thead:first-child>tr:first-child>th{
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
					<h1>社團專區</h1>
					
					<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" id="clubList" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">社團列表</a>
					        </li>
					        <li role="presentation" id="postList" class="">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">貼文列表</a>
					        </li>
					    </ul>
					
					    <div class="tab-content">
<!--------------------------------- 社團列表 -------------------------------------------->
					        <div role="tabpanel" class="tab-pane active" id="tab1">

<%
	
	ClubService svc = new ClubService();
	List<ClubVO> list = svc.getAll();
	pageContext.setAttribute("list",list);
	
// 	Club_memberlistService cmemsvc = new Club_memberlistService();
// 	List<Club_memberlistVO> cmemlist = cmemsvc.getAll();
// 	page.Context.setAttribute("cmemlist",cmemlist);
%>	
	
								<table id="clubTable" class="display" style="white-space: nowrap; text-align:center">
								    <thead>
								        <tr>
								            <th style="text-align:center">社團編號</th>
								            <th style="text-align:center">社團名稱</th>
								            <th style="text-align:center">運動種類</th>
								            <th style="text-align:center">社團狀態</th>
								            <th style="text-align:center">社團成員</th>
								            <th style="text-align:center">社團成員狀態</th>
								            <th style="text-align:center">社團成員類別</th>
								            <th style="text-align:center">社團簡介</th>
								        </tr>
								    </thead>
								    <tbody>
								    	<jsp:useBean id="sg_infoSvc" scope="page" class="com.sg_info.model.Sg_infoService"></jsp:useBean>
								    	<jsp:useBean id="memSvc" scope="page" class="com.memberlist.model.MemberlistService"></jsp:useBean>
								    	<jsp:useBean id="clubSvc" scope="page" class="com.club.model.ClubService"/>
								    	<jsp:useBean id="clubmemberlistSvc" scope="page" class="com.club_memberlist.model.Club_memberlistService"/>
								    	<jsp:useBean id="sportSvc" scope="page" class="com.sport.model.SportService"></jsp:useBean>
								    	<c:forEach var='clubVO' items='${list }'>
								    		<tr>
									            <td>${clubVO.club_no }</td>
									            <td>${clubVO.club_name }</td>
												<td>${sportSvc.getByPK(clubVO.sp_no).sp_name}</td>
									            <td>${clubVO.club_status }</td>
												<td>${memSvc.getOneMem(club_memberlistVO.mem_no).mem_name}</td>
									            <td>${club_memberlistVO.cmem_status}</td>
									            <td>${club_memberlistVO.cmem_class}</td>
									            <td>${clubVO.club_intro }</td>
								        	</tr>
								    	</c:forEach>
								    </tbody>
								</table>

					        </div>
<!---------------------------------- 貼文列表 ------------------------------------------------->
					        <div role="tabpanel" class="tab-pane" id="tab2">
					        	
								<table id="postTable" class="display" style="text-align:center">
								    <thead>
								        <tr>
								            <th style="text-align:center">貼文編號</th>
								            <th style="text-align:center">社團編號</th>
								            <th style="text-align:center">發布者</th>
								            <th style="text-align:center">貼文主題</th>
								            <th style="text-align:center">貼文內容</th>
								            <th style="text-align:center">發布時間</th>
								            <th style="text-align:center">回覆編號</th>
								            <th style="text-align:center">回覆內容</th>
								            <th style="text-align:center">回覆時間</th>
								        </tr>
								    </thead>
								    <tbody>
								    	<jsp:useBean id="post_infoSvc" scope="page" class="com.post_info.model.Post_infoService"/>
								    	<jsp:useBean id="responesSvc" scope="page" class="com.respones.model.ResponesService"/>
								    	<c:forEach var='post_infoVO' items='${post_infoSvc.all }'>
								    	
								    		<tr>
									            <td>${post_infoVO.post_no }</td>
									            <td>${post_infoVO.club_no }</td>
									            <td>${memSvc.getOneMem(post_infoVO.mem_no).mem_name}</td>
									            <td>${post_infoVO.post_topic }</td>
									            <td>${post_infoVO.post_content }</td>
									            <td>${post_infoVO.post_date }</td>
												<td>${post_infoSvc.getOnePost_info(responesVO.post_no).post_no}</td><!-- res_no -->
												<td>${post_infoSvc.getOnePost_info(responesVO.post_no).post_no}</td>
<%-- 									        <td>${responesVO.res_no}</td> --%>
									            <td>${responesVO.res_content }</td>
									            <td>${responesVO.res_date }</td>
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
	//設定旗標用來回到原本的頁籤
	var flag = localStorage.getItem('isBackForRep');
	if(flag == 'true'){
		$("#postList").addClass("active");
    	$("#clubList").removeClass("active");
    	$("#tab2").addClass("active");
    	$("#tab1").removeClass("active");
		localStorage.setItem('isBackForRep', false);
	}
	
	$("#checkBtn").click(function(){
		localStorage.setItem('isBackForRep', true);
	});
	
	
	
    $('#clubTable').DataTable({
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
    
    
    $('#postTable').DataTable({
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