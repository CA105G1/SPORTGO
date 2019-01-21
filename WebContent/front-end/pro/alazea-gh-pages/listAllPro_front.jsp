<%@page import="com.product_like.model.Product_like_Service"%>
<%@page import="com.product.model.ProductAssessVO"%>
<%@page import="java.util.*"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="com.product.model.ProductService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%

	ProductService proSvc = new ProductService();
	List<ProductVO> list = new ArrayList<ProductVO>();
	List<ProductAssessVO> listAssess = new ArrayList<ProductAssessVO>();
	//判斷是不是複合查詢來的
	if ("findBy".equals(request.getAttribute("findBy"))) {
		list = (List<ProductVO>) request.getAttribute("pro_ByCompositeQuery");
		String pro_classid = (String)request.getAttribute("pro_classid");
		if(pro_classid == ""){
			listAssess = proSvc.getProAssess();  
		} else {
			listAssess = proSvc.getProAssesslike(pro_classid);
		}
	} else { 
		System.out.print("失敗");
		list = proSvc.getAllOnShelve();
		listAssess = proSvc.getProAssess();
	}
    pageContext.setAttribute("list",list);
    pageContext.setAttribute("listAssess",listAssess);
    
    
    

%>
<jsp:useBean id="proclassSvc" scope="page" class="com.productclass.model.ProductClassService" />
<jsp:useBean id="proSvclist" scope="page" class="com.product.model.ProductService" />
<jsp:useBean id="prolikeSvc" scope="page" class="com.product_like.model.Product_like_Service" />
<%-- <jsp:useBean id="productAssessVO" scope="page" class="com.product.model.ProductAssessVO" /> --%>
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

    <style type="text/css">
        .shop-products-area .pagination .page-item .page-link{
            width: 100px;
        }
    </style>
</head>

<body onload="connect();" onunload="disconnect();">

    <!-- Preloader -->
<!--     <div class="preloader d-flex align-items-center justify-content-center"> -->
<!--         <div class="preloader-circle"></div> -->
<!--         <div class="preloader-img"> -->
<%--             <img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png" alt=""> --%>
<!--         </div> -->
<!--     </div> -->

    <!-- ##### Header Area Start ##### -->
<!--    1 <header class="header-area"> -->

        <!-- ***** Top Header Area ***** -->
<%-- <jsp:include page="/front-end/pro/alazea-gh-pages/header.jsp"/>  --%>
        
<!-- <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-dark bg-dark"> -->
<%-- <img style="height: 20px;"src="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.png" alt="SportGo!"/> --%>
<%--   <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">SportGo!</a> --%>
<!--   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation"> -->
<!--     <span class="navbar-toggler-icon"></span> -->
<!--   </button> -->

<!--   <div class="collapse navbar-collapse" id="navbarTogglerDemo02"> -->
<!--     <ul class="navbar-nav mr-auto mt-2 mt-lg-0"> -->
<!--       <li class="nav-item active"> -->
<%--         <a class="nav-link" href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">揪團去 <span class="sr-only">(current)</span></a> --%>
<!--       </li> -->
<!--       <li class="nav-item"> -->
<%--         <a class="nav-link" href="<%=request.getContextPath()%>/front-end/club/club_list.jsp">社團</a> --%>
<!--       </li> -->
<!--       <li class="nav-item"> -->
<!--         <a class="nav-link disabled" href="#">Disabled</a> -->
<!--       </li> -->
<!--     </ul> -->
    
