<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	List<ProductVO> proVOList = (List<ProductVO>) request.getAttribute("proVOList");
// 	Map<String , String> pro_countMap = (Map<String , String>) request.getAttribute("hAll");
    

%>
<jsp:useBean id="proclassSvc" scope="page" class="com.productclass.model.ProductClassService" />
<!DOCTYPE html> 
<html lang="">

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>購物車</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!--[if lt IE 9]>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
	<![endif]-->
	
<!-- 信用卡 -->
<link href="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.js"></script>
	<style type="text/css">
    .panel {
      background-color: #F5F5F7;
      border: 1px solid #ddd;
      padding: 20px;
      display: block;
      width: 270px;
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
/*************************************************/
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
		.checkboxsize{
			/*選取方塊間隔大小*/
			width: 58px;
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
<jsp:include page="/front-end/CA105G1_header.jsp"/>
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



					                  
										<div class="container-fluid">
											<div class="row">
													<!-- 表單 -->
														<div class="container-fluid warp">
															<div class="row">
																<!-- 容器區 -->
																<div class="container-fluid warpwidth">
																	<div class="row">
<%--  -----------------------------------------------------------------------------錯誤表列--------%>
																		<c:if test="${not empty errorMsgs}">
																			<font style="color:red">請修正以下錯誤:</font>
																			<ul>
																				<c:forEach var="message" items="${errorMsgs}">
																					<li style="color:red">${message}</li>
																				</c:forEach>
																			</ul>
																		</c:if>
																		<table>
																		    <td>
																				<div>
																					<img  src="<%=request.getContextPath()%>/front-end/pro/page/cart_icon.jpg" style="width: 150px;height: 150px;">
																				</div>
																			</td>
																			<td><h2 class="fontsize">購物車</h2></td>
																		</table>
																		<!-- 關鍵字搜尋 -->
																		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="formquery">
																			<div class="container">
																				<div class="row">
																					<!-- 搜尋表單 -->
																						<div class="col-xs-12 col-sm-4">
																							<div class="row">
																								
																								<div>
																				
																								</div>
																								<div class="input-group">
																									<input type="text" class="form-control" placeholder="請輸入關鍵字">
																									<span class="input-group-btn">
																										<button class="btn btn-info" type="button" onClick="document.formquery.submit();">搜尋</button>
																										<input type="hidden" name="action" value="pro_ByCompositeQuery">
																									</span>
																								</div>
																								
																							</div>
																						</div>
																					<div class="col-xs-12 col-sm-4"></div>
																					<div class="col-xs-12 col-sm-4"></div>
																				</div>
																			</div>
																		</FORM>
<!--  -------------------------------------------------------------------------所有商品 -->
																			<FORM METHOD="post" ACTION="<%= request.getContextPath()%>/ord/ord.do" name="form1" enctype="multipart/form-data">						
																				<table class="table table-hover ">
																					<thead>
																						<tr class="tablebgc">
																							<th class="checkboxsize"></th>
																							<th class="thwidth">商品名稱圖片</th>
																							<th>商品單價</th>
																							<th>數量</th>
																							<th>總計</th>
																							<th>操作</th>
																						</tr>
																					</thead>
																					<tbody>
																						<jsp:useBean id="productClassSvc" scope="page" class="com.productclass.model.ProductClassService" />
																						
																						<c:choose>
																						    <c:when test="${proVOList  == null}">
																						        <tr>
																						            <td colspan="6"><h1>購物車尚無商品</h1></td>
																						        </tr>
																						    </c:when>
																						    <c:otherwise>
																								<c:forEach var="proVO" items="${proVOList}">
																									<tr>
																									    
																										<td>
																										<!-- 核取方塊大小 -->
																											<input type="checkbox" name="pro_no" value="${proVO.pro_no}" class="box">
		
																										</td>
																										<!-- 商品圖片名稱 -->
																										<td style="text-align: left;">
																											<div style="height: 80px">
																												<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proVO.pro_no}"> ${proVO.pro_name}
																											</div>
																										</td>
																										
																										<!-- 商品單價 -->
																										<td>
																											${proVO.pro_bonus}
																										</td>
																										<!-- 商品數量 -->
																										<td>
																						                    <input type="button" name="name" value="-" class="reduce" />
																							                <input type="text" name="name" value="${hAll[proVO.pro_no]}" class="textNum" style="text-align:center;" size="1"/>
																							                <input type="button" name="name" value="+" class="add" />
																							                <input type="text" class="return_mem_no" value="<%=session.getAttribute("mem_no")%>" style="display: none;"/>
																							                <input type="text" class="return_pro_no" value="${proVO.pro_no}" style="display: none;"/>
																							                <input type="text" class="return_pro_bonus" value="${proVO.pro_bonus}" style="display: none;"/>
																							                <input class="danjia" value="" style="display: none;"/>
																										</td>
																										<!-- 商品總計 -->
																										<td>
																											<div id="${proVO.pro_no}" class="sumTheNumber">${hAll[proVO.pro_no] * proVO.pro_bonus}</div>
																										</td>
																										<!-- 按鈕 -->
																										<td>
																										    <button type="button" class="deletedata" value="${proVO.pro_no}"  >刪除</button>
																										</td>
																									</tr>
																								</c:forEach>
																							</c:otherwise>
																						</c:choose>
																					</tbody>
																				</table>
																				<div class="container">
																					<div class="row">
																						<div class="col-xs-12 col-sm-6"></div>
																						<div class="col-xs-12 col-sm-6">
																							<center>
																								<h3 style="margin-top: 0px;">商品
																						            <input type="button" class="btn btn-info" name="name" value="全選" id="allSelect" />
																		    						<input type="button" class="btn btn-danger" name="name" value="取消全選" id="notSelect" />
																					            </h3>
																				            </center>
																						</div>
																					</div>
																				</div>
                                                                      
<!-- ---------------------------------------------------收貨地址 -->
											<div class="container">
												<div class="row">
													<div class="col-xs-12 col-sm-6">
															<div class="form-group col-lg-6">
																<label for="receiver">收件人姓名</label>
																<input type="text" name="receiver" 
																class="form-control" value="${param.receiver}">
															</div>
															<div class="form-group col-lg-6">
																<label for="phone">收件人電話</label>
																<input type="text" name="phone" 
																class="form-control col-lg-1" size="20" value="${param.phone}">
															</div>
															<div class="form-group col-lg-6">
																<label for="country">國家</label>
																<input type="text" name="country" 
																class="form-control" value="${param.country}">
															</div>
															<div class="form-group col-lg-6">
																<label for="city">城市</label>
																<input type="text" name="city" 
																class="form-control" value="${param.city}">
															</div>
															<div class="form-group col-lg-6">
																<label for="detail">地址</label>
																<input type="text" name="detail" 
																class="form-control" value="${param.detail}">
															</div>
															<div class="form-group col-lg-6">
																<label for="zip">郵遞區號</label>
																<input type="text" name="zip" 
																class="form-control" value="${param.zip}">
															</div>

													</div>
													<div class="col-xs-12 col-sm-6">
													    <br>
														<div>
															<center>														
															  <div class="panel">

															
															      <div class="card-js stripe" data-stripe="true"></div>
															      <button type="submit" class="btncard" ><div id="testnum"></div></button>
															      <input type="hidden" name="ord_amount" value="test">
																  <input type="hidden" name="action" value="insert">

															  </div>
															</center>
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
										
                                      </FORM>
								

<jsp:include page="/front-end/CA105G1_footer.jsp"/>
			</div>
		</div>



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
	// 						var imgsrc = $(this).attr("value");
							var val = $(this).val();
						  
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
					return queryString;
				}
				
				
				function getTotals(){  //總計的計算用遍歷的方式
					var total = 0;
					$(".sumTheNumber").each(function(e){
						total += parseInt($(this).text());
						console.log(parseInt($(this).text()));
						$('#testnum').html('Pay $'+total)
					});
				}
				
				
			</script>							
	</body>						
</html>						