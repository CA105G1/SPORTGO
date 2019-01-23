<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	ProductService proSvc = new ProductService();
	//	ProductVO proVO = (ProductVO) request.getAttribute("proVO"); //EmpServlet.java(Concroller), 存入req的empVO物件
	ProductVO proVO = (ProductVO)session.getAttribute("proVO");
	List<ProductVO> list = proSvc.getAll();
	pageContext.setAttribute("list",list);
	
	List<ProductAssessVO> listAssess = new ArrayList<ProductAssessVO>();
	listAssess = proSvc.getProAssess();
	pageContext.setAttribute("listAssess",listAssess);
%>
<jsp:useBean id="proclassSvc" scope="page" class="com.productclass.model.ProductClassService" />
<jsp:useBean id="proSvclist" scope="page" class="com.product.model.ProductService" />
<jsp:useBean id="prolikeSvc" scope="page" class="com.product_like.model.Product_like_Service" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title -->
    <title>SportGO商城</title>

    <!-- Favicon -->
    <link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">

    <!-- Core Stylesheet -->
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
</head>

<body onload="connect();" onunload="disconnect();">




        <!-- ***** Top Header Area ***** -->
<%--   <jsp:include page="/front-end/CA105G1_header_bt4.jsp" /> --%>
      <jsp:include page="/front-end/pro/page/pro_header_bt4.jsp" />

    <!-- ##### Header Area End ##### -->

    <!-- ##### Breadcrumb Area Start ##### -->
    <div class="breadcrumb-area">
        <!-- Top Breadcrumb Area -->
        <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%=request.getContextPath()%>/InitDB/image/news/N001.jpeg);">
            <h2>SHOP DETAILS</h2>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"><i class="fa fa-home"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Shop</li>
<!--                             <li class="breadcrumb-item"><a href="#">Shopping cart</a></li> -->
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <!-- ##### Breadcrumb Area End ##### -->

<!-------------------------商品詳情 --------------------------------------->
<%--有問題 <c:forEach var="proVO" items="${list}"> --%>
    <!-- ##### Single Product Details Area Start ##### -->
    <section class="single_product_details_area mb-50">
        <div class="produts-details--content mb-50">
            <div class="container">
                <div class="row justify-content-between">

                    <div class="col-12 col-md-6 col-lg-5">
                        <div class="single_product_thumb">
                            <div id="product_details_slider" class="carousel slide" data-ride="carousel">
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <a class="product-img" href="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>" title="Product Image">
                                        <img class="d-block w-100" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>" alt="1">
                                    </a>
                                    </div>
                                    <div class="carousel-item">
                                        <a class="product-img" href="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>" title="Product Image">
                                        <img class="d-block w-100" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>" alt="1">
                                    </a>
                                    </div>
                                    <div class="carousel-item">
                                        <a class="product-img" href="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>" title="Product Image">
                                        <img class="d-block w-100" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>" alt="1">
                                    </a>
                                    </div>
                                </div>
                                <ol class="carousel-indicators">
                                    <li class="active" data-target="#product_details_slider" data-slide-to="0" style="background-image: url(<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>);">
                                    </li>
<%--                                     <li data-target="#product_details_slider" data-slide-to="1" style="background-image: url(<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>);"> --%>
<!--                                     </li> -->
<%--                                     <li data-target="#product_details_slider" data-slide-to="2" style="background-image: url(<%=request.getContextPath()%>/pro/proImg.do?pro_no=<%= proVO.getPro_no() %>);"> --%>
<!--                                     </li> -->
                                </ol>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-md-6">
                        <div class="single_product_desc">
                            <h4 class="title"><%=proVO.getPro_name()%></h4>
                            <h4 class="price">$<%=proVO.getPro_bonus()%></h4>
                            <input type="hidden"  id="pro_bonus" value="<%=proVO.getPro_bonus()%>"/>
                            <div class="short_overview">
                                <p style="font-size: 23px">庫存:<%=proVO.getPro_stock()%></p>
                                
                            </div>
                            <div class="products--meta">
                                <p><span>商品種類:</span> <span>${proclassSvc.getOneProductClass(proVO.pro_classid).pro_classname }</span></p>
                                <p><span>商品單價:</span> <span><%=proVO.getPro_bonus()%></span></p>
                                <p><span>商品規格:</span> <span><%=proVO.getPro_format()%> </span></p>
                                <p><span>商品庫存量:</span> <span><%=proVO.getPro_stock()%> </span></p>
                                <p><span>目前按讚分數:</span><span><%=proVO.getPro_all_assess()%>分</span></p>
                                <p><span>有多少人按讚:</span><span><%=proVO.getPro_all_assessman()%>人</span></p>
