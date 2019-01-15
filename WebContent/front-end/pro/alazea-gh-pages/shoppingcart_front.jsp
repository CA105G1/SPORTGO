<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	List<ProductVO> proVOList = (List<ProductVO>) request.getAttribute("proVOList");
// 	Map<String , String> pro_countMap = (Map<String , String>) request.getAttribute("hAll");
    

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>SportGO購物車</title>

    <!-- Favicon -->
    <link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
        <style type="text/css">
    .panel {
      background-color: #F5F5F7;
      border: 1px solid #ddd;
      padding: 20px;
      display: block;
      width: 400px;
      border-radius: 6px;
      box-shadow: 0 2px 4px rgba(0,0,0,.1);
    }
    .btncard {
      background: rgb(68,175,231); /* Old browsers */
      background: -moz-linear-gradient(top, rgba(68,175,231,1) 0%, rgba(49,152,223,1) 100%); /* FF3.6-15 */
      background: -webkit-linear-gradient(top, rgba(68,175,231,1) 0%,rgba(49,152,223,1) 100%); /* Chrome10-25,Safari5.1-6 */
      background: linear-gradient(to bottom, rgba(68,175,231,1) 0%,rgba(49,152,223,1) 100%); /* W3C, IE10+, FF16+, Chrome26+, Opera12+, Safari7+ */
      filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#44afe7', endColorstr='#3198df',GradientType=0 );
      color: #fff;
      display: block;
      width: 100%;
      border: 1px solid rgba(46, 86, 153, 0.0980392);
      border-bottom-color: rgba(46, 86, 153, 0.4);
      border-top: 0;
      border-radius: 4px;
      font-size: 17px;
      text-shadow: rgba(46, 86, 153, 0.298039) 0px -1px 0px;
      line-height: 34px;
      -webkit-font-smoothing: antialiased;
      font-weight: bold;
      margin-top: 20px;
    }

    .btn:hover {
      cursor: pointer;
    }
        </style>
    
    
</head>

<body>
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
                                    <li><a href="">Home</a></li>
                                    <li><a href="about.html">About</a></li>
                                    <li><a href="#">Pages</a>
                                        <ul class="dropdown">
                                            <li><a href="">Home</a></li>
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
            <h2>Cart</h2>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"><i class="fa fa-home"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Cart</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Breadcrumb Area End ##### -->

    <!-- ##### Cart Area Start ##### -->
    <FORM METHOD="post" id="form-id" ACTION="<%= request.getContextPath()%>/ord/ord.do" name="form1" enctype="multipart/form-data">
    <div class="cart-area section-padding-0-100 clearfix">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="cart-table clearfix">
    					<c:if test="${not empty errorMsgs}">
							<font style="color:red">請修正以下錯誤:</font>
							<ul>
								<c:forEach var="message" items="${errorMsgs}">
									<li style="color:red">${message}</li>
								</c:forEach>
							</ul>
						</c:if>
                        <table class="table table-responsive">
                            <thead>
                                <tr>
                                    <th>Products</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>TOTAL</th>
                                    <th>test</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="proVO" items="${proVOList}">
                                <tr>
                                    <td class="cart_product_img">
                                        <div class="custom-control custom-checkbox d-flex align-items-center mb-2">
		                                    <input type="checkbox" class="custom-control-input box" id="customCheck2" name="pro_no"  value="${proVO.pro_no}">
		                                    <label class="custom-control-label" for="customCheck2"></label>
		                                </div>
