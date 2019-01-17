<%@page import="java.util.*"%>
<%@page import="com.product.model.ProductVO"%>
<%@page import="com.product.model.ProductService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%

	ProductService proSvc = new ProductService();
	List<ProductVO> list = new ArrayList<ProductVO>();
	if ("findBy".equals(request.getAttribute("findBy"))) {
		list = (List<ProductVO>) request.getAttribute("pro_ByCompositeQuery");
	} else {
		list = proSvc.getAllOnShelve();
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
	<title>SportGO商城</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- sweetalert-link -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<!-- 按鈕cdn -->
    <link type="text/css" rel="stylesheet" href="http://cdn.bootcss.com/font-awesome/4.6.3/css/font-awesome.min.css">
<%--     <script src="<%=request.getContextPath() %>/front-end/pro/tool/font-awesome.css"></script> --%>
	<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	<style type="text/css">
		.swal-wide{
		    width:850px !important;
		}
		.aa {
			height: 300px;
			background-color: #faa;
		}

		.bb {
			height: 300px;
			background-color: #afa;
		}

		.cc {
			height: 300px;
			background-color: #aaf;
		}

		.dd {
			height: 300px;
			background-color: #aaa;
		}

		.test {
			background-color: #aba;
		}
         .img-responsive {
			width: 100%;
			max-width: 400px;
		}
		.prosize{

		}
		td{
			width: 277px;
			height: 400px;
			vertical-align: text-top; /*內容置上*/
			padding: 8px;  /*td間距*/
			float:left;  /*可以不設tr*/
		}
		table{
			/*margin-left:auto; 
			margin-right:auto;*/
			width: 1109px;

		}
/*********按鈕的css************/
/* h1 {  */
/*     font-size: 30px;  */
/*     font-family: 'Microsoft YaHei','Lantinghei SC','Open Sans',Arial,'Hiragino Sans GB','STHeiti','WenQuanYi Micro Hei','SimSun',sans-serif;  */
/* }  */
/* .pad-15{  */
/*     padding: 15px 0;  */
/* }  */

/* .btn{  */
/*     color: #fff;  */
/*     text-transform: uppercase;  */
/*     border-radius: 0;  */
/*     padding-left: 60px;  */
/*     position: relative;  */
/*     transform: translateZ(0px);  */
/*     transition: all 0.5s ease 0s;  */
/*     font-family: 'Microsoft YaHei','Lantinghei SC','Open Sans',Arial,'Hiragino Sans GB','STHeiti','WenQuanYi Micro Hei','SimSun',sans-serif;  */
/* }  */
/* .btn:after{  */
/*     content: "";  */
/*     position: absolute;  */
/*     top: 0;  */
/*     left: 0;  */
/*     bottom: 0;  */
/*     right: 0;  */
/*     background: #fff;  */
/*     z-index: -1;  */
/*     transform: scaleX(0);  */
/*     transform-origin: 100% 50% 0;  */
/*     transition: all 0.5s ease-out 0s;  */
/* }  */
/* .btn:hover:after{  */
/*     transform: scaleX(1);  */
/*     transition-timing-function: cubic-bezier(0.52, 1.64, 0.37, 0.66);  */
/* }  */
/* .btn span{  */
/*     width: 40px;  */
/*     height: 100%;  */
/*     line-height: 45px;  */
/*     background: #fff;  */
/*     position: absolute;  */
/*     top: 0;  */
/*     left: 0;  */
/*     transition: all 0.3s linear 0s;  */
/* }  */
/* .btn span:after{  */
/*     content: "";  */
/*     display: block;  */
/*     width: 10px;  */
/*     height: 10px;  */
/*     background: #fff;  */
/*     margin: auto 0;  */
/*     position: absolute;  */
/*     top: 0;  */
/*     right: -5px;  */
/*     bottom: 0;  */
/*     transform: rotate(45deg);  */
/*     transition: all 0.3s linear 0s;  */
/* }  */
/* .btn.btn-sm{  */
/*     padding-left: 40px;  */
/* }  */
/* .btn.btn-sm span{  */
/*     width: 27px;  */
/*     line-height: 30px;  */
/* }  */
/* .btn.btn-sm span:after{  */
/*     width: 8px;  */
/*     height: 8px;  */
/*     right: -4px;  */
/* }  */
/* .btn.btn-xs{  */
/*     padding-left: 30px;  */
/* }  */
/* .btn.btn-xs span{  */
/*     width: 20px;  */
/*     line-height: 23px;  */
/* }  */
/* .btn.btn-xs span:after{  */
/*     width: 7px;  */
/*     height: 7px;  */
/*     right: -3px;  */
/* }  */
/* .btn.red{  */
/*     border: 1px solid #fe6d6d;  */
/*     background: #fe6d6d;  */
/* }  */
/* .btn.red:hover,  */
/* .btn.red span{  */
/*     color: #fe6d6d;  */
/* }  */
/* .btn.red:hover span,  */
/* .btn.red:hover span:after{  */
/*     background: #fe6d6d;  */
/* }  */
/* .btn.blue{  */
/*     border: 1px solid #3bb4e5;  */
/*     background: #3bb4e5;  */
/* }  */
/* .btn.blue:hover,  */
/* .btn.blue span{  */
/*     color: #3bb4e5;  */
/* }  */
/* .btn.blue:hover span,  */
/* .btn.blue:hover span:after{  */
/*     background: #3bb4e5;  */
/* }  */
/* .btn.orange{  */
/*     border: 1px solid #ee955b;  */
/*     background: #ee955b;  */
/* }  */
/* .btn.orange:hover,  */
/* .btn.orange span{  */
/*     color: #ee955b;  */
/* }  */
/* .btn.orange:hover span,  */
/* .btn.orange:hover span:after{  */
/*     background: #ee955b;  */
/* }  */
/* .btn.green{  */
/*     border: 1px solid #79d799;  */
/*     background: #79d799;  */
/* }  */
/* .btn.green:hover,  */
/* .btn.green span{  */
/*     color: #79d799;  */
/* }  */
/* .btn.green:hover span,  */
/* .btn.green:hover span:after{  */
/*     background: #79d799;  */
/* }  */
/* .btn:hover span{  */
/*     color: #fff;  */
/* }  */
/* @media only screen and (max-width: 767px){  */
/*     .btn{ margin-bottom: 20px; }  */
/* } */
/*********按鈕的css************/
/*div超過高度隱藏*/
/*.divtest {
table-layout: fixed;
word-wrap: break-word;
width: 284px;
height: 400px;
overflow: hidden;    
}*/
/*.star {
	width:500px;
	border:1px solid #ccc;
	padding:20px;
	margin:50px auto;
}*/
		.s-txt {
			/*float:left;*/

		}
		.s-xxs {
			display:inline-block;
			vertical-align:middle;
		}
		.s-xx { 
			float:left;
			color:#e3e3e3;
			padding-right:8px;
			cursor:pointer;
			font-size: 25px;
			vertical-align:middle;
		}
		/*外框*/
		.s-haoping {
			color:#f13a3a;
			border:1px solid #f13a3a;
			padding:2px 4px;
			font-size:12px;
			vertical-align:middle;
			position:relative;
			display:none;
		}
		/*外框*/
		.s-haoping .s-hp-triangle0 {
			border-width:4px;
			position:absolute;
			top:5px;
			left:-8px;
			border-color:transparent #f13a3a transparent transparent;
			border-style:dashed solid dashed dashed;
		}
		/*外框*/
		.s-haoping .s-hp-triangle1 {
			border-width:4px;
			position:absolute;
			top:5px;
			left:-7px;
			border-color:transparent  #f8f8f8 transparent transparent;
			border-style:dashed solid dashed dashed;
		}
		.divStyle{
            border-bottom: 1px dotted #c8cbcc;
		}
		/*星星顏色*/
		.color-f13a3a {
			color:#f13a3a;
		}

	</style>
</head>
<body onload="connect();" onunload="disconnect();">
<jsp:include page="/front-end/CA105G1_header.jsp"/>
	<div class="container-fluid">
		<div class="row">

			<!-- navbar -->
<!-- 				<nav class="navbar navbar-default" role="navigation"> -->
<!-- 					<div class="container"> -->
<!-- 						<div class="navbar-header"> -->
<!-- 							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse"> -->
<!-- 								<span class="sr-only">選單切換</span> -->
<!-- 								<span class="icon-bar"></span> -->
<!-- 								<span class="icon-bar"></span> -->
<!-- 								<span class="icon-bar"></span> -->
<!-- 							</button> -->
<!-- 							<a class="navbar-brand" href="#">CSS可樂</a> -->
<!-- 						</div> -->

<!-- 						手機隱藏選單區 -->
<!-- 						<div class="collapse navbar-collapse navbar-ex1-collapse"> -->
<!-- 							左選單 -->
<!-- 							<ul class="nav navbar-nav"> -->
<!-- 								<li class="active"> -->
<!-- 									<a href="#">關於CSS可樂</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a href="#">CSS教學</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a href="#">CSS範例</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a href="#">原創CSS</a> -->
<!-- 								</li> -->
<!-- 							</ul> -->

<!-- 							搜尋表單 -->
<!-- 							<form class="navbar-form navbar-left" role="search"> -->
<!-- 								<div class="form-group"> -->
<!-- 									<input type="text" class="form-control" placeholder="請輸入關鍵字"> -->
<!-- 								</div> -->
<!-- 								<button type="submit" class="btn btn-default">搜尋</button> -->
<!-- 							</form> -->

<!-- 							右選單 -->
<!-- 							<ul class="nav navbar-nav navbar-right"> -->
<!-- 								<li> -->
<!-- 									<a href="#">Amos 您好</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a href="#">登出</a> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<a href="#">個人設定</a> -->
<!-- 								</li> -->
<!-- 								<li class="dropdown"> -->
<!-- 									<a href="#" class="dropdown-toggle" data-toggle="dropdown">繁體中文 -->
<!-- 										<b class="caret"></b> -->
<!-- 									</a> -->
<!-- 									<ul class="dropdown-menu"> -->
<!-- 										<li> -->
<!-- 											<a href="#">繁體中文</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">English</a> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<a href="#">日本語</a> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
<!-- 						手機隱藏選單區結束 -->
<!-- 					</div> -->
<!-- 				</nav> -->
			<!-- 幻燈片 -->
<!-- 				<div id="carousel-id" class="carousel slide" data-ride="carousel"> -->
<!-- 					幻燈片小圓點區 -->
<!-- 					<ol class="carousel-indicators"> -->
<!-- 						<li data-target="#carousel-id" data-slide-to="0" class=""></li> -->
<!-- 						<li data-target="#carousel-id" data-slide-to="1" class=""></li> -->
<!-- 						<li data-target="#carousel-id" data-slide-to="2" class="active"></li> -->
<!-- 					</ol> -->
<!-- 					幻燈片主圖區 -->
<!-- 					<div class="carousel-inner"> -->
<!-- 						<div class="item"> -->
<!-- 							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt=""> -->
<!-- 							<div class="container"> -->
<!-- 								<div class="carousel-caption"> -->
<!-- 									<h1>CSS可樂好喝超爽快</h1> -->
<!-- 									<p>你喝過了嗎？</p> -->
<!-- 									<p> -->
<!-- 										<a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a> -->
<!-- 									</p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="item"> -->
<!-- 							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt=""> -->
<!-- 							<div class="container"> -->
<!-- 								<div class="carousel-caption"> -->
<!-- 									<h1>CSS可樂的外掛真方便</h1> -->
<!-- 									<p>你安裝了嗎？</p> -->
<!-- 									<p> -->
<!-- 										<a class="btn btn-lg btn-primary" href="#" role="button">更多</a> -->
<!-- 									</p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="item active"> -->
<!-- 							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt=""> -->
<!-- 							<div class="container"> -->
<!-- 								<div class="carousel-caption"> -->
<!-- 									<h1>我是標題喔～自己改文案吧</h1> -->
<!-- 									<p>我是內文喔，你可以把字打在這裡呦</p> -->
<!-- 									<p> -->
<!-- 										<a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a> -->
<!-- 									</p> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					上下頁控制區 -->
<!-- 					<a class="left carousel-control" href="#carousel-id" data-slide="prev"> -->
<!-- 						<span class="glyphicon glyphicon-chevron-left"></span> -->
<!-- 					</a> -->
<!-- 					<a class="right carousel-control" href="#carousel-id" data-slide="next"> -->
<!-- 						<span class="glyphicon glyphicon-chevron-right"></span> -->
<!-- 					</a> -->
<!-- 				</div> -->
<jsp:include page="/front-end/indexPutNewsCarousel.jsp" />
			<br>

			<!-- 大區容器 -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-xs-12 col-sm-1"></div>
						<!-- 複合查詢 -->
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
								<div class="col-xs-12 col-sm-2 aa">
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
									</ul>
										 <input type="submit" value="送出">
										 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
										 <input type="hidden" name="action" value="pro_ByCompositeQuery">
								</div>
							</FORM>
		                
		                <!-- 右邊區域 -->
							<div class="col-xs-12 col-sm-9 prosize" >
								<!-- 麵包屑 -->
									<ol class="breadcrumb test">
										<li>
											<a href="#">首頁</a>
										</li>
										<li>
											<a href="#">最新消息</a>
										</li>
										<li class="active">媽我上電視了</li>
									</ol>
								<!-- 商品列表 -->
								<%@ include file="page/page1_ByCompositeQuery.file" %>
									    <table tablesize>
									    	<tbody>
									    		<tr>
									    			<c:forEach var="proVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
										    			<td>
															<div class="w3-card-4" style="width:250px">
														    	<img class="img-responsive" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proVO.pro_no}">
														    	<div class="w3-container w3-center">
														       		<div class="divStyle"> ${proVO.pro_name}</div>
														       		<div>${proVO.pro_bonus}</div>
														       		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" id="${proVO.pro_no}" style="margin-bottom: 0px;">
