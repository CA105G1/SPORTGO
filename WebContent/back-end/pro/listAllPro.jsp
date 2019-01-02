<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
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
	<title>我的商品</title>
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
												<!-- 複合查詢 -->
												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
													<div class="col-xs-12 col-sm-2">
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
															<li class="list-group-item">
																<div>
																	商品狀態
																</div>
																<div>
																	<input type="text" name="pro_shelve">
																</div>
															</li>
														</ul>
														 <input type="submit" value="送出">
       													 <input type="hidden" name="action" value="pro_ByCompositeQuery">
													</div>
												</FORM>
												<div class="col-xs-12 col-sm-9">
													<!-- 表單 -->
													<FORM METHOD="post" ACTION="<%= request.getContextPath()%>/pro/pro.do" name="form1" enctype="multipart/form-data">
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
																				<div class="col-xs-12 col-sm-4">
																					<div class="row">
																						<!-- 搜尋表單 -->
																						<div>
																		
																						</div>
																						<div class="input-group">
																							<input type="text" class="form-control" placeholder="請輸入關鍵字">
																							<span class="input-group-btn">
																								<button class="btn btn-info" type="button">搜尋</button>
																							</span>
																						</div>
																						<div class="divAdd">
																							<a href="<%= request.getContextPath()%>/back-end/pro/addPro.jsp">Add</a>
																						</div>
																					</div>
																				</div>
																				<div class="col-xs-12 col-sm-4"></div>
																				<div class="col-xs-12 col-sm-4"></div>
																			</div>
																		</div>
			                                                            <!-- include修改後的單筆商品 -->
																		<%if ("update".equals(request.getAttribute("update"))) {%>
																			<jsp:include page="listOnePro.jsp" flush="true" />
																		<%} %>
																		<%@ include file="page/page1_ByCompositeQuery.file" %>
																				<!-- 所有商品 -->
																				<table class="table table-hover ">
																					<thead>
																						<tr class="tablebgc">
																							<th class="thwidth">商品名稱圖片</th>
																							<th>商品編號</th>
																							<th>商品類別</th>
																							<th>商品單價</th>
																							<th>商品庫存</th>
																							<th>商品狀態</th>
																							<th>操作</th>
																						</tr>
																					</thead>
																					<tbody>
																						<jsp:useBean id="productClassSvc" scope="page" class="com.productclass.model.ProductClassService" />
																						<c:forEach var="proVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
																							<tr>
																								<!-- 商品圖片名稱 -->
																								<td style="text-align: left;">
																									<div style="height: 80px">
																										<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proVO.pro_no}"> ${proVO.pro_name}
																									</div>
																								</td>
																								<!-- 商品編號 -->
																								<td>${proVO.pro_no}</td>
																								<!-- 商品類別 -->
																								<td>
																									${proclassSvc.getOneProductClass(proVO.pro_classid).pro_classname }
																								</td>
																								<!-- 商品單價 -->
																								<td>
																									${proVO.pro_bonus}
																								</td>
																								<!-- 商品庫存 -->
																								<td>
																									${proVO.pro_stock}
																								</td>
																								<!-- 商品狀態 -->
																								<td>
																									${proVO.pro_shelve}
																								</td>
																								<!-- 下拉式按鈕 -->
																								<td>
																									<div class="btn-group">
																										<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
																											<i class="fa fa-pencil-square">
																												編輯
																											</i>
																											<span class="caret"></span>
																										</button>
																										<ul class="dropdown-menu" role="menu">
																											<li>
																												<a href="#"></a>
																											</li>
																											<li>
																												<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
																													<input type="submit" value="修改">
																													<input type="hidden" name="pro_no" value="${proVO.pro_no}">
																													<input type="hidden" name="action" value="getOne_For_Update">
																												</FORM>
																											</li>
																											<li>
																												<a href="#">上架</a>
																											</li>
																											<li>
																												<a href="#">下架</a>
																											</li>
																											<li class="divider"></li>
																											<li>
																												<a href="#">未設置</a>
																											</li>
																										</ul>
																									</div>
																								</td>
																							</tr>
																						</c:forEach>

																					</tbody>
																				</table>
																				<%@ include file="page/page2_ByCompositeQuery.file" %>
																	</div>
																</div>
															</div>
														</div>
													</FORM>			
												</div>
												<div class="col-xs-12 col-sm-1"></div>
											</div>
										</div>


			</div>
		</div>


			<script src="https://code.jquery.com/jquery.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script type="text/javascript">
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