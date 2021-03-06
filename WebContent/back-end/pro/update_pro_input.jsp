<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
	ProductVO proVO = (ProductVO) request.getAttribute("proVO"); //EmpServlet.java (Concroller) 存入req的proVO物件 (包括幫忙取出的proVO, 也包括輸入資料錯誤時的proVO物件)
	pageContext.setAttribute("proVO",proVO);
%> 
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>商品修改</title>
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
		.ee{
            background-color: #0f5;
		}
		.ff{
			background-color: #E4D10F;
		}
		.dropdown-menu li:hover .sub-menu { /*碰到navbar會下拉*/
			visibility: visible;
		}
		.dropdown:hover .dropdown-menu { /*碰到navbar會下拉*/
			display: block;
		}

		.backgc { /*背景底色*/
			background-color: #F6F6F6;
		}

		.navsize{ /*navbar寬度大小*/
            width: 1200px;
		}
        
		.warp { /*商品內頁*/
			box-shadow: 0 0.2rem 0.4rem rgba(0, 0, 0, .09);
			background-color: rgb(252, 252, 253);
			padding: 20px 48px;
			width: 1200px;
			margin: auto;
            
		}
		
		.warpwidth{ /*商品內頁大小*/
			width: 1104px;
		}
		.fontsize{ /*文字標籤*/
		    font-size: 18px;
		    font-weight: 400;
		    color: #000;
		    margin: 30px 0 15px;
		    text-align: left;
		}
		.fontsize_s{ /*文字內容標籤*/
			min-height: 40px;
    		color: #666;
		}
        .valuesize{ /*value標籤*/
        	min-height: 40px;
        }
        .buttonsize{ /*按鈕大小*/
        	text-align: center;
        }
        .tablebgc{
        	background-color: #F7F5F5;
        }
        .thwidth{ /*商品名稱圖片大小*/
        	width: 250px;
        }
        table{
		    border-collapse:separate;
		    border-spacing:0 0.5rem;
        }

        th {
        	text-align: center;
        }
        td {
        	text-align: center;
        }
        #pre01 {
			width: 300px;
			height: auto;
		}
        .imgsize {
			width: 300px;
			height: auto;
		}
	</style>
	</head>
	<body>
<%@ include file="/front-end/CA105G1_header.file" %>
		<div class="container-fluid backgc">
			<div class="row">
				

                <!-- navbar -->
<!-- 				<div class="container-fluid "> -->
<!-- 					<div class="row"> -->
<!-- 						<nav class="navbar navbar-default" role="navigation"> -->
<!-- 							<div class="container"> -->
<!-- 								<div class="navbar-header"> -->
<!-- 									<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"> -->
<!-- 										<span class="sr-only">選單切換</span> -->
<!-- 										<span class="icon-bar"></span> -->
<!-- 										<span class="icon-bar"></span> -->
<!-- 										<span class="icon-bar"></span> -->
<!-- 									</button> -->
<!-- 									<a class="navbar-brand" href="#">SPORTGO</a> -->
<!-- 								</div> -->

<!-- 								手機隱藏選單區 -->
<!-- 								<div class="collapse navbar-collapse navbar-ex1-collapse "> -->
<!-- 									左選單 -->
<!-- 									<ul class="nav navbar-nav"> -->
<!-- 										<li class="active"> -->
<!-- 											<a href="#">我的商品</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">我的賣場分類</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">我的銷售</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">我的行銷活動</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">我的進帳</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">我的錢包</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">賣場設定</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 									右選單 -->
<!-- 									<ul class="nav navbar-nav navbar-right"> -->

