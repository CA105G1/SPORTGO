<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    ProductService proSvc = new ProductService();
	ProductVO proVO = (ProductVO) request.getAttribute("proVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
	List<ProductVO> list = proSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<jsp:useBean id="proclassSvc" scope="page" class="com.productclass.model.ProductClassService" />


			<!DOCTYPE html>
			<html lang="">

			<head>
				<meta charset="utf-8">
				<meta http-equiv="X-UA-Compatible" content="IE=edge">
				<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
				<title>Title Page</title>
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

					.pagecenter {
						text-align: center;
					}
				</style>
			</head>

			<body>
			
							<%-- 錯誤表列 --%>
					<c:if test="${not empty errorMsgs}">
						<font style="color:red">請修正以下錯誤:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>


				<c:forEach var="proVO" items="${list}">

				
						<!-- 容器區 -->
						<div class="container-fluid warpwidth">
							<div class="row">
								<!-- 圖片預覽 -->
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
											<tr>
												<!-- 商品圖片名稱 -->
												<td style="text-align: left;">
													<div style="height: 80px">
														<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>"><%=proVO.getPro_name()%>
													</div>
												</td>
												<!-- 商品編號 -->
												<td><%=proVO.getPro_no()%></td>
												<!-- 商品類別 -->
												<td>
													${proclassSvc.getOneProductClass(proVO.pro_classid).pro_classname }
												</td>
												<!-- 商品單價 -->
												<td>
													<%=proVO.getPro_bonus()%>
												</td>
												<!-- 商品庫存 -->
												<td>
													<%=proVO.getPro_stock()%>
												</td>
												<!-- 商品狀態 -->
												<td>
													<%=proVO.getPro_shelve()%>
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
																	<input type="hidden" name="pro_no" value="<%=proVO.getPro_no()%>">
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
									</tbody>
								</table>
							</div>
						</div>
					</c:forEach>

			</body>

			</html>