<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
		.panel-heading{
			background-color: #F0FFFF;
		}
		</style>
		
	</head>
	<body>
		<div class="panel panel-info">
			<div class="panel-heading">
				<img src="https://api.fnkr.net/testimg/350x100/00CED1/FFF/?text=backEndIndex" class="img-responsive img-rounded">
			</div>

			<div style="height: 15px"></div>
			
			<!--後台管理員區-->
			<div class="myGroup">
				<div class="panel-heading">
			    	<h3 class="panel-title">
			    		<a role="button" data-toggle="collapse" href="#adminiBack" aria-expanded="false" aria-controls="adminiBack">
							管理員專區
						</a>
			    	</h3>
			  	</div>
			    <div class="panel-collapse collapse" id="adminiBack">
					<div class="list-group">
						<a href="#" class="list-group-item">新增管理員</a>
						<a href="#" class="list-group-item">管理員列表</a>
						<a href="#" class="list-group-item">會員列表</a>
					</div>
				</div>
			</div>

			<!--後台揪團專區-->
			<div class="myGroup">
				<div class="panel-heading">
			    	<h3 class="panel-title">
			    		<a  role="button" data-toggle="collapse" href="#sgBack" aria-expanded="false" aria-controls="sgBack">
							揪團專區
						</a>
			    	</h3>
			  	</div>
			    <div class="panel-collapse collapse" id="sgBack">
					<div class="list-group">
						<a href="#" class="list-group-item">揪團列表</a>
						<a href="#" class="list-group-item">揪團檢舉列表</a>
					</div>
				</div>
			</div>

			<!--後台社團專區-->
			<div class="myGroup">
				<div class="panel-heading">
			    	<h3 class="panel-title">
			    		<a role="button" data-toggle="collapse" href="#clubBack" aria-expanded="false" aria-controls="clubBack">
							社團專區
						</a>
			    	</h3>
			  	</div>
			    <div class="panel-collapse collapse" id="clubBack">
					<div class="list-group">
						<a href="#" class="list-group-item">社團列表</a>
					</div>
				</div>
			</div>
			
			<!--後台商城管理-->
			<div class="myGroup">
				<div class="panel-heading">
			    	<h3 class="panel-title">
			    		<a  role="button" data-toggle="collapse" href="#shopBack" aria-expanded="false" aria-controls="shopBack">
							商城管理
						</a>
			    	</h3>
			  	</div>
			    <div class="panel-collapse collapse" id="shopBack">
					<div class="list-group">
						<a href="#" class="list-group-item">新增商品</a>
						<a href="#" class="list-group-item">新增商品類別</a>
						<a href="#" class="list-group-item">商品列表</a>
						<a href="#" class="list-group-item">商品類別列表</a>
						<a href="#" class="list-group-item">訂單列表</a>
					</div>
				</div>
			</div>

			<!--後台資訊維護-->
			<div class="myGroup">
				<div class="panel-heading">
			    	<h3 class="panel-title">
			    		<a  role="button" data-toggle="collapse" href="#informatinBack" aria-expanded="false" aria-controls="informatinBack">
							資訊維護
						</a>
			    	</h3>
			  	</div>
			    <div class="panel-collapse collapse" id="informatinBack">
					<div class="list-group">
						<a href="<%=request.getContextPath()%>/back-end/venue/maintain_venue_Info_Index_back.jsp" class="list-group-item">維護場地資訊</a>
						<a href="#" class="list-group-item">維護賽事資訊</a>
						<a href="#" class="list-group-item">最新消息管理</a>
					</div>
				</div>
			</div>

		</div>
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		
		<script type="text/javascript">
			$(".panel-heading").parent('.myGroup').on( "mouseenter",
			  function() {
			    $(this).children('.collapse').collapse('show');
			    $(this).animate({fontSize:'1.8em'},'slow');
			  }
// 			  , function() {
// 			    $(this).children('.collapse').collapse('hide');
// 			  }
			);
			
		</script>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- 
		<script type="text/javascript">
			$(".panel-heading").parent('.panel').hover(
			  function() {
			    $(this).children('.collapse').collapse('show');
			  }, function() {
			    $(this).children('.collapse').collapse('hide');
			  }
			);
		</script> -->

	</body>
</html>