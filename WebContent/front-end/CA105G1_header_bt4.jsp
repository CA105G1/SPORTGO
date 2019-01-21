<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		
		<!-- Font Awesome -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		
	</head>
	<body> 
	
<!-- Preloader -->
    <div class="preloader d-flex align-items-center justify-content-center">
        <div class="preloader-circle"></div>
        <div class="preloader-img">
            <img src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png" alt="">
        </div>
    </div>
<!--  header -->
	 <header class="header-area">
		<nav class="navbar navbar-expand-lg navbar-light bg-light navbar-dark bg-dark">
		<img style="height: 20px; width:20px;"src="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.png" alt="SportGo!"/>
		  <a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">SportGo!</a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
		
		  <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
		    <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
		      <li class="nav-item active">
		        <a class="nav-link" href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">揪團去 <span class="sr-only">(current)</span></a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link" href="<%=request.getContextPath()%>/front-end/club/club_list.jsp">社團</a>
		      </li>
		      
		    </ul>
		    
		      <div class="collapse navbar-collapse" id="navbarResponsive">
		         <ul class="navbar-nav ml-auto">
		             <li class="nav-item">
		                 <a class="nav-link scroll-link" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/shoppingcart_front.jsp"><span class="oi oi-cart">購物車</span></a>
		             </li>
		           		<c:if test="${memberlistVO==null}">
							<li class="nav-item">
								<a class="nav-link" href="#">訪客，您好</a>
							</li>
							<li class="nav-item">
								<% System.out.println("log_in_location :　"+ request.getRequestURI());%>
								<a class="nav-link" href="<%=request.getContextPath()%>/front-end/memberlist/Login.jsp">登入/註冊</a>
							</li>
						</c:if>
		             	<c:if test="${!(memberlistVO==null)}">
							<li class="nav-item">
								<a class="nav-link" href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp">${memberlistVO.mem_name}，您好</a>
							</li>
			<!-- 通知 -->
<!-- 							<li class="nav-item "> -->
<!-- 								<a class="nav-link" id="notation" href="#" >通知</a> -->
<!-- 							</li> -->
							
							
<!-- 							<ul class="nav navbar-nav"> -->
						        <li class="dropdown">
						        	<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bell"></i> </a>
							    	<ul class="dropdown-menu" id="notation">
							            <li><a href="#">Account Settings <span class="glyphicon glyphicon-cog pull-left"></span></a></li>
						          	</ul>
						     	</li>
<!-- 						     </ul> -->
							
							
							
							
							
							
							
							
							
							
							
							
							<li class="nav-item">
								<% System.out.println("log_out_location :　"+ request.getRequestURI());%>
								<a class="nav-link" href="<%=request.getContextPath()%>/front-end/memberlist/logout.do">登出</a>
							</li>
						</c:if>
<!-- 		             <li class="nav-item"> -->
<%-- 		                 <a class="nav-link"  href="<%=request.getContextPath()%>/backEndIndex.jsp">後台首頁</a> --%>
<!-- 		             </li> -->
		         </ul>
		     </div>
		  </div>
		</nav>
<!-- 下一層 -->
        <div class="alazea-main-menu" >
            <div class="classy-nav-container breakpoint-off">
                <div class="container">
                    <!-- Menu -->
                    <nav class="classy-navbar justify-content-between" id="alazeaNav">
 
                        <!-- Nav Brand -->
                        <a href="index.html" class="nav-brand">
<%--                             <img style="height: 40px;"src="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.png" alt=""> --%>
                        </a>

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
                                    <li><a href="<%=request.getContextPath()%>/index.jsp">　<img style="height: 30px; width:30px;"src="<%=request.getContextPath()%>/img/logo_SportyGo_2_light.png" alt="SportGo!"/> 首頁　</a></li>
<!--                                     <li><a href="#">關於我們</a></li> -->
                                    <li><a href="<%=request.getContextPath()%>/front-end/memberlist/public_Member_page.jsp">　會員專區　</a></li>
                                    <li><a href="<%=request.getContextPath()%>/front-end/Sg_info/SgHome.jsp">　揪團　</a></li>
                                    <li><a href="<%=request.getContextPath()%>/front-end/club/club_list.jsp">　社團　</a></li>
                                	<li><a href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/listAllPro_front.jsp">　商城　</a></li>
									<li><a href="<%=request.getContextPath()%>/front-end/venue/venue_query_info_by_composite_front.jsp">　場地　</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
     </header>
     <script>
     var memberlistVO = '${memberlistVO}';
     var mem_no ='${mem_no}';
	 var MemPoint = "/MemEchoServer/"+mem_no;
	 var host = window.location.host;
	 var path = window.location.pathname;
	 var webCtx = path.substring(0,path.indexOf('/',1));
	 var endPointURL = "ws://"+host+webCtx+MemPoint;
	 var webSocket; 
     console.log(memberlistVO);
     $(function(){
			if(memberlistVO!="")
				connect();
		})
     function connect(){
			webSocket = new WebSocket(endPointURL);
			console.log(webSocket);
			
			webSocket.onopen = function(event){
				//alert(event.data);
				console.log("WebSocket connected successful");
			};
			
			webSocket.onmessage = function(event){
				$("#notation").show();
				var jsonObj = JSON.parse(event.data);
				console.log(jsonObj.type);
					if(jsonObj.type==='notation'){
// 						$("#notation").append("<div class='alert alert-info alert-dismissable' role='alert'>"+
// 						"<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"+
// 			         	"<span aria-hidden='true' style='color: deeppink;'>好</span></button>"+
// 		            	"<p class='alert-title'>"+jsonObj.to+"</p><p class='alert-body'>"+
// 		            	jsonObj.message+"</p></div>");
						$("#notation").append("<li><a href='#'>"+jsonObj.to+"  "+
		            	jsonObj.message+"<span class='fa fa-cog pull-left'></span></a></li>");
					}
			};
			
			webSocket.onclose = function(event){
				webSocket.close();
				console.log("WebSocket disconnected");
			};
		}
		
		function sendMessage(){
			webSocket.send('${memberlistVO.mem_no}');
			console.log('${memberlistVO.mem_no}');
		}
     </script>
	</body>
</html>