<%--                                     	<input type="checkbox" name="pro_no" value="${proVO.pro_no}" class="box"> --%>
                                        <a href="#"><img src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proVO.pro_no}" alt="Product"></a>
                                        <h5>${proVO.pro_name}</h5>
                                    </td>
                                    <td class="qty">
                                        <div class="quantity">
                                            <span class="qty-minus reduce" value="-"><i class="fa fa-minus" aria-hidden="true"></i></span>
                                            <input type="number" class="qty-text textNum" id="qty" value="${hAll[proVO.pro_no]}" name="quantity" size="1">
                                            <span class="qty-plus add" value="+"><i class="fa fa-plus" aria-hidden="true"></i></span>
                            				<input type="text" class="return_mem_no" value="<%=session.getAttribute("mem_no")%>" style="display: none;"/>
							                <input type="text" class="return_pro_no" value="${proVO.pro_no}" style="display: none;"/>
							                <input type="text" class="return_pro_bonus" value="${proVO.pro_bonus}" style="display: none;"/>
							                <input class="danjia" value="" style="display: none;"/>
							                
                                        </div>
                                    </td>
                                    <td class="price"><span>$</span>${proVO.pro_bonus}</td>
                                    <td class="total_price">$<span id="${proVO.pro_no}" class="sumTheNumber">${hAll[proVO.pro_no] * proVO.pro_bonus}</span></td>
<%--                                     <td><i class="icon_close"></i><input type="hidden" value="${proVO.pro_no}"></div></td> --%>
                                    <td><button type="button" class="btn btn-outline-danger" value="${proVO.pro_no}"  >刪除</button></td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
     					<input type="button" class="btn btn-outline-primary" name="name" value="全選" id="allSelect" />
   						<input type="button" class="btn btn-outline-secondary" name="name" value="取消全選" id="notSelect" />
                    </div>
                </div>
            </div>

            <div class="row">

                <!-- Coupon Discount -->
                <div class="col-12 col-lg-6">
<!--                     測試<div class="cart-totals-area mt-70"> -->
<!--                         <h5 class="title--">收貨資訊</h5> -->
<!--                         <div class="shipping d-flex justify-content-between"> -->

                        
<%--                             <img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=<%=session.getAttribute("mem_no")%>"  --%>
<!--                             style="max-width:100px;max-height:100px;margin-right: 10px;" class="rounded-circle"> -->
<!--                             <div class="container"> -->
<!-- 							    <div class="row"> -->
<!-- 							        <div class="col-xs-12 col-sm-12"> -->
<!-- 			                        	<div class="checkout_details_area clearfix"> -->
<!-- 			                        	    <div class="container"> -->
<!-- 											    <div class="row"> -->
<!-- 											        <div class="col-xs-12 col-sm-12"></div> -->
<!-- 											    </div> -->
<!-- 											</div> -->
<!-- 									        <div class="col-md-10 mb-4"> -->
<!-- 			                                    <label for="first_name">Name *</label> -->
<%-- 			                                    <input type="text" placeholder="   收件人姓名" name="address_receiver" value="${param.receiver}"> --%>
<!-- 			                                </div> -->
<!-- 			                                <div class="col-md-10 mb-4"> -->
<!-- 			                                    <label for="first_name">Name *</label> -->
<%-- 			                                    <input type="text"  placeholder="   收件人電話" name="address_phone" value="${param.phone}"> --%>
<!-- 			                                </div> -->
<!-- 			                                <div class="col-md-10 mb-4"> -->
<!-- 			                                    <label for="first_name">Name *</label> -->
<%-- 			                                    <input type="text" placeholder="   國家" name="address_country" value="${param.country}"> --%>
<!-- 			                                </div> -->
<!-- 			                                <div class="col-md-10 mb-4"> -->
<!-- 			                                    <label for="first_name">Name *</label> -->
<%-- 			                                    <input type="text"   placeholder="   城市" name="address_city" value="${param.city}"> --%>
<!-- 			                                </div> -->
<!-- 			                                <div class="col-md-10 mb-4"> -->
<!-- 			                                    <label for="first_name">Name *</label> -->
<%-- 			                                    <input type="text"   placeholder="   地址" name="address_detail" value="${param.detail}"> --%>
<!-- 			                                </div> -->
<!-- 			                                <div class="col-md-10 mb-4"> -->
<!-- 			                                    <label for="first_name">Name *</label> -->
<%-- 			                                    <input type="text"  placeholder="郵遞區號" name="address_zip" value="${param.zip}"> --%>
<!-- 			                                </div> -->
<!-- 			　　　　　　　　　　　　　　		</div> -->
<!--                                     </div> -->
<!-- 							    </div> -->
<!-- 							</div> -->
<!--                         </div> -->
<!--                     </div> -->
                    <div class="cart-totals-area mt-70">
                        <h5 class="title--">收貨資訊</h5>
                        <div class="shipping d-flex justify-content-between">
                            <img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=<%=session.getAttribute("mem_no")%>" 
                            style="max-width:100px;max-height:100px;margin-right: 10px;" class="rounded-circle">
                            <div class="shipping-address">
                                    <input type="text"  placeholder="收件人姓名" name="address_receiver" value="${param.receiver}">
                                    <input type="text"  placeholder="收件人電話" name="address_phone" value="${param.phone}">
                                    <input type="text"  placeholder="國家" name="address_country" value="${param.country}">
                                    <input type="text"  placeholder="城市" name="address_city" value="${param.city}">
                                    <input type="text"  placeholder="地址" name="address_detail" value="${param.detail}">
                                    <input type="text"  placeholder="郵遞區號" name="address_zip" value="${param.zip}">

                            </div>
                        </div>

                    </div>
                </div>

                <!-- Cart Totals -->
                <div class="col-12 col-lg-6">
                    <div class="cart-totals-area mt-70">
                        <h5 class="title--">信用卡付款</h5>
                        <div class="shipping d-flex justify-content-between">
                            <h5>請輸入卡號：</h5>
                                <div class="checkout-btn panel">                
	                              <div class="card-js stripe" data-stripe="true"></div>