<!--       <div class="collapse navbar-collapse" id="navbarResponsive"> -->
<!--          <ul class="navbar-nav ml-auto"> -->
<!--              <li class="nav-item"> -->
<!--                  <a class="nav-link scroll-link" href="#top-content"><span class="oi oi-cart">購物車</span></a> -->
<!--              </li> -->
<%--            		<c:if test="${memberlistVO==null}"> --%>
<!-- 					<li> -->
<!-- 						<a class="nav-link" href="#">訪客，您好</a> -->
<!-- 					</li> -->
<!-- 					<li> -->
<%-- 						<% System.out.println("log_in_location :　"+ request.getRequestURI());%> --%>
<%-- 						<a href="<%=request.getContextPath()%>/front-end/memberlist/Login.jsp">登入/註冊</a> --%>
<!-- 					</li> -->
<%-- 				</c:if> --%>
<%--              	<c:if test="${!(memberlistVO==null)}"> --%>
<!-- 					<li class="nav-item"> -->
<%-- 						<a class="nav-link" href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp">${memberlistVO.mem_name}，您好</a> --%>
<!-- 					</li> -->
<!-- 					<li class="nav-item "> -->
<!-- 						<a class="nav-link" href="#" >通知</a> -->
<!-- 					</li> -->
<!-- 					<li class="nav-item"> -->
<%-- 						<% System.out.println("log_out_location :　"+ request.getRequestURI());%> --%>
<%-- 						<a class="nav-link" href="<%=request.getContextPath()%>/front-end/memberlist/logout.do">登出</a> --%>
<!-- 					</li> -->
<%-- 				</c:if> --%>
<!--              <li class="nav-item"> -->
<%--                  <a class="nav-link"  href="<%=request.getContextPath()%>/backEndIndex.jsp">後台首頁</a> --%>
<!--              </li> -->
<!--          </ul> -->
<!--      </div> -->
<!--   </div> -->
<!-- </nav> -->
<!--         <div class="top-header-area"> -->
<!--             <div class="container"> -->
<!--                 <div class="row"> -->
<!--                     <div class="col-12"> -->
<!--                         <div class="top-header-content d-flex align-items-center justify-content-between"> -->
<!--                             Top Header Content -->
<!--                             <div class="top-header-meta"> -->
<!--                                 <a href="#" data-toggle="tooltip" data-placement="bottom" title="infodeercreative@gmail.com"><i class="fa fa-envelope-o" aria-hidden="true"></i> <span>Email: infodeercreative@gmail.com</span></a> -->
<!--                                 <a href="#" data-toggle="tooltip" data-placement="bottom" title="+1 234 122 122"><i class="fa fa-phone" aria-hidden="true"></i> <span>Call Us: +1 234 122 122</span></a> -->
<!--                             </div> -->

<!--                             Top Header Content -->
<!--                             <div class="top-header-meta d-flex"> -->
<!--                                 Language Dropdown -->
<!--                                 <div class="language-dropdown"> -->
<!--                                     <div class="dropdown"> -->
<!--                                         <button class="btn btn-secondary dropdown-toggle mr-30" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Language</button> -->
<!--                                         <div class="dropdown-menu" aria-labelledby="dropdownMenuButton"> -->
<!--                                             <a class="dropdown-item" href="#">USA</a> -->
<!--                                             <a class="dropdown-item" href="#">UK</a> -->
<!--                                             <a class="dropdown-item" href="#">Bangla</a> -->
<!--                                             <a class="dropdown-item" href="#">Hindi</a> -->
<!--                                             <a class="dropdown-item" href="#">Spanish</a> -->
<!--                                             <a class="dropdown-item" href="#">Latin</a> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 Login -->
<!--                                 <div class="login"> -->
<!--                                     <a href="#"><i class="fa fa-user" aria-hidden="true"></i> <span>Login</span></a> -->
<!--                                 </div> -->
<!--                                 Cart -->
<!--                                 <div class="cart"> -->
<!--                                     <a href="#"><i class="fa fa-shopping-cart" aria-hidden="true"></i> <span>Cart <span class="cart-quantity">(1)</span></span></a> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->

        <!-- ***** Navbar Area ***** -->

<!--    1 </header> -->
    <!-- ##### Header Area End ##### -->
  <jsp:include page="/front-end/CA105G1_header_bt4.jsp" />
      <div class="breadcrumb-area">
        <!-- Top Breadcrumb Area -->
        <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/PN003.jpeg);">
            <h2>Shopping Home</h2>
        </div>
 
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"><i class="fa fa-home"></i> Home</a></li>
                           
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
<!-- 輪播 -->
<!--     <section class="hero-area"> -->
<!--         <div class="hero-post-slides owl-carousel"> -->

<!--             Single Hero Post -->
<!--             <div class="single-hero-post bg-overlay"> -->
<!--                 Post Image -->
<%--                 <div class="slide-img bg-img" style="background-image: url(<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/PN001.jpeg);"></div> --%>
<!--                 <div class="container h-100"> -->
<!--                     <div class="row h-100 align-items-center"> -->
<!--                         <div class="col-12"> -->
<!--                             Post Content -->
<!--                             <div class="hero-slides-content text-center"> -->
<!--                                 <h2>如果運動可以讓你更美更健康，你還會拒絕嗎？</p> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->

<!--             Single Hero Post -->
<!--             <div class="single-hero-post bg-overlay"> -->
<!--                 Post Image -->
<%--                 <div class="slide-img bg-img" style="background-image: url(<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/PN002.jpeg);"></div> --%>
<!--                 <div class="container h-100"> -->
<!--                     <div class="row h-100 align-items-center"> -->
<!--                         <div class="col-12"> -->
<!--                             Post Content -->
<!--                             <div class="hero-slides-content text-center"> -->
<!--                                 <h2>現在就加入運動的行列吧!</p> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
<!--             </div> -->

