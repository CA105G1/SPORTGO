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
	System.out.print("test"+request.getParameter("ord_no"));
	String ord_no = request.getParameter("ord_no");
	if(ord_no==null)
		ord_no = (String)request.getAttribute("ord_no");
	List<OrddetailsVO> list = orddetailsSvc.getOneOrd(ordSvc.getOneOrd(ord_no).getOrd_no());
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
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>Alazea - Gardening &amp; Landscaping HTML Template</title>

    <!-- Favicon -->
    <link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
	<style type="text/css">
		.imgsize {
			width: 80px;
			height: auto;
			float: left;
		}
	</style>
</head>

<body onload="connect();" onunload="disconnect();">
    <!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="preloader-circle"></div>
        <div class="preloader-img">
            <img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png" alt="">
        </div>
    </div>

    <!-- ##### Header Area Start ##### -->
    <header class="header-area">

        <!-- ***** Top Header Area ***** -->
        <div class="top-header-area">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="top-header-content d-flex align-items-center justify-content-between">
                            <!-- Top Header Content -->
                            <div class="top-header-meta">
                                <a href="#" data-toggle="tooltip" data-placement="bottom" title="infodeercreative@gmail.com"><i class="fa fa-envelope-o" aria-hidden="true"></i> <span>Email: infodeercreative@gmail.com</span></a>
                                <a href="#" data-toggle="tooltip" data-placement="bottom" title="+1 234 122 122"><i class="fa fa-phone" aria-hidden="true"></i> <span>Call Us: +1 234 122 122</span></a>
                            </div>

                            <!-- Top Header Content -->
                            <div class="top-header-meta d-flex">
                                <!-- Language Dropdown -->
                                <div class="language-dropdown">
                                    <div class="dropdown">
                                        <button class="btn btn-secondary dropdown-toggle mr-30" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Language</button>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item" href="#">USA</a>
                                            <a class="dropdown-item" href="#">UK</a>
                                            <a class="dropdown-item" href="#">Bangla</a>
                                            <a class="dropdown-item" href="#">Hindi</a>
                                            <a class="dropdown-item" href="#">Spanish</a>
                                            <a class="dropdown-item" href="#">Latin</a>
                                        </div>
                                    </div>
                                </div>
                                <!-- Login -->
                                <div class="login">
                                    <a href="#"><i class="fa fa-user" aria-hidden="true"></i> <span>Login</span></a>
                                </div>
                                <!-- Cart -->
                                <div class="cart">
                                    <a href="#"><i class="fa fa-shopping-cart" aria-hidden="true"></i> <span>Cart <span class="cart-quantity">(1)</span></span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ***** Navbar Area ***** -->
        <div class="alazea-main-menu">
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="alazeaNav">

                        <!-- Nav Brand -->
                        <a href="index.html" class="nav-brand"><img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/logo.png" alt=""></a>

                        <!-- Navbar Toggler -->
                        <div class="classy-navbar-toggler">
                            <span class="navbarToggler"><span></span><span></span><span></span></span>
                        </div>

                        <!-- Menu -->
                        <div class="classy-menu">

                            <!-- Close Button -->
                            <div class="classycloseIcon">
                                <div class="cross-wrap"><span class="top"></span><span class="bottom"></span></div>
                            </div>

                            <!-- Navbar Start -->
                            <div class="classynav">
                                <ul>
                                    <li><a href="index.html">Home</a></li>
                                    <li><a href="about.html">About</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="index.html">Home</a></li>
                                            <li><a href="about.html">About</a></li>
                                            <li><a href="shop.html">Shop</a>
                                                <ul class="dropdown">
                                                    <li><a href="shop.html">Shop</a></li>
                                                    <li><a href="shop-details.html">Shop Details</a></li>
                                                    <li><a href="cart.html">Shopping Cart</a></li>
                                                    <li><a href="checkout.html">Checkout</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="portfolio.html">Portfolio</a>
                                                <ul class="dropdown">
                                                    <li><a href="portfolio.html">Portfolio</a></li>
                                                    <li><a href="single-portfolio.html">Portfolio Details</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="blog.html">Blog</a>
                                                <ul class="dropdown">
                                                    <li><a href="blog.html">Blog</a></li>
                                                    <li><a href="single-post.html">Blog Details</a></li>
                                                </ul>
                                            </li>
                                            <li><a href="contact.html">Contact</a></li>
                                        </ul>
                                    </li>
                                    <li><a href="shop.html">Shop</a></li>
                                    <li><a href="portfolio.html">Portfolio</a></li>
                                    <li><a href="contact.html">Contact</a></li>
                                </ul>

                                <!-- Search Icon -->
                                <div id="searchIcon">
                                    <i class="fa fa-search" aria-hidden="true"></i>
                                </div>

                            </div>
                            <!-- Navbar End -->
                        </div>
                    </nav>

                    <!-- Search Form -->
                    <div class="search-form">
                        <form action="#" method="get">
                            <input type="search" name="search" id="search" placeholder="Type keywords &amp; press enter...">
                            <button type="submit" class="d-none"></button>
                        </form>
                        <!-- Close Icon -->
                        <div class="closeIcon"><i class="fa fa-times" aria-hidden="true"></i></div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- ##### Header Area End ##### -->

    <!-- ##### Breadcrumb Area Start ##### -->
    <div class="breadcrumb-area">
        <!-- Top Breadcrumb Area -->
        <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/bg-img/24.jpg);">
            <h2>Checkout</h2>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"><i class="fa fa-home"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Checkout</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Breadcrumb Area End ##### -->

    <!-- ##### Checkout Area Start ##### -->
    <div class="checkout_area mb-100">
        <div class="container">
            <div class="row justify-content-between">
                <div class="container-fluid">
                    <div class="checkout_details_area clearfix">
                        <h5>Order Details</h5>
                            <div class="row">
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
												<td>
												    <!-- 評價系統 -->
													<div class="star">
													    <span class="s-txt">產品評價：</span>
														    <span class="s-xxs">
														        <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
														    </span>
													    <span class="s-haoping">
														<em class="s-hp-triangle0">
													        </em><em class="s-hp-triangle1">
													        </em><span class="s-hp-txt">5分好評</span>
													    </span>
													</div>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table> 
								<div class="container">
									<div class="row">
										<div class="col-xs-12 col-sm-6">
										<div align="left">
										   
										</div>
										</div>
										<div class="col-xs-12 col-sm-6">
										<div align="right">
											<button type="button" class="btn btn-outline-success" onclick="returnpath()">回商城</button>
											<button type="button" value="<%= request.getAttribute("ord_no") %>" class="cancel btn btn-outline-danger">取消訂單</button> 
										</div>
										</div>
									</div>
								</div>           
								
                            </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <!-- ##### Checkout Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
