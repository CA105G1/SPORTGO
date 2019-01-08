<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTYGO!</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<style>
		</style>
	</head>
	<body>
		<%-- include header --%>
<%-- 		<%@ include file="/back-end/CA105G1_header_back.file" %> --%>
		<%-- include show_loginBox --%>
<%-- 		<%@ include file="/back-end/emp/loginfile/showLoginBackEnd.file" %> --%>
		
<%-- 如果反映有問題，再處理使用這方式	<jsp:include page="XXXX.jsp" /> --%>
		
		<jsp:include page="/back-end/CA105G1_header_back.jsp"/>
		
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
					        	<h1>標題一內容</h1>
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
	</body>
</html>