<!--                                 <p> -->
<!--                                     <span>Share on:</span> -->
<!--                                     <span> -->
<!--                                     <a href="#"><i class="fa fa-facebook"></i></a> -->
<!--                                     <a href="#"><i class="fa fa-twitter"></i></a> -->
<!--                                     <a href="#"><i class="fa fa-pinterest"></i></a> -->
<!--                                     <a href="#"><i class="fa fa-google-plus"></i></a> -->
<!--                                 </span> -->
<!--                                 </p> -->
                            </div>
                            <div class="cart--area d-flex flex-wrap align-items-center">
                                <!-- Add to Cart Form -->
                                <form class="cart clearfix d-flex align-items-center" method="post">
                                    <div class="quantity">
                                        <span id="min" class="qty-minus" value="-" ><i class="fa fa-minus" aria-hidden="true"></i></span>
                                        <input id="num" type="number" class="qty-text" id="qty" step="1" min="1" max="12" name="quantity" value="1">
                                        <span id="add" class="qty-plus" value="+"><i class="fa fa-plus" aria-hidden="true"></i></span>
                                    </div>
                                    <button id="btn1" type="button" name="addtocart" value="<%= proVO.getPro_no() %>" class="btn alazea-btn ml-15">Add to cart</button>
                                </form>
                                <!-- Wishlist & Compare -->
                                <div class="wishlist-compare d-flex flex-wrap align-items-center">
                             	            <c:choose>
	                                            <c:when test="${prolikeSvc.getfindbyOne(proVO.pro_no,memberlistVO.mem_no).product_no == proVO.pro_no}">
	                                            <a href="#" onclick="tuchlike(this.id);" class="wishlist-btn ml-15 like_${proVO.pro_no}" id="${proVO.pro_no}" style="background-color: #ffc342"><i class="icon_heart_alt"></i></a>
	                                            </c:when>
	                                            <c:otherwise>
                                           	 		<a href="#" onclick="tuchlike(this.id);" class="wishlist-btn ml-15 like_${proVO.pro_no}" id="${proVO.pro_no}"><i class="icon_heart_alt"></i></a>
	                                            </c:otherwise>
	                                        </c:choose>
<!--                                     <a href="#" class="compare-btn ml-15"><i class="arrow_left-right_alt"></i></a> -->
                                </div>
                            </div>



                        </div>
                    </div>
                </div>
                
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="product_details_tab clearfix">
                        <!-- Tabs -->
                        <ul class="nav nav-tabs" role="tablist" id="product-details-tab">
                            <li class="nav-item">
                                <a href="#description" class="nav-link active" data-toggle="tab" role="tab"></a>
                            </li>
                            <li class="nav-item">
                                <a href="#addi-info" class="nav-link" data-toggle="tab" role="tab">產品資訊</a>
                            </li>
                            <li class="nav-item">
