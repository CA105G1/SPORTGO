<%@page import="java.util.*"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="com.product.model.ProductService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
session.setAttribute("mem_no","M001");
	ProductService proSvc = new ProductService();
	List<ProductVO> list = new ArrayList<ProductVO>();
	if ("findBy".equals(request.getAttribute("findBy"))) {
		list = (List<ProductVO>) request.getAttribute("pro_ByCompositeQuery");
	} else {
		list = proSvc.getAll();
	}
    pageContext.setAttribute("list",list);

%>

<jsp:useBean id="proclassSvc" scope="page" class="com.productclass.model.ProductClassService" />
<!DOCTYPE html> 
<html lang="">

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>商城</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	<style type="text/css">
		.aa {
			height: 300px;
			background-color: #faa;
		}

		.bb {
			height: 300px;
			background-color: #afa;
		}

		.cc {
			height: 300px;
			background-color: #aaf;
		}

		.dd {
			height: 300px;
			background-color: #aaa;
		}

		.test {
			background-color: #aba;
		}
         .img-responsive {
			width: 100%;
			max-width: 400px;
		}
		.prosize{

		}
		td{
			width: 277px;
			height: 400px;
			vertical-align: text-top; /*內容置上*/
			padding: 8px;  /*td間距*/
			float:left;  /*可以不設tr*/
		}
		table{
			/*margin-left:auto; 
			margin-right:auto;*/
			width: 1109px;

		}
/*div超過高度隱藏*/
/*.divtest {
table-layout: fixed;
word-wrap: break-word;
width: 284px;
height: 400px;
overflow: hidden;    
}*/
/*.star {
	width:500px;
	border:1px solid #ccc;
	padding:20px;
	margin:50px auto;
}*/
		.s-txt {
			/*float:left;*/

		}
		.s-xxs {
			display:inline-block;
			vertical-align:middle;
		}
		.s-xx { 
			float:left;
			color:#e3e3e3;
			padding-right:8px;
			cursor:pointer;
			font-size: 25px;
			vertical-align:middle;
		}
		/*外框*/
		.s-haoping {
			color:#f13a3a;
			border:1px solid #f13a3a;
			padding:2px 4px;
			font-size:12px;
			vertical-align:middle;
			position:relative;
			display:none;
		}
		/*外框*/
		.s-haoping .s-hp-triangle0 {
			border-width:4px;
			position:absolute;
			top:5px;
			left:-8px;
			border-color:transparent #f13a3a transparent transparent;
			border-style:dashed solid dashed dashed;
		}
		/*外框*/
		.s-haoping .s-hp-triangle1 {
			border-width:4px;
			position:absolute;
			top:5px;
			left:-7px;
			border-color:transparent  #f8f8f8 transparent transparent;
			border-style:dashed solid dashed dashed;
		}
		.divStyle{
            border-bottom: 1px dotted #c8cbcc;
		}
		/*星星顏色*/
		.color-f13a3a {
			color:#f13a3a;
		}

	</style>
