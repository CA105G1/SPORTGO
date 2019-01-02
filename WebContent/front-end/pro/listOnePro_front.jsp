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
		<title>商品詳情</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	<style type="text/css">
		.aa {
			background-color: #faa;
            height: 480px;
		}

		.bb {
			height: 480px;
			background-color: #afa;
		}

		.cc {
			
			background-color: #aaf;
		}

		.dd {
			height: 300px;
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
			background-color: #D9D8D8;
			padding: 20px 48px;
			/*width: 1200px;*/
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

        th {  /*置中*/
        	text-align: center;
        }
        td {  /*置中*/
        	text-align: center;
        }
        .divfont{  /*div文字置中調整*/
        	text-align: center;
        }
        .divpic{ /*圖片置中調整*/
        	text-align: center;
        	vertical-align: middle;
        	line-height:100px;
  			margin: auto;
        }

        #pre01 {  /*照片大小調整*/
			width: 480px;
			height: auto;
		}
        .imgsize { /*照片大小調整*/
			width: 480px;
			height: auto;
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



				<!-- 表單 -->
				    <c:forEach var="proVO" items="${list}">
						<div class="container-fluid warp">
			                <div class="row">
							<!-- 容器區 -->
							    <div class="container-fluid warpwidth">
							    	<div class="row">
							    		<div class="container-fluid">
							    			<div class="row">
							    				<div class="col-xs-12 col-sm-6 aa">
									    		<!-- 圖片瀏覽 -->
										    		<div id="preset" class="divpic">
										    			<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>">
										    		</div>	
							    				</div>
							    				<!-- 加入購物車可選尺寸等等 -->
								    				<div class="col-xs-12 col-sm-6 bb">
								    					<div class="container-fluid dd">
								    						<div class="row">
								    							<!-- 商品種類 -->
								    							<div class="fontsize_s">
								    								${proclassSvc.getOneProductClass(proVO.pro_classid).pro_classname }
								    							</div>
								    							<!-- 商品名稱 -->
								    							<div class="fontsize_s">
								    								<%=proVO.getPro_name()%>
								    							</div>
								    							<!-- 商品單價 -->
								    							<div class="fontsize_s">
								    								<%=proVO.getPro_bonus()%>
								    							</div>
								    							<!-- 商品規格 -->
								    							<div class="fontsize_s">
								    								<%=proVO.getPro_format()%>
								    							</div>
								    							<!-- 商品庫存量 -->
								    							<div class="fontsize_s">
								    								<%=proVO.getPro_stock()%>
								    							</div>
								    							<!-- 數量 -->
								    							<div class="fontsize_s">
								    								<input id="min" name="" type="button" value="-" />
																	<input id="num" class="text_box"  type="text" value="1" />
																	<input id="add" name="" type="button" value="+" />
								    							</div>
								    						</div>
								    						<div>
								    							<button id="btn1" type="button" value="<%= proVO.getPro_no() %>">加入購物車</button>
								    							
								    						</div>
								    						<div>
								    							<FORM METHOD="post" ACTION="<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do" name="form1" enctype="multipart/form-data">
								    								<input type="submit" value="購物車網頁">
								    								<input type="hidden" name="action" value="getAll_For_Display">
								    							</FORM>
								    						</div>
								    					</div>
								    				</div>
							    			</div>
							    		</div>
							    		
	   
							    	</div>
							    </div>
			                </div>
						</div>
                        <div class="container-fluid">
                        	<div class="row">
                        		<div class="container-fluid warpwidth">
                        			<div class="row">
                        				<div class="divfont">
                        					<h1>
                        						<%=proVO.getPro_details()%>
                        					</h1>
                        				</div>
                        			</div>
                        		</div>
                        	</div>
                        </div>


					</c:forEach>







			</div>
		</div>
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script type="text/javascript"> 
			$(function(){
				var t = $(".text_box");
				$("#add").click(function(){		
					t.val(parseInt(t.val())+1)
					// setTotal();
				})
				$("#min").click(function(){
					t.val(parseInt(t.val())-1)
					// setTotal();
				})
				$("#num").keyup(function(){
					t.val(parseInt(t.val()))
				})
				
				//****************************************
				$("#btn1").on('click', function () {
					$.ajax({
						 type: "POST",
						 url: "<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do",
						 data: creatQueryString($(this).val(), $('#num').val()),
						 dataType: "json",
						 success: function (data){
							 
					     },
					     error: function(){alert("AJAX-class發生錯誤囉!")}
			         });
			        swal({
			            title: "成功加入購物車",
			            html: "按下確定前往購物車",
			            type: "success", // type can be "success", "error", "warning", "info", "question"
			            showCancelButton: true,
			        	showCloseButton: true,
			        }).then(
			        	   function (result) {
		                if (result) {
		                	window.location.replace("<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do?action=getAll_For_Display"); 
		                }
		            }, function(dismiss) { // dismiss can be "cancel" | "overlay" | "esc" | "cancel" | "timer"
		            		
			        });
			    });
				function creatQueryString(buttonid,pro_count){
					
					var queryString= {"action":"insert", "pro_no":buttonid, "pro_count":pro_count};
					console.log(queryString);
					return queryString;
				}
				//****************************************
				
				
				
				
				// function setTotal(){
				// 	$("#total").html((parseInt(t.val())*3.95).toFixed(2));
				// }
				// setTotal();
			})
			// function returnvalue(){
			// 	$("#returnValue").html((parseInt(t.val())).toFixed(2));
			// }




		</script>
	</body>
</html>