<!--                                 <a href="#reviews" class="nav-link" data-toggle="tab" role="tab">Reviews <span class="text-muted">(1)</span></a> -->
                            </li>
                        </ul>
                        <!-- Tab Content -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane fade show active" id="description">
                                <div class="description_area">
                                    <p><%=proVO.getPro_details()%></p>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="addi-info">
                                <div class="additional_info_area">
                                    <p><%=proVO.getPro_details()%></p>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="reviews">
                                <div class="reviews_area">
                                    <ul>
                                        <li>
                                            <div class="single_user_review mb-15">
                                                <div class="review-rating">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <span>for Quality</span>
                                                </div>
                                                <div class="review-details">
                                                    <p>by <a href="#">Colorlib</a> on <span>12 Sep 2018</span></p>
                                                </div>
                                            </div>
                                            <div class="single_user_review mb-15">
                                                <div class="review-rating">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <span>for Design</span>
                                                </div>
                                                <div class="review-details">
                                                    <p>by <a href="#">Colorlib</a> on <span>12 Sep 2018</span></p>
                                                </div>
                                            </div>
                                            <div class="single_user_review">
                                                <div class="review-rating">
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <i class="fa fa-star" aria-hidden="true"></i>
                                                    <span>for Value</span>
                                                </div>
                                                <div class="review-details">
                                                    <p>by <a href="#">Colorlib</a> on <span>12 Sep 2018</span></p>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>

                                <div class="submit_a_review_area mt-50">
                                    <h4>Submit A Review</h4>
                                    <form action="#" method="post">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="form-group d-flex align-items-center">
                                                    <span class="mr-15">Your Ratings:</span>
                                                    <div class="stars">
                                                        <input type="radio" name="star" class="star-1" id="star-1">
                                                        <label class="star-1" for="star-1">1</label>
                                                        <input type="radio" name="star" class="star-2" id="star-2">
                                                        <label class="star-2" for="star-2">2</label>
                                                        <input type="radio" name="star" class="star-3" id="star-3">
                                                        <label class="star-3" for="star-3">3</label>
                                                        <input type="radio" name="star" class="star-4" id="star-4">
                                                        <label class="star-4" for="star-4">4</label>
                                                        <input type="radio" name="star" class="star-5" id="star-5">
                                                        <label class="star-5" for="star-5">5</label>
                                                        <span></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <label for="name">Nickname</label>
                                                    <input type="email" class="form-control" id="name" placeholder="Nazrul">
                                                </div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <div class="form-group">
                                                    <label for="options">Reason for your rating</label>
                                                    <select class="form-control" id="options">
                                                          <option>Quality</option>
                                                          <option>Value</option>
                                                          <option>Design</option>
                                                          <option>Price</option>
                                                          <option>Others</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <div class="form-group">
                                                    <label for="comments">Comments</label>
                                                    <textarea class="form-control" id="comments" rows="5" data-max-length="150"></textarea>
                                                </div>
                                            </div>
                                            <div class="col-12">
                                                <button type="submit" class="btn alazea-btn">Submit Your Review</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<%--有問題 </c:forEach> --%>
    <!-- ##### Single Product Details Area End ##### -->

    <!-- ##### Related Product Area Start ##### -->
    <div class="related-products-area">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <!-- Section Heading -->
                    <div class="section-heading text-center">
                        <h2>Related Products</h2>
                    </div>
                </div>
            </div>

            <div class="row">

                <!-- Single Product Area -->
                <c:forEach var="AssessVO" items="${listAssess}">
               
	                <div class="col-12 col-sm-6 col-lg-3">
	                    <div class="single-product-area mb-100">
	                        <!-- Product Image -->
	                        <div class="product-img">
	                            <a href="#"><img src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${AssessVO.pro_no}" alt=""></a>
	                            <!-- Product Tag -->
	                            <div class="product-tag">
	                                <a href="#">Hot</a>
	                            </div>
	                            <div class="product-meta d-flex">
	                                <a href="#" class="wishlist-btn"><i class="icon_heart_alt"></i></a>
	                                <a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_front&requestURL=<%=request.getServletPath()%>&pro_no=${AssessVO.pro_no}"  id="${AssessVO.pro_no}" class="add-to-cart-btn">Add to cart</a>
<!-- 	                                <a href="#" class="compare-btn"><i class="arrow_left-right_alt"></i></a> -->
	                            </div>
	                        </div>
	                        <!-- Product Info -->
	                        <div class="product-info mt-15 text-center">
	                            <a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listOnePro_front.jsp">
	                                <p>${proSvclist.getOneProduct(AssessVO.pro_no).pro_name}</p>
	                            </a>
	                            <h6>$ ${AssessVO.pro_bonus}</h6>
	                        </div>
	                    </div>
	                </div>
	            
                </c:forEach>
              

            </div>
        </div>
    </div>
    <!-- ##### Related Product Area End ##### -->

    <!-- ##### Footer Area Start ##### -->