<jsp:include page="/front-end/pro/alazea-gh-pages/CA105G1_footer.jsp"/>
    <!-- ##### Footer Area End ##### -->

    <!-- ##### All Javascript Files ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>

<!-- sweetalert-link -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />    
<!-- websock -->
<script src="<%=request.getContextPath() %>/back-end/pro/tool/websock_client.js"></script>       
    
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
								 console.log("取消");
								 window.location.replace("<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"); 
						     },
						     error: function(){alert("AJAX-class發生錯誤囉!")}
				         })
					})
				})
			});
			function creatQuerycancel(ord_no){
				var queryString= {"action":"ok_cancel", "ord_no":ord_no , "ord_status" :"取消"};
				return queryString;
			}
			function returnpath(){
				window.location.replace("<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"); 
			}
			//評價jquery
		    var isclick = false;
		    var arr = ["1分差評", "2分中評", "3分中評", "4分好評", "5分好評"];
		    var clickind = -1;

		    $(".s-xx").on("click", function() {
		        isclick = true;
		        clickind = $(this).index();
		    });
		    
		    $(".s-xx").hover(function() {
		        var ind = $(this).index();
		        $(this).siblings(".s-xx").removeClass("color-f13a3a");
		        for (var i = 0; i <= ind; i++) {
		            $(".s-xx").eq(i).addClass("color-f13a3a");
		            $(".s-haoping").siblings(".s-hp-txt").text(arr[i]).end().show();
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
		    function creatQueryAssess(){
		    	var queryString= {"action":"assess", "ord_no":ord_no , "ord_status" :"取消"};
				return queryString;
		    }
		    
		    function sendAssess(){
		    	alert("有跳出");
		    	$.ajax({
					 type: "POST",
					 url: "<%= request.getContextPath()%>/pro/pro.do",
					 async:false,
					 data: creatQueryAssess(val),
					 dataType: "json",
					 success: function (data){
//						 console.log("取消");
<%-- 						 window.location.replace("<%= request.getContextPath()%>/front-end/pro/listAllPro_front.jsp");  --%>
				     },
				     error: function(){alert("AJAX-class發生錯誤囉!")}
		         })
		    	
		    }
// 		    $(window).bind('beforeunload',function(){
		    	
		    	
// 		    	return '提示資訊';
// 		    	}
// 		    );
			
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