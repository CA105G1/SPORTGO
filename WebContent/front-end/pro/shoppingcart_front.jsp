<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	List<ProductVO> proVOList = (List<ProductVO>) request.getAttribute("proVOList");
// 	Map<String , String> pro_countMap = (Map<String , String>) request.getAttribute("hAll");
    

%>
<jsp:useBean id="proclassSvc" scope="page" class="com.productclass.model.ProductClassService" />
<!DOCTYPE html> 
<html lang="">

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>購物車</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<!--[if lt IE 9]>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	<style type="text/css">
		.aa {
			background-color: #faa;
		}
		.bb {
			background-color: #afa;
		}
		.cc {
			background-color: #aaf;
		}
		.dd {
		    background-color: #aaa;
		}

		.ee {
			background-color: #0f5;
		}

		.ff {
			background-color: #E4D10F;
		}

		.dropdown-menu li:hover .sub-menu {
			/*碰到navbar會下拉*/
			visibility: visible;
		}

		.dropdown:hover .dropdown-menu {
			/*碰到navbar會下拉*/
			display: block;
		}

		.backgc {
			/*背景底色*/
			background-color: #F6F6F6;
		}

		.navsize {
			/*navbar寬度大小*/
			width: 1200px;
		}

		.warp {
			/*商品內頁*/
			box-shadow: 0 0.2rem 0.4rem rgba(0, 0, 0, .09);
			background-color: rgb(252, 252, 253);
			padding: 20px 48px;
			width: 1200px;
			margin: auto;

		}

		.warpwidth {
			/*商品內頁大小*/
			width: 1104px;
		}

		.fontsize {
			/*文字標籤*/
			font-size: 18px;
			font-weight: 400;
			color: #000;
			margin: 30px 0 15px;
			text-align: left;
		}

		.fontsize_s {
			/*文字內容標籤*/
			min-height: 40px;
			color: #666;
		}

		.valuesize {
			/*value標籤*/
			min-height: 40px;
		}
		.checkboxsize{
			/*選取方塊間隔大小*/
			width: 58px;
		}

		.buttonsize {
			/*按鈕大小*/
			text-align: center;
		}

		.tablebgc {
			background-color: #F7F5F5;
		}

		.thwidth {
			/*商品名稱圖片大小*/
			width: 250px;
		}

		table {
			border-collapse: separate;
			border-spacing: 0 0.5rem;
		}

		th {
			text-align: center;
		}

		td {
			text-align: center;
		}
		.imgsize {
			width: 80px;
			height: auto;
			float: left;
		}
		.pagecenter{
            text-align: center;
		}
		.divAdd{
			/*按鈕add靠右*/
		}
		</style>
	</head>

	<body>

		<div class="container-fluid backgc">
			<div class="row">

				<!-- navbar -->
				<div class="container-fluid ">
					<div class="row">
						<nav class="navbar navbar-default" role="navigation">
							<div class="container">
								<div class="navbar-header">
									<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
										<span class="sr-only">選單切換</span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
										<span class="icon-bar"></span>
									</button>
									<a class="navbar-brand" href="#">SPORTGO</a>
								</div>

								<!-- 手機隱藏選單區 -->
								<div class="collapse navbar-collapse navbar-ex1-collapse ">
									<!-- 左選單 -->
									<ul class="nav navbar-nav">
										<li class="active">
											<a href="#">我的商品</a>
										</li>
										<li>
											<a href="#">我的賣場分類</a>
										</li>
										<li>
											<a href="#">我的銷售</a>
										</li>
										<li>
											<a href="#">我的行銷活動</a>
										</li>
										<li>
											<a href="#">我的進帳</a>
										</li>
										<li>
											<a href="#">我的錢包</a>
										</li>
										<li>
											<a href="#">賣場設定</a>
										</li>
									</ul>
									<!-- 右選單 -->
									<ul class="nav navbar-nav navbar-right">

										<li>
											<a href="#"></a>
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
													<a href="#">切換成買家</a>
												</li>
												<li>
													<a href="#">登出</a>
												</li>
											</ul>
										</li>
									</ul>
								</div>
								<!-- 手機隱藏選單區結束 -->
							</div>
						</nav>
					</div>
				</div>

				<%-- 錯誤表列 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>

					
										<div class="container-fluid">
											<div class="row">
													<!-- 表單 -->
														<div class="container-fluid warp">
															<div class="row">
																<!-- 容器區 -->
																<div class="container-fluid warpwidth">
																	<div class="row">
																		<div>
																			<h2 class="fontsize">?件商品</h2>
																		</div>
																		<!-- 關鍵字搜尋 -->
																			<div class="container">
																				<div class="row">
																					<!-- 搜尋表單 -->
																						<div class="col-xs-12 col-sm-4">
																							<div class="row">
																								
																								<div>
																				
																								</div>
																								<div class="input-group">
																									<input type="text" class="form-control" placeholder="請輸入關鍵字">
																									<span class="input-group-btn">
																										<button class="btn btn-info" type="button">搜尋</button>
																									</span>
																								</div>
																								
																							</div>
																						</div>
																					<div class="col-xs-12 col-sm-4"></div>
																					<div class="col-xs-12 col-sm-4"></div>
																				</div>
																			</div>
																		
																				<!-- 所有商品 -->
																				<FORM METHOD="post" ACTION="<%= request.getContextPath()%>/ord/ord.do" name="form1" enctype="multipart/form-data">
																				<table class="table table-hover ">
																					<thead>
																						<tr class="tablebgc">
																							<th class="checkboxsize"></th>
																							<th class="thwidth">商品名稱圖片</th>
																							<th>商品單價</th>
																							<th>數量</th>
																							<th>總計</th>
																							<th>操作</th>
																						</tr>
																					</thead>
																					<tbody>
																						<jsp:useBean id="productClassSvc" scope="page" class="com.productclass.model.ProductClassService" />
																						
																						<c:forEach var="proVO" items="${proVOList}">
																							<tr>
																								<td>
																								<!-- 核取方塊大小 -->
																									<input type="checkbox" name="pro_no" value="${proVO.pro_no}">

																								</td>
																								<!-- 商品圖片名稱 -->
																								<td style="text-align: left;">
																									<div style="height: 80px">
																										<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proVO.pro_no}"> ${proVO.pro_name}
																									</div>
																								</td>
																								
																								<!-- 商品單價 -->
																								<td>
																									${proVO.pro_bonus}
																								</td>
																								<!-- 商品數量 -->
																								<td>
																									${hAll[proVO.pro_no]}
																								</td>
																								<!-- 商品總計 -->
																								<td>
																									${hAll[proVO.pro_no] * proVO.pro_bonus}
																									
																									
																								</td>
																								<!-- 下拉式按鈕 -->
																								<td>
																								    <button type="button" class="deletedata" value="${proVO.pro_no}"  >刪除</button>