</head>
<body>

	<div class="container-fluid">
		<div class="row">

			<!-- navbar -->
				<nav class="navbar navbar-default" role="navigation">
					<div class="container">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
								<span class="sr-only">選單切換</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
							<a class="navbar-brand" href="#">CSS可樂</a>
						</div>

						<!-- 手機隱藏選單區 -->
						<div class="collapse navbar-collapse navbar-ex1-collapse">
							<!-- 左選單 -->
							<ul class="nav navbar-nav">
								<li class="active">
									<a href="#">關於CSS可樂</a>
								</li>
								<li>
									<a href="#">CSS教學</a>
								</li>
								<li>
									<a href="#">CSS範例</a>
								</li>
								<li>
									<a href="#">原創CSS</a>
								</li>
							</ul>

							<!-- 搜尋表單 -->
							<form class="navbar-form navbar-left" role="search">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="請輸入關鍵字">
								</div>
								<button type="submit" class="btn btn-default">搜尋</button>
							</form>

							<!-- 右選單 -->
							<ul class="nav navbar-nav navbar-right">
								<li>
									<a href="#">Amos 您好</a>
								</li>
								<li>
									<a href="#">登出</a>
								</li>
								<li>
									<a href="#">個人設定</a>
								</li>
								<li class="dropdown">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown">繁體中文
										<b class="caret"></b>
									</a>
									<ul class="dropdown-menu">
										<li>
											<a href="#">繁體中文</a>
										</li>
										<li>
											<a href="#">English</a>
										</li>
										<li>
											<a href="#">日本語</a>
										</li>
									</ul>
								</li>
							</ul>
						</div>
						<!-- 手機隱藏選單區結束 -->
					</div>
				</nav>
			<!-- 幻燈片 -->
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
									<p>
										<a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a>
									</p>
								</div>
							</div>
						</div>
						<div class="item">
							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
							<div class="container">
								<div class="carousel-caption">
									<h1>CSS可樂的外掛真方便</h1>
									<p>你安裝了嗎？</p>
									<p>
										<a class="btn btn-lg btn-primary" href="#" role="button">更多</a>
									</p>
								</div>
							</div>
						</div>
						<div class="item active">
							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
							<div class="container">
								<div class="carousel-caption">
									<h1>我是標題喔～自己改文案吧</h1>
									<p>我是內文喔，你可以把字打在這裡呦</p>
									<p>
										<a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a>
									</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 上下頁控制區 -->
					<a class="left carousel-control" href="#carousel-id" data-slide="prev">
						<span class="glyphicon glyphicon-chevron-left"></span>
					</a>
					<a class="right carousel-control" href="#carousel-id" data-slide="next">
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>
				</div>

			<br>

			<!-- 大區容器 -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-xs-12 col-sm-1"></div>
						<!-- 複合查詢 -->
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
								<div class="col-xs-12 col-sm-2 aa">
									<ul class="list-group">
										<li class="list-group-item">
											<div>
												商品編號
											</div>
											<div>
												<input type="text" name="pro_no">
											</div>
										</li>
										<li class="list-group-item">
											商品類別編號
										    <select size="1" name="pro_classid" class="form-control">
											    
										          <option value="">
										         <c:forEach var="proclassVO" items="${proclassSvc.all}" > 
										          <option value="${proclassVO.pro_classid}">${proclassVO.pro_classname}
										         </c:forEach>   
										       
										    </select>
										</li>
										<li class="list-group-item">
											<div>
												商品名稱
											</div>
											<div>
												<input type="text" name="pro_name">
											</div>
										</li>
										<li class="list-group-item">
											<div>
												商品單價
											</div>
											<div>
												<input type="text" name="pro_bonus">
											</div>
										</li>
									</ul>
										 <input type="submit" value="送出">
										 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
										 <input type="hidden" name="action" value="pro_ByCompositeQuery">
								</div>
							</FORM>
		                
		                <!-- 右邊區域 -->
							<div class="col-xs-12 col-sm-9 prosize" >
								<!-- 麵包屑 -->
									<ol class="breadcrumb test">
										<li>
											<a href="#">首頁</a>
										</li>
										<li>
											<a href="#">最新消息</a>
										</li>
										<li class="active">媽我上電視了</li>
									</ol>
								<!-- 商品列表 -->
								<%@ include file="page/page1_ByCompositeQuery.file" %>
									    <table tablesize>
									    	<tbody>
									    		<tr>
									    			<c:forEach var="proVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
										    			<td>
															<div class="w3-card-4" style="width:250px">
														    	<img class="img-responsive" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proVO.pro_no}">
														    	<div class="w3-container w3-center">
														       		<div class="divStyle"> ${proVO.pro_name}</div>
														       		<div>${proVO.pro_bonus}</div>
														       		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
																		<input type="submit" value="詳情">
																		<input type="hidden" name="pro_no" value="${proVO.pro_no}">
																		<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
																		<%= request.getParameter("requestURL") %>
																		<input type="hidden" name="action" value="getOne_For_Display">
																	</FORM>
														    	</div>
														    </div>
										    			</td>
									    			</c:forEach>
									    		</tr>
									    	</tbody>
									    </table>
									    <%@ include file="page/page2_ByCompositeQuery.file" %>
	                        </div>



                
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	
$(function() {
    var isclick = false;
    var arr = ["1分差評", "2分中評", "3分中評", "4分好評", "5分好評"];
    var clickind = -1;

    $(".s-xx").on("click", function() {
        isclick = true;
        clickind = $(this).index();
    });
    $(".s-xx").hover(function() {
        var ind = $(this).index();
        $(".s-xx").removeClass("color-f13a3a");
        for (var i = 0; i <= ind; i++) {
            $(".s-xx").eq(i).addClass("color-f13a3a");
            $(".s-haoping").find(".s-hp-txt").text(arr[i]).end().show();
        }
    }, function() {
        if (!isclick) {
            $(".s-xx").removeClass("color-f13a3a");
            $(".s-haoping").hide();
        } else {
            $(".s-xx").removeClass("color-f13a3a");
            for (var i = 0; i <= clickind; i++) {
                $(".s-xx").eq(i).addClass("color-f13a3a");
                $(".s-haoping").find(".s-hp-txt").text(arr[i]).end().show();
            }
        }
    });
});

</script>

</body>

</html>