<%@page import="com.memberlist.model.MemberlistVO"%>
<%@page import="com.shoppingcart.model.ShoppingcartDAO"%>
<%@page import="com.product.model.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
// 	List<ProductVO> proVOList = (List<ProductVO>) request.getAttribute("proVOList");
// 	Map<String , String> pro_countMap = (Map<String , String>) request.getAttribute("hAll");
//     if(proVOList == null){
		MemberlistVO memVO =  (MemberlistVO)session.getAttribute("memberlistVO");
		List<ProductVO> proVOList = new ArrayList();
		ProductService proSvc = new ProductService();
	    ShoppingcartDAO cartDAO = new ShoppingcartDAO();
	    
	    Map<String , String> hAll =  cartDAO.getAll(memVO.getMem_no()+"P");
		for(String pro_no : hAll.keySet()) {
			proVOList.add(proSvc.getOneProduct(pro_no));
			System.out.println(proSvc.getOneProduct(pro_no));
		}
		cartDAO = null;
		request.setAttribute("hAll", hAll);
		request.setAttribute("proVOList", proVOList);
//     }
    

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
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/front-end/pro/TWzipcode/jquery.twzipcode.min.js"></script>
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
	#map { /*一定要有不然跑不出來*/
         height: 400px;  /* The height is 400 pixels */
         width: 400px;  /* The width is the width of the web page */
    }
        </style>
    
    
</head>

<body onload="connect();" onunload="disconnect();">



        <!-- ***** Top Header Area ***** -->
  <jsp:include page="/front-end/CA105G1_header_bt4.jsp" />



    <!-- ##### Breadcrumb Area Start ##### -->
<!--     <div class="breadcrumb-area"> -->
<!--         Top Breadcrumb Area -->
<%--         <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%=request.getContextPath()%>/InitDB/image/news/N002.png);"> --%>
<!--             <h2>Cart</h2> -->
<!--         </div> -->

<!--         <div class="container"> -->
<!--             <div class="row"> -->
<!--                 <div class="col-12"> -->
<!--                     <nav aria-label="breadcrumb"> -->
<!--                         <ol class="breadcrumb"> -->
<%--                             <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"><i class="fa fa-home"></i> Home</a></li> --%>
<!--                             <li class="breadcrumb-item active" aria-current="page">Cart</li> -->
<!--                         </ol> -->
<!--                     </nav> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </div> -->
<!--     </div> -->
    <!-- ##### Breadcrumb Area End ##### -->

    <!-- ##### Cart Area Start ##### -->
        <div class="breadcrumb-area">
        <!-- Top Breadcrumb Area -->
        <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%=request.getContextPath()%>/InitDB/image/news/N003.png);">
            <h2>Checkout</h2>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp"><i class="fa fa-home"></i> Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Shopping cart</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
    </div>
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
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="proVO" items="${proVOList}">
                                <tr>
                                    <td class="cart_product_img">
                                        <div class="custom-control custom-checkbox d-flex align-items-center mb-2">
		                                    <input type="checkbox" class="custom-control-input box" id="box_${proVO.pro_no}" name="pro_no"  value="${proVO.pro_no}">
		                                    <label class="custom-control-label" for="box_${proVO.pro_no}"></label>
		                                </div>