<%-- 																									<FORM METHOD="post" ACTION="<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do" name="form1" enctype="multipart/form-data"> --%>
<%-- 																										<input type="hidden" name="pro_no" value="${proVO.pro_no}"> --%>
<!-- 																										<input type="submit" value="刪除"> -->
<!-- 																										<input type="hidden" name="action" value="delete"> -->
<!-- 																									</FORM> -->
																								</td>
																							</tr>
																						</c:forEach>
																						
                                                                                    
																					</tbody>
																				</table>
																				    <div>
																				    	
																				    </div>
																					<div>
																						<input type="submit" value="去買單">
																						<input type="hidden" name="ord_amount" value="test"> 
																						<input type="hidden" name="action" value="insert">
																					</div>
																				</FORM>
																	</div>
																</div>
															</div>
														</div>
															
												
												
											</div>
										</div>

										<div class="container-fluid">
											<div class="row">
												<div class="container-fluid warp">
													<div class="row">
														<!-- 容器區 -->
														<div class="container-fluid warpwidth">
															<div class="row">
																<div>
																	<h2 class="fontsize">?件商品</h2>
																</div>
																<!-- 關鍵字搜尋 -->
																<div>
																	<input type="submit" value="去買單">
																	
																	<input type="hidden" name="ord_amount" value="test"> 
																	<input type="hidden" name="action" value="insert">
																	
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>


			</div>
		</div>


			<script src="https://code.jquery.com/jquery.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script type="text/javascript">
				$(document).ready(function(){
					$('#testid').click(function(){
						
						console.log("hi");
					})
					$('.deletedata').each( function() {
						$(this).click( function() {
	// 						var imgsrc = $(this).attr("value");
							var val = $(this).val();
						    alert(val);
							$.ajax({
								 type: "POST",
								 url: "shoppingCartServlet.do",
								 data: creatQueryString(val, ""),
								 dataType: "json",
								 success: function (data){
									 alert("<%= request.getContextPath()%>/shoppingcart_front.jsp")
									 window.location.replace("<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do?action=getAll_For_Display"); 
							     },
							     error: function(){alert("AJAX-class發生錯誤囉!")}
					         })
						})
					})
                    
                    
				})
				function creatQueryString(buttonid){
					
					var queryString= {"action":"delete", "pro_no":buttonid};
					console.log(queryString);
					return queryString;
				}
			</script>							
	</body>						
</html>						