<!--         </div> -->
<!--     </section> -->
    <!-- ##### Breadcrumb Area End ##### -->

    <!-- ##### Shop Area Start ##### -->
    <section class="shop-page section-padding-0-100">
        <div class="container">
            <div class="row">
                <!-- Shop Sorting Data -->
                <div class="col-12">
                    <div class="shop-sorting-data d-flex flex-wrap align-items-center justify-content-between">
                        <!-- Shop Page Count -->
                        <div align="right" class="shop-page-count">
                            <p  id="showpage">Showing 1–9 of 72 results</p>
                        </div>
                        <!-- Search by Terms -->
<!--                         <div class="search_by_terms"> -->
<!--                             <form action="#" method="post" class="form-inline"> -->
<!--                                 <select class="custom-select widget-title"> -->
<!--                                   <option selected>Short by Popularity</option> -->
<!--                                   <option value="1">Short by Newest</option> -->
<!--                                   <option value="2">Short by Sales</option> -->
<!--                                   <option value="3">Short by Ratings</option> -->
<!--                                 </select> -->
<!--                                 <select class="custom-select widget-title"> -->
<!--                                   <option selected>Show: 9</option> -->
<!--                                   <option value="1">12</option> -->
<!--                                   <option value="2">18</option> -->
<!--                                   <option value="3">24</option> -->
<!--                                 </select> -->
<!--                             </form> -->
<!--                         </div> -->
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- Sidebar Area -->
                <div class="col-12 col-md-4 col-lg-3">
                    <div class="shop-sidebar-area">

                        <!-- Shop Widget -->
                        <div class="shop-widget price mb-50">
                            <h4 class="widget-title">Prices</h4>
                            <div class="widget-desc">
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
<!--                                     <label>商品編號:</label> -->
<!--                                     <input type="text" name="pro_no" class="form-control"> -->
                                    <label for="email">商品類別編號:</label>
                                    <select size="1" name="pro_classid" class="form-control">
                                        
                                          <option value="">
                                         <c:forEach var="proclassVO" items="${proclassSvc.all}" > 
                                          <option value="${proclassVO.pro_classid}">${proclassVO.pro_classname}
                                         </c:forEach>   
                                       
                                    </select>
                                    <label for="email">商品名稱:</label>
                                    <input type="text" name="pro_name" class="form-control">
                                    <label for="email">商品單價:</label>
                                    <input type="text" name="pro_bonus" class="form-control" placeholder="0~99999">
                                    <br>
                                    <center>
                                    <button type="submit" class="btn btn-outline-info">送出查詢</button>
                             		<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
								    <input type="hidden" name="action" value="pro_ByCompositeQuery">
                                    </center>
                                </FORM>
                            </div>
                        </div>

                       
                        <!-- Shop Widget -->
                        <div class="shop-widget best-seller mb-50">
                            <h4 class="widget-title">Best Seller</h4>
                            <div class="widget-desc">

                                <!-- Single Best Seller Products -->
                            <c:forEach var="AssessVO" items="${listAssess}">
                                <div class="single-best-seller-product d-flex align-items-center">
                                    <div class="product-thumbnail">
                                        <a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_front&requestURL=<%=request.getServletPath()%>&pro_no=${AssessVO.pro_no}"><img src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${AssessVO.pro_no}" alt=""></a>
                                    </div>
                                    <div class="product-info">
                                        <a href="shop-details.html">${proSvclist.getOneProduct(AssessVO.pro_no).pro_name}</a>
                                        <p>$ ${AssessVO.pro_bonus}</p>
                                        <div class="ratings">
<%--                                         <c:choose> --%>
<%--                                             <c:when test="${AssessVO.pro_trunc_assess == 5}"> --%>
<!--                                             <P>123</P> -->
<%--                                             </c:when> --%>
<%--                                         </c:choose> --%>
                                          <c:if test="${AssessVO.pro_trunc_assess eq 5}">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                          </c:if>
                                          <c:if test="${AssessVO.pro_trunc_assess eq 4}">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                          </c:if>
                                          <c:if test="${AssessVO.pro_trunc_assess eq 3}">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                          </c:if>
                                          <c:if test="${AssessVO.pro_trunc_assess eq 2}">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                          </c:if>
                                          <c:if test="${AssessVO.pro_trunc_assess eq 1}">
                                            <i class="fa fa-star"></i>
                                          </c:if>
                                           
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                                

                            </div>
                        </div>
                    </div>
                </div>

                <!-- All Products Area -->
                <div class="col-12 col-md-8 col-lg-9">
                    <div class="shop-products-area">
                        <div class="row">
 
