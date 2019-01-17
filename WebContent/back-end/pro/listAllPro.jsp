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
	
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap.min.css">
<!-- bootstrap -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!-- sweetalert-link -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<!-- bootstrap -->
<!-- 	<script src="https://code.jquery.com/jquery-3.3.1.js"></script> -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

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

<body onload="connect();" onunload="disconnect();">
<jsp:include page="/back-end/CA105G1_header_back.jsp"/>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
<!-- <h1>後台共用區</h1> -->
<!-- <h2>here need include left_side_field.jsp</h2> -->
			<jsp:include page="/back-end/pro/page/left_side_field.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9">
					<h1>後台內容，使用tabs，也可自由發揮</h1>
					
					<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">商品列表</a>
					        </li>
					        <li role="presentation" class="">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">訂單列表</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">標題三</a>
					        </li>
					    </ul>
					
			<!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					        <div role="tabpanel" class="tab-pane active" id="tab1">
					        
<!------------------------------------------複合查詢------->
    <div class="container">
      <div class="row">
        <div class="col-xs-12 col-sm-9">
                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
                    <table>
                        <tr>
                          <div>
                            <th>
                              <p>商品名稱：</p>
                              <td>
                                <input type="text" name="pro_name" class="form-control">
                              </td>
                            </th>
                          </div>
                        </tr>
                        <tr>
                          <div>
                            <th>
                              <p>商品編號：</p>
                              <td>
                                <input type="text" name="pro_no" class="form-control">
                              </td>
                            </th>
                          </div>
                          <div>
                            <th>
                              <p>商品類別編號：</p>
                                <td>
                                  <select size="1" name="pro_classid" class="form-control">
                                        <option value="">
                                       <c:forEach var="proclassVO" items="${proclassSvc.all}" > 
                                        <option value="${proclassVO.pro_classid}">${proclassVO.pro_classname}
                                       </c:forEach>   
                                  </select>
                                </td>
                            </th>
                          </div>
                        </tr>
                        <tr>
                          <div>
                            <th>
                              <p>商品單價：</p>
                              <td>
                                <input type="text" name="pro_bonus" class="form-control">
                              </td>
                            </th>
                          </div>
                          <div>
                            <th>
                              <p>商品狀態：</p>
                              <td>
                                <input type="text" name="pro_shelve" class="form-control">
                              </td>
                              <td>
                                <center>
			                      <input type="submit"  value="送出" class="btn btn-primary">
			                       <input type="hidden" name="action" value="pro_ByCompositeQuery">
			                    </center>
                              </td>
                            </th>
                          </div>  
                        </tr>
                    </table>
                </FORM>
        </div>
        <div class="col-xs-12 col-sm-3"></div>
      </div>
    </div>
<!------------------------------------------商品管理------->
				<!-- 表單 -->
				<div class="container-fluid warp">
					<div class="row">
						<!-- 容器區 -->
						<div class="container-fluid warpwidth">
							<div class="row">
				        		<%if ("update".equals(request.getAttribute("update"))) {%>
									<jsp:include page="listOnePro.jsp" flush="true" />
								<%} %>
								<!-- 所有商品 -->
								<table id="example" class="table table-striped table-bordered" style="width:100%">
									<thead>
										<tr class="tablebgc">
											<th class="thwidth">商品名稱圖片</th>
											<th>商品編號</th>
											<th>商品類別</th>
											<th>商品單價</th>
											<th>商品庫存</th>
											<th>商品狀態</th>
											<th>狀態操作</th>
											<th>詳細操作</th>
										</tr>
									</thead>
									<tbody>
										<jsp:useBean id="productClassSvc" scope="page" class="com.productclass.model.ProductClassService" />
										<c:forEach var="proVO" items="${list}">
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
													<div id="${proVO.pro_no}">${proVO.pro_shelve}</div>
												</td>
												<!-- 下拉式按鈕 -->
												<td>
													<div align="right">
														<select name=""  class="form-control select_change" style="width:90px;">
																<option value="${proVO.pro_no}">上架中</option>
																<option value="${proVO.pro_no}">下架</option>
														</select>
													</div>
												</td>
												<!-- 修改按鈕 -->
												<td>
												    <div>
														<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
															<input type="submit" value="修改" class="btn btn-primary">
															<input type="hidden" name="pro_no" value="${proVO.pro_no}">
															<input type="hidden" name="action" value="getOne_For_Update">
														</FORM>
													</div>
												</td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
								</div>
							</div>
						</div>
					</div>
<!--------------------------------------------訂單管理-->
					        </div>
					        <a>
						        <div role="tabpanel" class="tab-pane" id="tab2">
						        	<jsp:include page="/back-end/pro/ord_back.jsp"/>
						        </div>
                            </a>
					        <div role="tabpanel" class="tab-pane" id="tab3">
					        	<h1>標題三內容</h1>
					        </div>
					    </div>
					</div>
					
					
				</div>
			</div>
		</div>

<%@ include file="/front-end/CA105G1_footer.file" %>
<!-- websock -->
<script src="<%=request.getContextPath() %>/back-end/pro/tool/websock_serviec.js"></script>

			<%if ("success".equals(request.getAttribute("success"))) {
			out.println("<script type=\"text/javascript\">$(document).ready(function(){ ");
			out.println("var pro_name= \""+request.getAttribute("requestPro_name")+"\";");
			out.println("test(pro_name);");
			out.println("})</script>");
			}%>
			<script type="text/javascript">
			function test(pro_name){
				swal({
					title:"商品新增成功",
					html:"按下確認鍵進行推撥", 
					type:"success",
					allowOutsideClick: false
				}).then(
					function (result) {
		                if (result) {
		                	starWebsock(pro_name);
		                }
					}
				);
			}
			$(document).ready(function(){
	            
				$('#example').DataTable();
				$('.select_change').change(function(){
					$.ajax({
						 type: "POST",
						 url: "<%= request.getContextPath()%>/pro/pro.do",
						 data: creatQuerySelect($(this).val(),$("option:selected", this).text()),
						 dataType: "json",
						 success: function (data){
							 console.log(data.pro_no+'A');
							 $('#'+data.pro_no).html(data.pro_shelve);
					     },
					     error: function(){alert("AJAX-class發生錯誤囉!")}
			         })
				})	
			})
			//*************
			function creatQuerySelect(pro_no,pro_shelve){
				
				var queryString= {"action":"ok_cancel", "pro_no":pro_no , "pro_shelve" :pro_shelve};
				console.log(queryString);
				return queryString;
			}
			
			//*************
					$('.ok').each( function() {
						$(this).click( function() {
							var val = $(this).val();
							$.ajax({
								 type: "POST",
								 url: "<%= request.getContextPath()%>/ord/ord.do",
								 data: creatQueryOK(val),
								 dataType: "json",
								 success: function (data){
									 $('#'+data.ord_no).html('完成');
							     },
							     error: function(){alert("AJAX-class發生錯誤囉!")}
					         })
						})
					})
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
					
				
				function creatQueryOK(ord_no){
					
					var queryString= {"action":"ok_cancel", "ord_no":ord_no , "ord_status" :"完成"};
					console.log(queryString);
					return queryString;
				}
				function creatQuerycancel(ord_no){
					var queryString= {"action":"ok_cancel", "ord_no":ord_no , "ord_status" :"取消"};
					return queryString;
				}	
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