<!-- 																		<input type="submit" value="詳情" class="btn btn-info"> -->

																        <a  onclick="document.getElementById('${proVO.pro_no}').submit()">test </a>
<!-- 																            <span class="fa fa-credit-card-alt"></span>商品詳情  -->
<!-- 																        </a>  -->

																		<input type="hidden" name="pro_no" value="${proVO.pro_no}">
																		<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
																		<input type="hidden" name="action" value="getOne_For_Display_front">
																	</FORM>
																													    <!-- 評價系統 -->
													<div class="star">
													    <span class="s-txt">產品評價：</span>
														    <span class="s-xxs" id="${proVO.pro_no}">
														        <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
															    <span class="iconfont s-xx">☆</span>
														    </span>
<!-- 													    <span class="s-haoping"> -->
<!-- 														<em class="s-hp-triangle0"> -->
<!-- 													        </em><em class="s-hp-triangle1"> -->
<!-- 													        </em><span class="s-hp-txt">5分好評</span> -->
<!-- 													    </span> -->
													</div>
														    	</div>
														    </div>
										    			</td> 
									    			</c:forEach>
									    		</tr>
									    	</tbody>
									    </table>
									    <%@ include file="page/page2_ByCompositeQuery.file" %>
									    
	                        </div>
	                        
	                </div>
	            </div>