<!------------------------------ 商品列表 Product Area -->
                            <%@ include file="/front-end/pro/page/page1_ByCompositeQuery_new.file" %>
                            <c:forEach var="proVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
                            <div class="col-12 col-sm-6 col-lg-4">
                                <div class="single-product-area mb-50">
                                    <!-- Product Image -->
                                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" id="${proVO.pro_no}" style="margin-bottom: 0px;">
                                    <div class="product-img">
                                        <img class="img-responsive" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proVO.pro_no}">
                                        <!-- Product Tag -->
                                        <div class="product-tag">
                                            <a href="#">Hot</a>
                                        </div>
                                        <div class="product-meta d-flex">
                                            <!-- 我的最愛 -->
                                            
	                                        <c:choose>
	                                            <c:when test="${prolikeSvc.getfindbyOne(proVO.pro_no,memberlistVO.mem_no).product_no == proVO.pro_no}">
	                                            <a href="#" onclick="tuchlike(this.id);" class="wishlist-btn like_${proVO.pro_no}" id="${proVO.pro_no}" style="background-color: #ffc342"><i class="icon_heart_alt"></i></a>
	                                            </c:when>
	                                            <c:otherwise>
                                           	 		<a href="#" onclick="tuchlike(this.id);" class="wishlist-btn like_${proVO.pro_no}" id="${proVO.pro_no}"><i class="icon_heart_alt"></i></a>
	                                            </c:otherwise>
	                                        </c:choose>
                                            <!-- 查看商品詳情 -->
                                            <a onclick="document.getElementById('${proVO.pro_no}').submit()" class="add-to-cart-btn">Add to cart</a>
                                            <input type="hidden" name="pro_no" value="${proVO.pro_no}">
	                                        <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
	                                        <input type="hidden" name="action" value="getOne_For_Display_front">
                                            <!-- 分享 -->
<!--                                             <a href="#" class="compare-btn"><i class="arrow_left-right_alt"></i></a> -->
                                        </div>
                                    </div>
                                    <!-- Product Info -->
                                    <div class="product-info mt-15 text-center">
                                        <a onclick="document.getElementById('${proVO.pro_no}').submit()">
                                            <p>${proVO.pro_name}</p>
                                        </a>
                                        <h6>$ ${proVO.pro_bonus}</h6>
                                    </div>
                                    </FORM>
                                </div>
                            </div>
                            </c:forEach>

                        <!-- Pagination -->
                        
               
                         <nav aria-label="Page navigation">
                            <ul class="pagination">
<%-- 							  <%if (rowsPerPage<rowNumber) {%> --%>
<%-- 							    <%if(pageIndex>=rowsPerPage){%> --%>
<%-- 							        <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/pro/pro.do?whichPage=1&action=pro_ByCompositeQuery&requestURL=<%=request.getServletPath()%>">first</a></li>; --%>
<%-- 							        <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/pro/pro.do?whichPage=<%=whichPage-1%>&action=pro_ByCompositeQuery&requestURL=<%=request.getServletPath()%>">上一頁 </a></li> --%>
<%-- 							    <%}%>  --%>
							  <%@ include file="/front-end/pro/page/page2_ByCompositeQuery_new.file" %>
<%-- 							    <%if(pageIndex<pageIndexArray[pageNumber-1]){%> --%>
<%-- 							        <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/pro/pro.do?whichPage=<%=whichPage+1%>&action=pro_ByCompositeQuery&requestURL=<%=request.getServletPath()%>">下一頁 </a></li>; --%>
<%-- 							        <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/pro/pro.do?whichPage=<%=pageNumber%>&action=pro_ByCompositeQuery&requestURL=<%=request.getServletPath()%>">last</a></li>; --%>
<%-- 							    <%}%> --%>
<%-- 							  <%}%>  --%>
                            </ul>
                        </nav>
                     


                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Shop Area End ##### -->

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
       		
	 			var mem_no_login = "${memberlistVO.mem_no}";
	 			console.log("mem_no_login"+mem_no_login);
			$(function() { 
	 			document.getElementById("showpage").innerHTML = "Showing "+ <%=rowNumber%>+" results"; 
			});
			
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
								 $('.like_'+clickid).css("background-color","#303030");
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