<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />
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
    		var mem_no_login = "<%= session.getAttribute("memberlistVO")%>";
			$(function(){
//*****************************計算格
				//設置數量框不可手動填寫（此處為避免不必要的操作失誤）
	            $("#num").prop("disabled", true);

				var t = $("#num");
				$("#add").click(function(){	

					if(t.val() == <%=proVO.getPro_stock()%>){
						$(this).prop("disabled", true);
					}else{
						t.val(parseInt(t.val())+1);
					}
					// setTotal();
				})
				$("#min").click(function(){
					if (parseInt(t.val())>1) {                     //判斷數量值大于1時才可以減少
		                t.val(parseInt(t.val())-1)
		                }else{
		                $("#min").attr("disabled","disabled")        //當$("#min")為1時，$("#min")不可讀狀態
		               }
					$(this).siblings("#add").prop("disabled", false);
					// setTotal();
				})
				$("#num").keyup(function(){
					t.val(parseInt(t.val()))
				})
				
//***************************** 加入購物車 
				var proVO = "<%= session.getAttribute("proVO")%>";
				
				
				$("#btn1").on('click', function () {
					if(mem_no_login == "null"){
						<%session.setAttribute("location", request.getRequestURI());%>  
						swal({
						    title: '尚未登入',
						    text: '請先登入會員。'
						}).then(
						    function () {
						    console.log("<%= request.getContextPath()%>/front-end/memberlist/Login.jsp");
 					    	window.location.replace("<%= request.getContextPath()%>/front-end/memberlist/Login.jsp");
						    }
						)
						
					} else {
					$.ajax({
						 type: "POST",
						 url: "<%= request.getContextPath()%>/shoppingCartServlet/shoppingCartServlet.do",
						 data: creatQueryString($(this).val(), $('#num').val() , $('#pro_bonus').val()),
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
					}
			    });
				function creatQueryString(buttonid,pro_count,pro_bonus){
					
					var queryString= {"action":"insert", "pro_no":buttonid, "pro_count":pro_count ,"pro_bonus":pro_bonus};
					console.log(queryString);
					return queryString;
				}

				
				
				
				// function setTotal(){
				// 	$("#total").html((parseInt(t.val())*3.95).toFixed(2));
				// }
				// setTotal();
			});
			// function returnvalue(){
			// 	$("#returnValue").html((parseInt(t.val())).toFixed(2));
			// }
//*****************************加入收藏
				function tuchlike(clicked_id){
					var clickid = clicked_id;
					if(mem_no_login ===""){
						console.log("test"+mem_no_login);
						<%session.setAttribute("location", request.getRequestURI());%>  
						swal({
						    title: '尚未登入',
						    text: '請先登入會員。'
						}).then(
						    function () {
						    console.log("<%= request.getContextPath()%>/front-end/memberlist/Login.jsp");
						    	window.location.replace("<%= request.getContextPath()%>/front-end/memberlist/Login.jsp");
						    }
						)
						
					}else{
						console.log($('.like_'+clickid).css("background-color"));
						console.log($('.like_'+clickid).css("color") == "rgb(255, 0, 0)");
						if($('.like_'+clickid).css("background-color") == "rgb(255, 195, 66)"){
							console.log("我是紅色")
							//取消讚
							$.ajax({
								 type: "POST",
								 url: "<%= request.getContextPath()%>/prolike/prolike.do",
								 data: deletelike(mem_no_login,clicked_id),
								 dataType: "json",
								 success: function (data){
									 $('.like_'+clickid).css("background-color","#f2f4f5");
							     },
							     error: function(){alert("AJAX-class發生錯誤囉!")}
							});
						} else {
							//加入讚
							$.ajax({
								 type: "POST",
								 url: "<%= request.getContextPath()%>/prolike/prolike.do",
								 data: addlike(mem_no_login,clicked_id),
								 dataType: "json",
								 success: function (data){
									 $('.like_'+clickid).css("background-color","rgb(255, 195, 66)");
							     },
							     error: function(){alert("AJAX-class發生錯誤囉!")}
					         });
					         
						}
					}
					
				}
				function addlike(mem_no_login,clicked_id){
					var queryString= {"action":"insert" , "mem_no":mem_no_login , "pro_no":clicked_id};
				    console.log(queryString);
					return queryString;
				}
				function deletelike(mem_no_login,clicked_id){
					var queryString= {"action":"delete" , "mem_no":mem_no_login , "pro_no":clicked_id};
				    console.log(queryString);
					return queryString;
				}



		</script>
</body>

</html>