<!-- 										<li> -->
<!-- 											<a href="#"></a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">個人設定</a> -->
<!-- 										</li> -->
<!-- 										<li class="dropdown"> -->
<!-- 											<a href="#" class="dropdown-toggle" data-toggle="dropdown">繁體中文 -->
<!-- 												<b class="caret"></b> -->
<!-- 											</a> -->
<!-- 											<ul class="dropdown-menu"> -->
<!-- 												<li> -->
<!-- 													<a href="#">切換成買家</a> -->
<!-- 												</li> -->
<!-- 												<li> -->
<!-- 													<a href="#">登出</a> -->
<!-- 												</li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</div> -->
<!-- 								手機隱藏選單區結束 -->
<!-- 							</div> -->
<!-- 						</nav> -->
<!-- 					</div> -->
<!-- 				</div> -->



				<!-- 表單 -->
					<FORM METHOD="post" ACTION="<%= request.getContextPath()%>/pro/pro.do" name="form1" enctype="multipart/form-data">
						<div class="container-fluid warp">
			                <div class="row">
							<!-- 容器區 -->
							    <div class="container-fluid warpwidth">
							    	<div class="row">
							    	    <%-- 錯誤表列 --%>
											<c:if test="${not empty errorMsgs}">
												<font style="color:red">請修正以下錯誤:</font>
												<ul>
													<c:forEach var="message" items="${errorMsgs}">
														<li style="color:red">${message}</li>
													</c:forEach>
												</ul>
											</c:if>
							    		<div>
							    			<h2 class="fontsize">編輯商品照片</h2>
							    		</div>
							    		<!-- 檔案上傳 -->
								    		<div>
								    			<input type="file" name="pro_pic" id="file01">
								    		</div>
							    		<!-- 圖片預先瀏覽 -->
								    		<div id="preset">
								    			<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no()%>">
								    		</div>
			                            <!-- 圖片預覽 -->
								    		<div id="display">
								    			<img id="pre01" class="imgsize">
								    		</div>
							    		    <!-- 文字表格1 -->
								    			<div class="container-fluid ">
									    			<div class="row">
									    				<div class="fontsize">
									    					基本資訊 :
									    				</div>
									    				<!-- 左空白 -->
										    				<div class="col-xs-12 col-sm-1 ">
										    				    <div class="row">
											    				    	
										    				    </div>
										    				</div>
									    				<!-- 內容詳情 -->
										    				<div class="col-xs-12 col-sm-10 ">
				                                                <div class="col-xs-12 col-sm-2 ">
											    					<div class="fontsize_s">
											    						商品類別 :			    						
											    					</div>
											    					<div class="fontsize_s">
											    						商品名稱 :				    						
											    					</div>
<!-- 											    					<div class="fontsize_s"> -->
<!-- 											    						照片副檔名 :			    						 -->
<!-- 											    					</div> -->
											    					<div class="fontsize_s">
											    						商品規格 :				    						
											    					</div>
											    					<div class="fontsize_s">
											    						商品詳述 :				    						
											    					</div>
											    					<div class="fontsize_s">
											    						商品狀態 :				    						
											    					</div>

				                                                </div>
				                                                <div class="col-xs-12 col-sm-8 ">
				                                                	<!-- 商品類別 -->
				                                                	    <jsp:useBean id="productClassSvc" scope="page" class="com.productclass.model.ProductClassService" />
					                                                    <div class="valuesize">
					                                                    	<select size="1" name="pro_classid" class="form-control">
																				<c:forEach var="productClassVO" items="${productClassSvc.all}">
																					<option value="${productClassVO.pro_classid}" ${(productClassVO.pro_classid==productClassVO.pro_classid)?'selected':'' } >${productClassVO.pro_classname}
																				</c:forEach>
																			</select>
					                                                    </div>
				                                                	<!-- 商品名稱 -->
					                                                	<div class="valuesize">
					                                                		<input type="TEXT" class="form-control" size="45" name="ename" size="45" value="<%= proVO.getPro_name()%>" />
					                                                	</div>
				                                                	<!-- 照片副檔名 -->
					                                                		<input type="hidden" name="pic_ext" size="45" value="<%= proVO.getPro_pic_ext()%>" />
					                                                	
				                                                	<!-- 商品規格 -->
					                                                	<div class="valuesize">
					                                                		<input type="TEXT" class="form-control" size="45" name="format" size="45" value="<%=  proVO.getPro_format()%>" />
					                                                	</div>
				                                                	<!-- 商品詳述 -->
					                                                	<div class="valuesize">
					                                                		<input type="TEXT" class="form-control" size="45" name="pro_details" size="45" value="<%=  proVO.getPro_details()%>" />
					                                                	</div>
				                                                	<!-- 商品狀態 -->
					                                                	<div class="valuesize">
<%-- 					                                                		<input type="TEXT" class="form-control" size="45" name="pro_shelve" size="45" value="<%=  proVO.getPro_shelve()%>" /> --%>
                   															<select name="pro_shelve"  class="form-control select_change" style="width:90px;">
																				<option value="上架中">上架中</option>
																				<option value="下架">下架</option>
																			</select>
					                                                	</div>
				                                                </div>
				                                                <div class="col-xs-12 col-sm-2 ">
				                                                </div>
										    				</div>
									    				<!-- 右空白 -->
										    				<div class="col-xs-12 col-sm-1 ">
										    					
										    				</div>
									    			</div>
								    			</div>
							    			<!-- 文字表格2 -->
								    			<div class="container-fluid ">
									    			<div class="row">
									    				<div class="fontsize">
									    					商品單價及庫存 :
									    				</div>
									    				<!-- 左空白 -->
										    				<div class="col-xs-12 col-sm-1 ">
										    				    <div class="row">
											    				    	
										    				    </div>
										    				</div>
									    				<!-- 內容詳情 -->
										    				<div class="col-xs-12 col-sm-10 ">
				                                                <div class="col-xs-12 col-sm-2 ">
											    					<div class="fontsize_s">
											    						商品單價 : 				    						
											    					</div>
											    					<div class="fontsize_s">
											    						商品庫存量 :				    						
											    					</div>
											    					<div class="fontsize_s">
											    						商品安全庫存量 :			    						
											    					</div>