<!--------------------------------<button class="btncard" onclick="document.getElementById('form-id').submit();"><div id="testnum"></div></button> -->
	                              <input type="hidden" name="ord_amount" value="test">
	                              <input type="hidden" name="action" value="insert">
	                         	</div>
                        </div>
                        <div class="total d-flex justify-content-between">
                            <h5>Total</h5>
                            <h5 id="testnumtwo"></h5>
                        </div>
                        
                            <a id="testnum" onclick="document.getElementById('form-id').submit();" class="btn alazea-btn w-100"></a>
                        

                            
                    </div>
                </div>
            </div>

        </div>
    </div>
    </FORM>
    <!-- ##### Cart Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
    <footer class="footer-area bg-img" style="background-image: url(<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/bg-img/3.jpg);">
        <!-- Main Footer Area -->
        <div class="main-footer-area">
            <div class="container">
                <div class="row">

                    <!-- Single Footer Widget -->
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="single-footer-widget">
                            <div class="footer-logo mb-30">
                                <a href="#"><img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/logo.png" alt=""></a>
                            </div>
                            <p>Lorem ipsum dolor sit samet, consectetur adipiscing elit. India situs atione mantor</p>
                            <div class="social-info">
                                <a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                                <a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                            </div>
                        </div>
                    </div>

                    <!-- Single Footer Widget -->
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="single-footer-widget">
                            <div class="widget-title">
                                <h5>QUICK LINK</h5>
                            </div>
                            <nav class="widget-nav">
                                <ul>
                                    <li><a href="#">Purchase</a></li>
                                    <li><a href="#">FAQs</a></li>
                                    <li><a href="#">Payment</a></li>
                                    <li><a href="#">News</a></li>
                                    <li><a href="#">Return</a></li>
                                    <li><a href="#">Advertise</a></li>
                                    <li><a href="#">Shipping</a></li>
                                    <li><a href="#">Career</a></li>
                                    <li><a href="#">Orders</a></li>
                                    <li><a href="#">Policities</a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>

                    <!-- Single Footer Widget -->
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="single-footer-widget">
                            <div class="widget-title">
                                <h5>BEST SELLER</h5>
                            </div>

                            <!-- Single Best Seller Products -->
                            <div class="single-best-seller-product d-flex align-items-center">
                                <div class="product-thumbnail">
                                    <a href="shop-details.html"><img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/bg-img/4.jpg" alt=""></a>
                                </div>
                                <div class="product-info">
                                    <a href="shop-details.html">Cactus Flower</a>
                                    <p>$10.99</p>
                                </div>
                            </div>

                            <!-- Single Best Seller Products -->
                            <div class="single-best-seller-product d-flex align-items-center">
                                <div class="product-thumbnail">
                                    <a href="shop-details.html"><img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/bg-img/5.jpg" alt=""></a>
                                </div>
                                <div class="product-info">
                                    <a href="shop-details.html">Tulip Flower</a>
                                    <p>$11.99</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Single Footer Widget -->
                    <div class="col-12 col-sm-6 col-lg-3">
                        <div class="single-footer-widget">
                            <div class="widget-title">
                                <h5>CONTACT</h5>
                            </div>

                            <div class="contact-information">
                                <p><span>Address:</span> 505 Silk Rd, New York</p>
                                <p><span>Phone:</span> +1 234 122 122</p>
                                <p><span>Email:</span> info.deercreative@gmail.com</p>
                                <p><span>Open hours:</span> Mon - Sun: 8 AM to 9 PM</p>
                                <p><span>Happy hours:</span> Sat: 2 PM to 4 PM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer Bottom Area -->
        <div class="footer-bottom-area">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <div class="border-line"></div>
                    </div>
                    <!-- Copywrite Text -->
                    <div class="col-12 col-md-6">
                        <div class="copywrite-text">
                            <p>&copy; <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