<jsp:include page="/front-end/CA105G1_footer.jsp"/>
    </div>
</div>






                
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="<%=request.getContextPath() %>/back-end/pro/tool/websock_client.js"></script>
<script type="text/javascript">
	
$(function() {
    var isclick = false;
    var arr = ["1分差評", "2分中評", "3分中評", "4分好評", "5分好評"];
    var clickind = -1;

    $(".s-xx").on("click", function() {
        isclick = true;
        clickind = $(this).index();
    });
    $(".s-xx").hover(function() {
        var ind = $(this).index();
        var proid = $(this).parent().attr("id");
        console.log(proid)
//         $(".s-xx").removeClass("color-f13a3a");
        for (var i = 0; i <= ind; i++) {
        	$(this).parent().find(".s-xx").eq(i).addClass("color-f13a3a");
            $(".s-haoping").find(".s-hp-txt").text(arr[i]).end().show();
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
    
//     var isclick = false;
//     var arr = ["1分差評", "2分中評", "3分中評", "4分好評", "5分好評"];
//     var clickind = -1;

//     $(".s-xx").on("click", function() {
//         isclick = true;
//         clickind = $(this).index();
//     });
//     $(".s-xx").hover(function() {
//         var ind = $(this).index();
//         $(".s-xx").removeClass("color-f13a3a");
//         for (var i = 0; i <= ind; i++) {
//             $(".s-xx").eq(i).addClass("color-f13a3a");
//             $(".s-haoping").find(".s-hp-txt").text(arr[i]).end().show();
//         }
//     }, function() {
//         if (!isclick) {
//             $(".s-xx").removeClass("color-f13a3a");
//             $(".s-haoping").hide();
//         } else {
//             $(".s-xx").removeClass("color-f13a3a");
//             for (var i = 0; i <= clickind; i++) {
//                 $(".s-xx").eq(i).addClass("color-f13a3a");
//                 $(".s-haoping").find(".s-hp-txt").text(arr[i]).end().show();
//             }
//         }
//     });
});

</script>

</body>

</html>