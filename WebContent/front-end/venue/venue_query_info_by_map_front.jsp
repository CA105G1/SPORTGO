<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>SPORTGO:Front-venue-select</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<style>
		input{
			height:30px
		}
		.label-text{
			font-size:1.3em;
		}
		</style>
		
		
	</head>
	<body>
		<jsp:include page="/front-end/CA105G1_header.jsp" />
		
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-1">
					<!--留白-->
				</div>
				<div class="col-xs-12 col-sm-10">
					<!-- 連結到各分頁上 -->
					<div class="row">
						
						<div class="col-xs-12 col-sm-6">
							<a href="<%=request.getContextPath()%>/front-end/venue/venue_query_info_by_composite_front.jsp" 
							class="btn btn-success btn-block">一般詳細查詢</a>
						</div>
						
						<div class="col-xs-12 col-sm-6">
							<a href="<%=request.getContextPath()%>/front-end/venue/venue_query_info_by_map_front.jsp" 
							class="btn btn-success btn-block"> 地圖查詢</a>
						</div>
					</div>
					<div class="row">
						
						<div class="h1 center-block">
						<h1>venue_query_info_by_map_front</h1>
							各主頁的內容
						</div>

					</div>
					<div class="row">
						<div class="h1 center-block">
							
							結果回傳區

						</div>
					</div>
				</div>
				<div class="col-xs-12 col-sm-1">
					<!--留白-->
				</div>
			</div>
		</div>
		
		
		
		
		
		<jsp:include page="/front-end/CA105G1_footer.jsp" />
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>