<%--                                     	<input type="checkbox" name="pro_no" value="${proVO.pro_no}" class="box" style="height: 25px;width: 25px;background-color: #00ffff;"> --%>
  
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
                                    <td><button type="button" class="btn btn-outline-danger deletedata" value="${proVO.pro_no}"  >刪除</button></td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div align="right">
	     					<input type="button" class="btn btn-outline-primary" name="name" value="全選商品" id="allSelect" />
	   						<input type="button" class="btn btn-outline-secondary" name="name" value="取消全選" id="notSelect" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">

                <!-- Coupon Discount -->
                <div class="col-12 col-lg-6">
                    <div class="cart-totals-area mt-70">
                        <h5 class="title--">收貨資訊<button type="button" class="btn btn-outline-success float-right"  id="changeMap">切換地圖</button> </h5>
                        <div class="shipping d-flex justify-content-between">
                            <img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=<%=session.getAttribute("mem_no")%>" 
                            style="max-width:100px;max-height:100px;margin-right: 10px;" class="rounded-circle">
                            <div class="shipping-address">
                                    <input type="text"  placeholder="收件人姓名" name="address_receiver" value="${param.receiver}">
                                    <input type="tel"  placeholder="收件人電話" name="address_phone" value="${param.phone}">
                                    <!-- google map -->
                                    <input id="searchtext" type="text" class="form-control" placeholder="Search for...">
                                    <button class="btn btn-default" type="button" onclick="mySearch();">Go!</button>
                                     <div id="map"></div>
                                     <input type="hidden" class="inputCity">
                                     <input type="hidden" class="inputTown">
                                     <input type="hidden" class="inputZipcode">
                                     
                                    <div id="zipcode"></div>
	                                <script>
	                                    $("#zipcode").twzipcode({
	                                        countySel: "臺北市", // 城市預設值, 字串一定要用繁體的 "臺", 否則抓不到資料
	                                        districtSel: "大安區", // 地區預設值
	                                        zipcodeIntoDistrict: false, // 郵遞區號自動顯示在地區
	                                        css: ["city form-control", "town form-control","form-control"], // 自訂 "城市"、"地區" class 名稱 
	                                        countyName: "city", // 自訂城市 select 標籤的 name 值
	                                        districtName: "town", // 自訂地區 select 標籤的 name 值
	                                        zipcodeName:"zipcode"
	                                    });
	                                </script>  
<%--                                     <input type="text"  placeholder="城市" name="address_city" value="${param.city}"> --%>
                                    <input type="text"  placeholder="地址" name="address_detail" value="${param.detail}" id="cartaddress">
<%--                                     <input type="text"  placeholder="郵遞區號" name="address_zip" value="${param.zip}"> --%>
									<jsp:include page="/front-end/pro/country-dropdown/country-select.jsp"/>
									<input type="text"  style="background-color:#fff;color:#fff;border-color:#fff">
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
                            <a id="testnum2" class="btn alazea-btn w-100"></a>
