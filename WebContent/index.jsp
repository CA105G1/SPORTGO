<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>CA105G1:SportyGo!</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style>
		
		
		</style>
		
		
	</head>
	<body>
		<%-- header目前尚缺連結點 --%>
		<%@ include file="front-end/CA105G1_header.file" %>

		<%-- 最新消息---跑馬燈 --%>
		<div class="container-fluid">
			<div id="carousel-id" class="carousel slide" data-ride="carousel">
			    <!-- 幻燈片小圓點區 -->
			    <ol class="carousel-indicators">
			        <li data-target="#carousel-id" data-slide-to="0" class=""></li>
			        <li data-target="#carousel-id" data-slide-to="1" class=""></li>
			        <li data-target="#carousel-id" data-slide-to="2" class="active"></li>
			    </ol>
			    <!-- 幻燈片主圖區 -->
			    <div class="carousel-inner">
			        <div class="item">
			            <img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
			            <div class="container">
			                <div class="carousel-caption">
			                    <h1>CSS可樂好喝超爽快</h1>
			                    <p>你喝過了嗎？</p>
			                    <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
			                </div>
			            </div>
			        </div>
			        <div class="item">
			            <img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
			            <div class="container">
			                <div class="carousel-caption">
			                    <h1>CSS可樂的外掛真方便</h1>
			                    <p>你安裝了嗎？</p>
			                    <p><a class="btn btn-lg btn-primary" href="#" role="button">更多</a></p>
			                </div>
			            </div>
			        </div>
			        <div class="item active">
			            <img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
			            <div class="container">
			                <div class="carousel-caption">
			                    <h1>我是標題喔～自己改文案吧</h1>
			                    <p>我是內文喔，你可以把字打在這裡呦</p>
			                    <p><a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a></p>
			                </div>
			            </div>
			        </div>
			    </div>
			    <!-- 上下頁控制區 -->
			    <a class="left carousel-control" href="#carousel-id" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
			    <a class="right carousel-control" href="#carousel-id" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
			</div>
		</div>
		<%-- 推薦揪團區 --%>
		<%-- 左側MAP --%>
		<%-- 右側推薦揪團列表 --%>

		<%-- 各個運動連結 --%>
		<div class="container-fluid">
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP001.jpg">
						<img src="img/indexImg/SP001.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="https://www.youtube.com/watch?v=oY2nVQNlUB8">
						<img src="img/indexImg/fun01.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/fun03.jpg">
						<img src="img/indexImg/fun03.jpg" class="img-responsive img-rounded"/>
					</a>					
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP004.jpg">
						<img src="img/indexImg/SP004.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP005.png">
					<img src="img/indexImg/SP005.png" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/indexImg/SP006.jpg">
					<img src="img/indexImg/SP006.jpg" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/no-image.PNG">
					<img src="img/no-image.PNG" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
			<div>
				<div class="col-xs-12 col-sm-3">
					<a href="img/no-image.PNG">
						<img src="img/no-image.PNG" class="img-responsive img-rounded"/>
					</a>
				</div>
			</div>
		</div>
		
		<%-- footer目前尚缺連結點 --%>
		<%@ include file="front-end/CA105G1_footer.file" %>
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>