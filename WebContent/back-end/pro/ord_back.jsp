<%@page import="com.orddetails.model.OrddetailsVO"%>
<%@page import="com.orddetails.model.OrddetailsService"%>
<%@page import="com.ord.model.OrdVO"%>
<%@page import="com.ord.model.OrdService"%>
<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>
 
<%
	OrdService ordSvc = new OrdService();
    List<OrdVO> listAll = ordSvc.getAll();
    pageContext.setAttribute("listAll",listAll);
   
    
    
%>
<jsp:useBean id="proclassSvc" scope="page" class="com.productclass.model.ProductClassService" />
<jsp:useBean id="proSvc" scope="page" class="com.product.model.ProductService" />
<jsp:useBean id="memSvc" scope="page" class="com.memberlist.model.MemberlistService" />
<jsp:useBean id="orddetailsSvc" scope="page" class="com.orddetails.model.OrddetailsService" />
<!DOCTYPE html> 
<html lang="">

	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>訂單管理</title>
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
/* 			border-spacing: 0 0.5rem; */

			border-bottom :0px;
		}
        .table>thead>tr>th {
		    border-bottom: 0px;
		}
		th {
			text-align: center;
			border-bottom :0px;
			
		}
		tr:hover {
		    background: #aaf;
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
		div.tuchpanel{
			display:none;
		}
		</style>
	</head>

	<body>





		<!-- 表單 -->
		<div class="container-fluid warp">
			<div class="row">
				<!-- 容器區 -->
				<div class="container-fluid warpwidth">
					<div class="row">
						<div>
							<h2 class="fontsize">?件商品</h2>
						</div>
						<!-- 關鍵字搜尋 -->
						<div class="container">
							<div class="row">
								<div class="col-xs-12 col-sm-4">
									<div class="row">
										<!-- 搜尋表單 -->
										<div>
						
										</div>
										<div class="input-group">
											<input type="text" class="form-control" placeholder="請輸入關鍵字">
											<span class="input-group-btn">
												<button class="btn btn-info" type="button">搜尋</button>
											</span>
										</div>
										<div class="divAdd">
											<a href="<%= request.getContextPath()%>/back-end/pro/addPro.jsp">Add</a>
										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-4"></div>
								<div class="col-xs-12 col-sm-4"></div>
							</div>
						</div>
                                       
						
						<!-- 所有商品 -->
						<c:forEach var="ordListVO" items="${listAll}" varStatus="s">
						<div>
							<table class="table table-hover flip" style=" margin-bottom: 0px;">
								<thead>
								    
									<tr class="tablebgc">
<%-- 									<c:if test="${s.index} == '2'}" var="condition" scope="page" >  --%>
										<th class="thwidth">會員</th>
										<th>會員編號</th>
										<th>訂單編號</th>
										<th>下單日期</th>
										<th>訂單狀態</th>
										<th>訂單金額</th>
										<th>操作</th>
<%-- 									</c:if> --%>
									</tr>
									
									<tr>
										<th>
										    <img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${ordListVO.mem_no}" style="max-width:40px;max-height:40px;">
											${memSvc.getOneMem(ordListVO.mem_no).mem_name}
										</th>
										<th>${ordListVO.mem_no}</th>
										<th>${ordListVO.ord_no}</th>
										<th>${ordListVO.ord_date}</th>
										<th><div id="${ordListVO.ord_no}">${ordListVO.ord_status}</div></th>
										<th>${ordListVO.ord_amount}</th>
										<th>
											<select name=""  class="form-control select_ord_change" style="width:90px;">
												<option value="${ordListVO.ord_no}">完成</option>
												<option value="${ordListVO.ord_no}">取消</option>
											</select>
										    
										</th>
									</tr>
								</thead>
									<tbody>
									</tbody>
							</table>
							<c:forEach var="orddetails" items="${orddetailsSvc.getOneOrd(ordListVO.ord_no)}" >
							<div class="tuchpanel" style="margin-bottom: 0px;">
								<table class="table table-hover">
								    <thead>
									    <th class="thwidth">商品名稱圖片</th>
										<th>商品編號</th>
										<th>買家應付金額</th>
										<th>買家購買數量</th>
										<th>商品當前狀態</th>
										<th>商品當前庫存</th>
										<th></th>
								    </thead>
									<tbody>
										<tr class="xs1">
											<!-- 商品圖片名稱 -->
											<td style="text-align: left; width: 249px;">
<!-- 												<div style="height: 80px"> -->
													<img class="imgsize" src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${proSvc.getOneProduct(orddetails.pro_no).pro_no}">
													${proSvc.getOneProduct(orddetails.pro_no).pro_name}
<!-- 												</div> -->
											</td>
											<!-- 商品編號 -->
											<td style="width: 106px">${orddetails.pro_no }</td>
											<!-- 買家應付金額 -->
											<td style="width: 188px">
												${orddetails.ord_probonuns *orddetails.pro_count}
											</td>
											<!-- 買家購買數量 -->
											<td style="width: 148px">
												${orddetails.pro_count }
											</td>
											<!-- 訂單狀態 -->
											<td style="width: 106px">
												${proSvc.getOneProduct(orddetails.pro_no).pro_shelve}
											</td>
											<!-- 商品庫存 -->
											<td style="width: 148px">
												${proSvc.getOneProduct(orddetails.pro_no).pro_stock}
											</td>
											<!-- 下拉式按鈕 -->
											<td>
												
											</td>
										</tr>
									</tbody>
								</table>
								</div>
							</c:forEach>
							</div>
						</c:forEach>		
					</div>
				</div>
			</div>
		</div>
							




<!-- 有被其他頁面用到需要關掉jquery cnd -->
<!-- 			<script src="https://code.jquery.com/jquery.js"></script> -->
			<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
			<script type="text/javascript">
				$(document).ready(function(){
				      $(".flip").click(function(){
				          $(this).siblings(".tuchpanel").slideToggle("slow");
// 				          $(this).siblings(".xs1").toggle();
// 				          $(".xs1").toggle();
// 				          $(".xs2").toggle();
				        });
					<!--下拉狀態-->
					$('.select_ord_change').change(function(){
						$.ajax({
							 type: "POST",
							 url: "<%= request.getContextPath()%>/ord/ord.do",
							 data: creatQueryOrdSelect($(this).val(),$("option:selected", this).text()),
							 dataType: "json",
							 success: function (data){
								 console.log(data.ord_no+'A');
								 $('#'+data.ord_no).html(data.ord_status);
						     },
						     error: function(){alert("AJAX-class發生錯誤囉!")}
				         })
					})	
				})
					<!--按鈕-->
// 					$('.ok').each( function() {
// 						$(this).click( function() {
// 							var val = $(this).val();
// 							$.ajax({
// 								 type: "POST",
<%-- 								 url: "<%= request.getContextPath()%>/ord/ord.do", --%>
// 								 data: creatQueryOK(val),
// 								 dataType: "json",
// 								 success: function (data){
// 									 $('#'+data.ord_no).html('完成');
// 							     },
// 							     error: function(){alert("AJAX-class發生錯誤囉!")}
// 					         })
// 						})
// 					})
// 					$('.cancel').each( function() {
// 						$(this).click( function() {
// 							var val = $(this).val();
// 							$.ajax({
// 								 type: "POST",
<%-- 								 url: "<%= request.getContextPath()%>/ord/ord.do", --%>
// 								 data: creatQuerycancel(val),
// 								 dataType: "json",
// 								 success: function (data){
// 									 $('#'+data.ord_no).html('取消');
// 							     },
// 							     error: function(){alert("AJAX-class發生錯誤囉!")}
// 					         })
// 						})
// 					})
					
// 				})
// 				function creatQueryOK(ord_no){
					
// 					var queryString= {"action":"ok_cancel", "ord_no":ord_no , "ord_status" :"完成"};
// 					console.log(queryString);
// 					return queryString;
// 				}
// 				function creatQuerycancel(ord_no){
// 					var queryString= {"action":"ok_cancel", "ord_no":ord_no , "ord_status" :"取消"};
// 					return queryString;
// 				}	
				function creatQueryOrdSelect(ord_no,ord_status){
					var queryString= {"action":"ok_cancel", "ord_no":ord_no , "ord_status" :ord_status};
					console.log(queryString);
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