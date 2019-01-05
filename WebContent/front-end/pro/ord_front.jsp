<%@page import="com.orddetails.model.OrddetailsVO"%>
<%@page import="com.orddetails.model.OrddetailsService"%>
<%@page import="com.ord.model.OrdService"%>
<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	OrdService ordSvc = new OrdService();
	OrddetailsService orddetailsSvc = new OrddetailsService();
	List<OrddetailsVO> list = orddetailsSvc.getOneOrd(ordSvc.getOneOrd(request.getAttribute("ord_no").toString()).getOrd_no());
	pageContext.setAttribute("list",list);
	
// 	List<ProductVO> list = new ArrayList<ProductVO>();
// 	if ("findBy".equals(request.getAttribute("findBy"))) {
// 		list = (List<ProductVO>) request.getAttribute("pro_ByCompositeQuery");
// 	} else {
// 		list = proSvc.getAll();
// 	}
//     pageContext.setAttribute("list",list);

%>
<jsp:useBean id="proSvc" scope="page" class="com.product.model.ProductService" />
<!DOCTYPE html> 
<html lang="">

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>訂單詳情</title>
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
													<FORM >
														<div class="container-fluid warp">
															<div class="row">
																<!-- 容器區 -->
																<div class="container-fluid warpwidth">
																	<div class="row">
																		<div>
																			<h2 class="fontsize">訂單詳情</h2>
																		</div>
										
																		
																				<!-- 所有商品 -->
																				<table class="table table-hover ">
																					<thead>
																						<tr class="tablebgc">
																							
																							<th class="thwidth">商品名稱圖片</th>
																							<th>商品單價</th>
																							<th>數量</th>
																							<th>總計</th>
																							<th>狀態</th>
																							<th>操作</th>
																						</tr>
																					</thead>
																					<tbody>
																						
																						<c:forEach var="orddetails" items="${list}">
																							<tr>
																								<!-- 商品圖片名稱 -->
																								<td style="text-align: left;">
																									<div style="height: 80px">
																										<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proSvc.getOneProduct(orddetails.pro_no).pro_no}"> 
																										${proSvc.getOneProduct(orddetails.pro_no).pro_name}
																									</div>
																								</td>
																								
																								<!-- 商品單價 -->
																								<td>
																									${proSvc.getOneProduct(orddetails.pro_no).pro_bonus}
																								</td>
																								<!-- 商品數量 -->
																								<td>
																									${orddetails.pro_count}
																								</td>
																								<!-- 商品總計 -->
																								<td>
																									${orddetails.pro_count * proSvc.getOneProduct(orddetails.pro_no).pro_bonus}
																								</td>
																								<!-- 訂單狀態 -->
																								<td>
																									${proSvc.getOneProduct(orddetails.pro_no).pro_shelve}
																								</td>
																								<!-- 下拉式按鈕(目前無) -->
																							</tr>
																						</c:forEach>
																					</tbody>
																				</table>
																				<div align="right">
																				   <button type="button" value="cancel" class="btn btn-danger">取消訂單</button> 
																				</div>
																	</div>
																</div>
															</div>
														</div>
													</FORM>			
										
											</div>
										</div>

			</div>
		</div>


			<script src="https://code.jquery.com/jquery.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script type="text/javascript">
			$(document).ready(function(){
				$('.cancel').each( function() {
					$(this).click( function() {
						var val = $(this).val();
						$.ajax({
							 type: "POST",
							 url: "<%= request.getContextPath()%>/ord/ord.do",
							 data: creatQuerycancel(val),
							 dataType: "json",
							 success: function (data){
								 $('#'+data.ord_no).html('取消');
						     },
						     error: function(){alert("AJAX-class發生錯誤囉!")}
				         })
					})
				})
			})
			
				// document.getElementById("display").style.display = 'none';
				//    $(function() {  //將圖片預覽
				//    	$('input[type=file]').change(function() {
				//      	var input = $(this);
				//      	document.getElementById("preset").style.display = 'none';
				//      	document.getElementById("display").style.display = 'block';
				//      	if(!!this.files && !!this.files[0]) {
				//        	var reader = new FileReader();
				//          reader.onload = function(e) {
				//          	$('#pre' + input.prop('id').substr(4,2)).prop('src', e.target.result);
				//          }
				//          reader.readAsDataURL(this.files[0]);
				//        }
				//      });
				//    });
			</script>							
	</body>						
</html>						