<!-- 											    					<div class="fontsize_s"> -->
<!-- 											    						商品總評價 :				    						 -->
<!-- 											    					</div> -->
<!-- 											    					<div class="fontsize_s"> -->
<!-- 											    						商品評價總人數 :				    						 -->
<!-- 											    					</div> -->
				                                                </div>
				                                                <div class="col-xs-12 col-sm-8 ">
				                                                	<!-- 商品單價 -->
					                                                    <div class="valuesize">
					                                                    	<input type="TEXT" class="form-control" size="45" name="pro_bonus" size="45" value="<%= proVO.getPro_bonus()%>" />
					                                                    </div>
				                                                	<!-- 商品庫存量 -->
					                                                	<div class="valuesize">
					                                                		<input type="TEXT" class="form-control" size="45" name="pro_stock" size="45" value="<%= proVO.getPro_stock()%>" />
					                                                	</div>
				                                                	<!-- 商品安全庫存量 -->
					                                                	<div class="valuesize">
					                                                		<input type="TEXT" class="form-control" size="45" name="pro_safestock" size="45" value="<%= proVO.getPro_safestock()%>" />
					                                                	</div>
				                                                	<!-- 商品總評價 -->
					                                                	<div class="valuesize">
					                                                		<input type="hidden" class="form-control" size="45" name="pro_all_assess" size="45" value="<%= proVO.getPro_all_assess()%>" />
					                                                	</div>
				                                                	<!-- 商品評價總人數 -->
					                                                	<div class="valuesize">
					                                                		<input type="hidden" class="form-control" size="45" name="pro_all_assessman" size="45" value="<%= proVO.getPro_all_assessman()%>" />
					                                                	</div>
				                                                </div>
				                                                <div class="col-xs-12 col-sm-2 ">
				                                                </div>
										    				</div>
									    				<!-- 右空白 -->
										    				<div class="col-xs-12 col-sm-1 ">
										    					
										    				</div>
									    			</div>
								    			</div>
		                                    
							    			<!-- 送出按鈕 -->
									    		<div style="text-align: center;">
									    			<input type="hidden" name="action" value="update">
													<input type="hidden" name="pro_no" value="<%=proVO.getPro_no()%>">
													<input type="submit" value="送出修改">
									    		</div>
							    	</div>
							    </div>
			                </div>
						</div>
					</FORM>

<%@ include file="/front-end/CA105G1_footer.file" %>
			</div>
		</div>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script type="text/javascript"> 
			document.getElementById("display").style.display = 'none';
		    $(function() {  //將圖片預覽
		    	$('input[type=file]').change(function() {
		      	var input = $(this);
		      	document.getElementById("preset").style.display = 'none';
		      	document.getElementById("display").style.display = 'block';
		      	if(!!this.files && !!this.files[0]) {
		        	var reader = new FileReader();
		          reader.onload = function(e) {
		          	$('#pre' + input.prop('id').substr(4,2)).prop('src', e.target.result);
		          }
		          reader.readAsDataURL(this.files[0]);
		        }
		      });
		    
// 				$('.select_change').change(function(){
// 					creatQuerySelect($(this).val(),$("option:selected", this).text());
// 					$.ajax({
// 						 type: "POST",
<%-- 						 url: "<%= request.getContextPath()%>/pro/pro.do", --%>
// 						 data: creatQuerySelect($(this).val(),$("option:selected", this).text()),
// 						 dataType: "json",
// 						 success: function (data){
// 							 console.log(data.pro_shelve);
// 							 $('#'+data.pro_no).html(data.pro_shelve);
// 					     },
// 					     error: function(){alert("AJAX-class發生錯誤囉!")}
// 			         })
// 				})
		    });	
// 			function creatQuerySelect(pro_no,pro_shelve){
// 				var queryString= {"action":"ok_cancel", "pro_no":pro_no , "pro_shelve" :pro_shelve};
// 				console.log(queryString);
// 				return queryString;
// 			}
		</script>
	</body>
</html>