<!-- <input type="text" name="addr" id="addr"> -->
<!-- <input type="submit" name="search" value="查詢" id="btnSubmit"> -->

                            
                    </div>
                </div>
            </div>

        </div>
    </div>
    </FORM>
   
    <!-- ##### Cart Area End ##### -->

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
<!-- 信用卡風格 -->
<link href="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath() %>/front-end/pro/card/card-js.min.js"></script>
<!-- 信用卡日期驗證 -->
<script src="<%=request.getContextPath() %>/front-end/pro/card/creditcard.js"></script>
<!-- google map api -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAb2lDof7yMn-TTXwt2hwVm4y92t1AqvyU&callback=initMap&libraries=places"async defer>
        </script>

        
			<script type="text/javascript">
			<!--google mapy-->
			var map;
			var infowindow;
			var loc;
			var service;
			var markerArray = [];
			var flag = false;
			var geocoder ;
			$('#map').hide();
			function initMap(){
				navigator.geolocation.getCurrentPosition(myLoc);
			}
			function myLoc(pos){

				loc = {lat: pos.coords.latitude, lng: pos.coords.longitude};//本地位置
				map = new google.maps.Map(document.getElementById('map'), {
					center: loc,
					zoom: 12
				});

				infowindow = new google.maps.InfoWindow();//初始化
				 geocoder = new google.maps.Geocoder();
				
				var marker = new google.maps.Marker({
					position: loc,
					map: map,
					animation: google.maps.Animation.DROP,
					draggable: true
				});
				service = new google.maps.places.PlacesService(map);
				
				//畫圓
				var circle = new google.maps.Circle({
				  center: loc,
				  radius: 500,
				  strokeOpacity: 0,
				  fillColor: '#f00',
				  fillOpacity: 0.35,
				  map: map
				});
				//點擊時取得地址
				var address;
				google.maps.event.addListener(map, 'click', function(event) {
				  geocoder.geocode({
				    'latLng': event.latLng
				  }, function(results, status) {
				    if (status == google.maps.GeocoderStatus.OK) {
				      if (results[0]) {
				        console.log(results[0]);
				        address = results[0];
				      }
				    }
				  });
				});
				
			   if (geocoder) {
				      geocoder.geocode({ 'address': address }, function (results, status) {
				         if (status == google.maps.GeocoderStatus.OK) {
				            console.log(results[0].geometry.location);
				         }
				         else {
				            console.log("Geocoding failed: " + status);
				         }
				      });
				   }
				
			}
			//按下收尋
          	function mySearch(){
                  for(var i = 0 ; i < markerArray.length ; i ++){
                      markerArray[i].setMap(null);
                  }
                  markerArray = [];
                  service.nearbySearch({
                      location: loc,
                      radius: 3000,
                      type:  'convenience_store',
                      keyword: document.getElementById("searchtext").value
                  }, callback);
             }
            function callback(results, status) {//回傳
                if (status === google.maps.GeocoderStatus.OK) {
                  for (var i = 0; i < results.length; i++) {
                    createMarker(results[i]);
                    address = results[0];
//                      console.log(results[i]);
                  }
                }
             }
              
            var marker;
            function createMarker(place) {
              var placeLoc = place.geometry.location;
               marker = new google.maps.Marker({
                  map: map,
                  position: place.geometry.location,
                  icon: {
                    url: '<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/store.jpg',
                    anchor: new google.maps.Point(10, 10),
                    scaledSize: new google.maps.Size(20, 34)
                  }
              });
              //new
              markerArray.push(marker);

              google.maps.event.addListener(marker, 'click', function() {//點擊maker取得當前資訊
                	msg = place.name + "<br>" + place.rating;
                	
                	
//                 	console.log(place.vicinity.substr(0, 3));
//                 	console.log(place.plus_code.compound_code.substring(10, 13));
                	var city = place.plus_code.compound_code.substring(10, 13);
                	var town = place.vicinity.substr(0, 3);
                	var address = place.vicinity.substring(3);
                    console.log(place);
                	
					$("select[name='city']").val(city);
					$("input[name='address_detail']").val(address);
// 					$("select[name='town']").hide();
// 					$("select[name='town']").removeAttr('name');
// 					jQuery('<input type="text" name="town">');
					
					
//                     document.getElementsByName("city").value = city;
//                     document.getElementsByName("city").fireEvent("onchange");
//                     $("select[name='city']").change(function(){
//                     	console.log("tewst")
//                     })
//                 	$("select[name='city']").val(city).trigger('change');
                	
                	
                		
// onclickAddress(city ,  address,town);
                	
//                 $("select[name='city']").val(city);
//                 $("select[name='town']").val(town);
                
//                 $("select[name='city']").removeAttr('name');
//                 $("select[name='town']").removeAttr('name');
//                 $("select[name='town']").removeAttr('name');
                console.log(place.vicinity);
                console.log(place.plus_code.compound_code);
                for(var i = 0 ; i < parseInt(place.rating); i++){
                    msg = msg + "\u2605";
                }
                infowindow.setContent(msg);
                infowindow.open(map, this);
              });
            }
              
           
               
			$("#changeMap").click(function(){
				if(flag === false){
					$('#map').show();
					$('#zipcode').hide();
					$('#cartaddress').hide();
					$('#countries').hide();
					flag = true;
				} else {
					$('#map').hide();
					$('#zipcode').show();
					$('#cartaddress').show();
					$('#countries').show();
					flag = false;
				}
			})
			
				$(document).ready(function(){
					<!--評價jquery-->
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
					<!--信用卡日期驗證-->
					var cardtrue = false;
					$(".expiry").prop('disabled', true);//先把日期關掉
					$(".expiry").keyup(function(){
						var number = $(".expiry").val();
						console.log("number"+number)
						if(0< number.substr(0, 2) && number.substr(0, 2)<=12 && number.substr(3,1 )==="/" && number.substr(4,5) >= 19 && number.length === 7){
							//"19"年到期的 完全正確
							$('#testnum2').hide();
							$('#testnum').show();
							cardtrue = true;
						}else if (number.length === 0){
							//沒輸入時為正常按鈕
							$(".expiry").css("border-color","#d8d8d8");//輸入框的css
							$('#testnum2').css("background-color","#dc3545");
							$('#testnum2').css("border","#dc3545");
							$('#testnum2').css("color","#ffffff");
							$('#testnum2').css("pointer-events","none");
							$('#testnum2').html("信用卡日期未填寫");
							$('#testnum2').show();
							$('#testnum').hide();
						}else{
							//驗證錯誤時
							$('#testnum2').show();
							$('#testnum').hide();
							$('#testnum2').css("background-color","#dc3545");
							$('#testnum2').css("border","#dc3545");
							$('#testnum2').css("color","#ffffff");
							$('#testnum2').css("pointer-events","none");
							$('#testnum2').html("信用卡日期錯誤");
						}
					});
					<!--信用卡卡號驗證-->
	                $('#testnum2').hide();
	                $(".cvc").attr("name", "cvc");
		            $(".card-number").keyup(function(){
		                var number = $(".card-number").val();
		                var arr = number.split(" ");//將取得的數字去掉所有空白回傳字串array
		                var num = arr.join("");//將array組起來
		                var cardnum = 0;
		                if(num.length == 16){
		                    var name = detectCardType(num);
		                    if(name != false){//驗證卡號廠商正確的話驗證號碼
			                    	cardnum = checkCreditCard(num,name);
			                        console.log("cardnum"+cardnum);
			                    
			                    if(cardnum === false){
			                        //卡號錯誤
				                    $('#testnum2').css("background-color","#dc3545");
				                    $('#testnum2').css("border","#dc3545");
				                    $('#testnum2').css("color","#ffffff");
				                    $('#testnum2').html("信用卡號錯誤");
				                    $('#testnum2').css("pointer-events","none");
			                    }else{
			                    	//卡號正確
			                    	console.log(cardnum);
	// 		                    	if(cardtrue === true){
				                        $('#testnum2').hide();
				                        $('#testnum').show();
				                        $(".expiry").prop('disabled', false);
	// 		                    	}
			                    }
		                    }
		                } else {
		                    //卡號長度不正確
		                    if(num.length >= 1){
		                    	$('#testnum').hide();
			                    $('#testnum2').show();
			                    $('#testnum2').css("background-color","#dc3545");
			                    $('#testnum2').css("border","#dc3545");
			                    $('#testnum2').css("color","#ffffff");
			                    $('#testnum2').html("信用卡號長度不正確");
			                    $('#testnum2').css("pointer-events","none");
		                    }else{
			                    $('#testnum2').hide();
			                    $('#testnum').show();
			                    $(".expiry").prop('disabled', true);
			                    $(".expiry").val("");
		                    }
		                }
		            });
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
				    console.log(queryString);
					return queryString;
				}
				
				
				function getTotals(){  //總計的計算用遍歷的方式
					var total = 0;
					$(".sumTheNumber").each(function(e){
						total += parseInt($(this).text());
						$('#testnum').html('Pay $'+total);
						$('#testnumtwo').html('$'+total);
						cardtotal = total;
					});
				}
				
				
			</script>		
</body>

</html>