</p>
                        </div>
                    </div>
                    <!-- Footer Nav -->
                    <div class="col-12 col-md-6">
                        <div class="footer-nav">
                            <nav>
                                <ul>
                                    <li><a href="#">Home</a></li>
                                    <li><a href="#">About</a></li>
                                    <li><a href="#">Service</a></li>
                                    <li><a href="#">Portfolio</a></li>
                                    <li><a href="#">Blog</a></li>
                                    <li><a href="#">Contact</a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
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
    
    <!-- 信用卡 -->
<link href="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.js"></script>

			<script type="text/javascript">
				$(document).ready(function(){
					//用遍歷計算總價
					$('#testnum').html('Pay $');
					getTotals();
					//計算總價，編寫總價方法(尚未用到)
		            function totalPrice() {
		                var zong = 0;
		                $(".xiaoji").each(function () {
		                    var all = parseInt($(this).text());
		                    zong += all;
		                })
		                $("#heji").val(zong);
		            };

		            //設置數量框不可手動填寫（此處為避免不必要的操作失誤）
		            $(".textNum").prop("disabled", true);
                    //當商品庫存量剛好為1時
		            //減號邏輯
		            $(".reduce").click(function () {
		                var num = $(this).siblings(".textNum").val();  //獲取數量框裏的數值
		                var mem_no = $(this).siblings(".return_mem_no").val();//獲取session的當前編號
		                var pro_no =  $(this).siblings(".return_pro_no").val();//獲取pro_no選擇的商品
		                var pro_bonus = $(this).siblings(".return_pro_bonus").val();//獲取pro_bonus商品單價
		                if(num != 1){//數量為1時不能遞減
		                num--;  //單擊“-”減號時，數量遞減
		                	$(this).siblings(".textNum").val(num); //把數量變化後的新值放入數量框中
		                }
			                $.ajax({
								 type: "POST",
								 url: "<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do",
								 data: subtraction(mem_no,pro_no,num,pro_bonus),
								 dataType: "json",
								 success: function (data){
									 $('#'+data.pro_no).html(data.pro_bonus);
									 getTotals();
							     },
							     error: function(){alert("AJAX-class發生錯誤囉!")}
					         })
		                if (num < ${proVO.pro_stock}){  //當庫存數量大於購買數量時解除封鎖狀態
		                	$(this).siblings(".add").prop("disabled", false);
		                }
		                if (num <= 1) {
		                    $(this).prop("disabled", true); //當輸入框內數值為0時，使“-”減號處於不可用狀態。
		                };
		                var danjia = $(this).siblings(".danjia").text(); //獲取單價
		                var xiaoji = danjia * num; //用單價乘以數量計算得到單個小計的值
		                $(this).siblings(".xiaoji").text(xiaoji); //把得到的小計值放入數量框中顯示
		                totalPrice();//調用“總價”方法，使每點擊減號，數量變化時，總價跟着變化
		                
		            });

		            //加號邏輯（邏輯如同減號的邏輯差不多）
		            $(".add").click(function () {
		                var num = $(this).siblings(".textNum").val();
		                var mem_no = $(this).siblings(".return_mem_no").val();//獲取session的當前編號
		                var pro_no =  $(this).siblings(".return_pro_no").val();//獲取pro_no選擇的商品
		                var pro_bonus = $(this).siblings(".return_pro_bonus").val();//獲取pro_bonus商品單價
		                if (num == ${proVO.pro_stock}){ //當庫存數量小於購買數量時封鎖狀態
				        	$(this).prop("disabled", true);
		                    return;
		                }
		                num++;
		                $(this).siblings(".textNum").val(num);
		                
			                $.ajax({
								 type: "POST",
								 url: "<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do",
								 data: subtraction(mem_no,pro_no,num,pro_bonus),
								 dataType: "json",
								 success: function (data){
									 $('#'+data.pro_no).html(data.pro_bonus);
									 getTotals();
							     },
							     error: function(){alert("AJAX-class發生錯誤囉!")}
					         })
				        
		                if (num > 0) {
		                    $(this).siblings(".reduce").prop("disabled", false); //判斷當輸入框內數值大於0，使“-”減號處於解封可用狀態。
		                };
		                var danjia = $(this).siblings(".danjia").text();
		                var xiaoji = danjia * num;
		                $(this).siblings(".xiaoji").text(xiaoji);
		                totalPrice();
		                
		            });
				            
		            //全選
		            $("#allSelect").click(function () {
		                $(".box").prop("checked", true);
		            });
		
		            //取消全選
		            $("#notSelect").click(function () {
		                $(".box").prop("checked", false);
		            });		            
		            
		            
					
					//-------------------------------------------------------------------------
					$('.deletedata').each( function() {
						$(this).click( function() {
							var val = $(this).next().val();
							$.ajax({
								 type: "POST",
								 url: "<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do",
								 data: creatQueryString(val, ""),
								 dataType: "json",
								 success: function (data){
									 window.location.replace("<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do?action=getAll_For_Display"); 
							     },
							     error: function(){alert("AJAX-class發生錯誤囉!")}
					         });
						});
					});
                                   
				});
				function subtraction(mem_no,pro_no,num,pro_bonus){  //數量加減時帶回去controller處理
					var queryString= {"action":"insert","mem_no":mem_no, "pro_no":pro_no,"pro_count":num,"pro_bonus":pro_bonus};
					return queryString;
				}
				
				function creatQueryString(buttonid){  //刪除
					var queryString= {"action":"delete", "pro_no":buttonid};
				    console.log(queryString);
					return queryString;
				}
				
				
				function getTotals(){  //總計的計算用遍歷的方式
					var total = 0;
					$(".sumTheNumber").each(function(e){
						total += parseInt($(this).text());
						console.log(parseInt($(this).text()));
						$('#testnum').html('Pay $'+total);
						$('#testnumtwo').html('$'+total);
					});
				}
				
				
			</script>		
</body>

</html>