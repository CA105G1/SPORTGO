<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.sg_info.model.*" %>
<%@ page import = "com.sg_mem.model.*" %>
<%@ page import = "java.util.*" %>
<%
	String status = (String)request.getAttribute("status");
	Double score = (Double)request.getAttribute("score");
	if(status==null)
		pageContext.setAttribute("status","");
	else
		pageContext.setAttribute("status",status);
	if(status==null)
		pageContext.setAttribute("score",0);
	else
		pageContext.setAttribute("score",score);
%>
<jsp:useBean id="memberlistService" class="com.memberlist.model.MemberlistService"/>
<jsp:useBean id="sginfoService" class="com.sg_info.model.Sg_infoService"/>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
		<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
		<title>SPORTGO 會員揪團頁面</title>
		<style type="text/css">
			.container{
				width: 90%;
			}
			center{
				font-size: xx-large;
				color: red;
			}
			.grid-container{
				grid-template-columns:20% 40% 20%;
				grid-gap:20px;
				text-algin:center;
			}
			.list-group-item{
				align-items:center;
			}
			
			
.rating-loading{
    width:25px;
    height:25px;
    font-size:0;
    color:#fff;
    background:url(../img/loading.gif) top left no-repeat;border:none
    }
.rating-container .rating-stars
    {position:relative;
    cursor:pointer;
    vertical-align:middle;
    display:inline-block;
    overflow:hidden;
    white-space:nowrap
         }
         .rating-container .rating-input
         {position:absolute;
         cursor:pointer;
         width:100%;
         height:1px;
         bottom:0;left:0;
         font-size:1px;
         border:none;
         background:0 0;
         padding:0;
         margin:0
         }
         .rating-disabled .rating-input,.rating-disabled .rating-stars
         {
             cursor:not-allowed
             
         }
         .rating-container .star{
             display:inline-block;
             margin:0 3px;
             text-align:center
         }
         .rating-container .empty-stars{
             color:#aaa
         }
         .rating-container .filled-stars
         {
             position:absolute;
             left:0;
             top:0;
             margin:auto;
             color:#fde16d;
             white-space:nowrap;
             overflow:hidden;
             -webkit-text-stroke:1px #777;
             text-shadow:1px 1px #999
         }
             .rating-rtl
             {
                 float:right
                 
             }
             .rating-animate .filled-stars
             {
                 transition:width .25s ease;
                 -o-transition:width .25s ease;
                 -moz-transition:width .25s ease;-webkit-transition:width .25s ease
             }
             .rating-rtl .filled-stars
             {left:auto;right:0;-moz-transform:matrix(-1,0,0,1,0,0) translate3d(0,0,0);-webkit-transform:matrix(-1,0,0,1,0,0) translate3d(0,0,0);-o-transform:matrix(-1,0,0,1,0,0) translate3d(0,0,0);
             transform:matrix(-1,0,0,1,0,0) translate3d(0,0,0)}.rating-rtl.is-star 
             .filled-stars{
                 right:.06em
                 
             }
             .rating-rtl.is-heart .empty-stars{
                 margin-right:.07em
                 
             }
             .rating-lg{
                 font-size:3.91em
                 
             }
             .rating-md{
                 font-size:3.13em
                 
             }
             .rating-sm{
                 font-size:2.5em
                 
             }
             .rating-xs{
                 font-size:2em
                 
             }
             .rating-xl{
             font-size:4.89em
                 
             }
             .rating-container .clear-rating{
                 color:#aaa;
                 cursor:not-allowed;
                 display:inline-block;
                 vertical-align:middle;
                 font-size:60%;
                 padding-right:5px
                 
             }
             .clear-rating-active{
                 cursor:pointer!important
                 
             }
             .clear-rating-active:hover{
                 color:#843534
                 
             }
             .rating-container .caption{
                 color:#999;
                 display:inline-block;
                 vertical-align:middle;
                 font-size:60%;
                 margin-top:-.6em;
                 margin-left:5px;
                 margin-right:0
                 
             }
             .rating-rtl .caption{
                 margin-right:5px;
                 margin-left:0
                 
             }
             @media print{.rating-container .clear-rating{
                 display:none
                 
             }
                 
             }
			
		</style>
	</head>
	<body>
		<jsp:include page="/front-end/CA105G1_header_bt4.jsp"/>
		<div class="breadcrumb-area">
	    	<div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/badmintoncount.JPG);">
	    	</div>
		</div>		
		<div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-home"></i>首頁</a></li>
                            <li class="breadcrumb-item" aria-current="page"><a href="public_Member_page.jsp">會員專區</a></li>
                            <li class="breadcrumb-item active" aria-current="page">揪團管理</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
		<div class="container">
			<div class="row">
		<!-- 右選單 -->
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="list_group.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9">
				<!-- 揪團管理 -->
					<section class="alazea-portfolio-area portfolio-page section-padding-0-100">
       					<div class="container">
            				<div class="row">
            					<div class="section-heading text-center">
			                        <h2>揪團管理</h2>
			                        <p>有事沒事多運動</p>
                    			</div>
							</div>
						</div>
						<div class="container">
				            <div class="row">
				                <div class="col-12">
				                    <div class="alazea-portfolio-filter">
				                        <div class="portfolio-filter">
				                            <button class="btn active" data-filter="*">所有的揪團</button>
				                            <button class="btn" data-filter=".particpate">參加的揪團</button>
				                            <button class="btn" data-filter=".host">主辦的揪團</button>
				                            <button class="btn" data-filter=".like">我的收藏</button>
				                            <button class="btn" data-filter=".history">歷史揪團</button>
				                        </div>
				                    </div>
				                </div>
				            </div>
				            <div class="row alazea-portfolio">
				            <c:forEach var="sg_memVO" items="${sg_mem}">
								<c:forEach var="sg_infoVO" items="${sgall}">
									<c:if test="${sg_infoVO.sg_no eq sg_memVO.sg_no}">
						            	<!-- Single Portfolio Area -->
		                				<div class="col-12 col-sm-6 col-lg-6 single_portfolio_item particpate home-design">
		                   				<!-- Portfolio Thumbnail -->
		                    				<div class="portfolio-thumbnail bg-img" style="background-image: url(<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no});"></div>
		                    			<!-- Portfolio Hover Text -->
		                    					<div class="portfolio-hover-overlay">
		                        					<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForJoinMem.jsp?Sg_no=${sg_infoVO.sg_no}" class="portfolio-img d-flex align-items-center justify-content-center" title="Portfolio 1">
			                            				<div class="port-hover-text">
				                             				<h3>${sg_infoVO.sg_name}</h3>
				                                			<h5>團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}</h5>
				                                			<fmt:formatDate value="${sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
			                           					</div>
		                        					</a>
		                    					</div>
              							</div>
              						</c:if>
              					</c:forEach>
           					</c:forEach>
<!--            					收藏的揪團 -->
           					<c:forEach var="sglike" items="${sglike}">
           						<div class="col-12 col-sm-6 col-lg-6 single_portfolio_item like home-design">
                   				Portfolio Thumbnail
                    				<div class="portfolio-thumbnail bg-img" style="background-image: url(<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sglike.sg_no});"></div>
                    			Portfolio Hover Text
                    					<div class="portfolio-hover-overlay">
                        					<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForGeneral.jsp?Sg_no=${sglike.sg_no}" class="portfolio-img d-flex align-items-center justify-content-center" title="Portfolio 1">
	                            				<div class="port-hover-text">
		                             				<h3>${sginfoService.GetByPK(sglike.sg_no).sg_name}</h3>
		                                			<h5>團長：${memberlistService.getOneMem(sglike.mem_no).mem_name}</h5>
		                                			<fmt:formatDate value="${sginfoService.GetByPK(sglike.sg_no).sg_date}" pattern="yyyy-MM-dd HH:mm"/>
	                           					</div>
                        					</a>
                    					</div>
       							</div>
           					</c:forEach>
<!--            					舉辦的揪團 -->
           					<c:forEach var="sg_infoVO" items="${sglist}">
              					<div class="col-12 col-sm-6 col-lg-6 single_portfolio_item host home-design">
                   				<!-- Portfolio Thumbnail -->
                    				<div class="portfolio-thumbnail bg-img" style="background-image: url(<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no});"></div>
                    			<!-- Portfolio Hover Text -->
                    					<div class="portfolio-hover-overlay">
                        					<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForHead.jsp?Sg_no=${sg_infoVO.sg_no}" class="portfolio-img d-flex align-items-center justify-content-center" title="Portfolio 1">
	                            				<div class="port-hover-text">
		                             				<h3>${sg_infoVO.sg_name}</h3>
		                                			<h5>團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}</h5>
		                                			<fmt:formatDate value="${sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
	                           					</div>
                        					</a>
                    					</div>
       							</div>
              				</c:forEach>
<!-- 				            歷史揪團 -->
<!-- 								歷史參加 -->
							<c:forEach var="sg_memVO" items="${sg_mem}">
								<c:forEach var="sg_infoVO" items="${sghisall}">
									<c:if test="${sg_infoVO.sg_no eq sg_memVO.sg_no}">
										<div class="col-12 col-sm-6 col-lg-6 single_portfolio_item history home-design">
		                   				<!-- Portfolio Thumbnail -->
		                    				<div class="portfolio-thumbnail bg-img" style="background-image: url(<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no});"></div>
		                    			<!-- Portfolio Hover Text -->
		                    					<div class="portfolio-hover-overlay">
		                        					<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForJoinMem.jsp?Sg_no=${sg_infoVO.sg_no}" class="portfolio-img d-flex align-items-center justify-content-center" title="Portfolio 1">
			                            				<div class="port-hover-text">
				                             				<h3>${sg_infoVO.sg_name}</h3>
				                                			<h5>團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}</h5>
				                                			<fmt:formatDate value="${sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
			                           					</div>
		                        					</a>
		                    					</div>
       									</div>
									</c:if>
								</c:forEach>
							</c:forEach>
<!-- 								歷史舉辦 -->
							<c:forEach var="sg_infoVO" items="${sghislist}">
								<div class="col-12 col-sm-6 col-lg-6 single_portfolio_item history home-design">
                   				<!-- Portfolio Thumbnail -->
                    				<div class="portfolio-thumbnail bg-img" style="background-image: url(<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no});"></div>
                    			<!-- Portfolio Hover Text -->
                    					<div class="portfolio-hover-overlay">
                        					<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForHead.jsp?Sg_no=${sg_infoVO.sg_no}" class="portfolio-img d-flex align-items-center justify-content-center" title="Portfolio 1">
	                            				<div class="port-hover-text">
		                             				<h3>${sg_infoVO.sg_name}</h3>
		                                			<h5>團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}</h5>
		                                			<fmt:formatDate value="${sg_infoVO.sg_date}" pattern="yyyy-MM-dd HH:mm"/>
	                           					</div>
                        					</a>
                    					</div>
								</div>
							</c:forEach>
				            </div>
				            
			            </div>
					</section>
				</div>
			</div>
		</div>

<!-- 					<div class="container"> -->
<!-- 						<div class="row"> -->
<!-- 							<h3>即將到來的揪團</h3> -->
<!-- 							<div class="grid-container" style="display:grid;"> -->
<%-- 								<c:forEach var="sg_memVO" items="${sg_mem}"> --%>
<%-- 									<c:forEach var="sg_infoVO" items="${sgall}"> --%>
<%-- 											<c:if test="${sg_infoVO.sg_no eq sg_memVO.sg_no}"> --%>
											
<!-- 												<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;"> -->
<%-- 												<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}" --%>
<!-- 												style="height:100%;position:absolute;"> -->
<!-- 												</div> -->
<%-- 												<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForJoinMem.jsp?Sg_no=${sg_infoVO.sg_no}"  --%>
<!-- 												class="list-group-item" style="display:flex;height:100%;border:0;"> -->
<%-- 												${sg_infoVO.sg_name}<br> --%>
<%-- 											 	團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br> --%>
<%-- 											 	時間：${sg_infoVO.sg_date}<br> --%>
<!-- 												</a> -->
<%-- 												<a href="MemManager.do?action=delete_Sg&Sg_no=${sg_infoVO.sg_no}" class="list-group-item"  style="display:flex;height:100%;border:0;"> --%>
<%-- 													目前人數：${sg_infoVO.sg_ttlapl}<br> --%>
<%-- 													${sg_infoVO.sg_status}<br> --%>
<!-- 													點擊退出揪團 -->
<!-- 												</a> -->
<%-- 											</c:if> --%>
<%-- 									</c:forEach> --%>
<%-- 								</c:forEach> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="container"> -->
<!-- 						<div class="row"> -->
<!-- 							<h3>即將到來的我的揪團</h3> -->
<!-- 							<div class="grid-container" style="display:grid;align-item:center;"> -->
<%-- 								<c:forEach var="sg_infoVO" items="${sglist}"> --%>
<!-- 										<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;"> -->
<%-- 										<img class="pic" src="<%= request.getContextPath()%> --%>
<%-- 										/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}" style="height:100%;position:absolute;"> --%>
<!-- 										</div> -->
<%-- 										<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForHead.jsp?Sg_no=${sg_infoVO.sg_no}" --%>
<!-- 										 class="list-group-item" style="display:flex;height:100%;border:0;"> -->
<%-- 										 ${sg_infoVO.sg_name}<br> --%>
<%-- 										 團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br> --%>
<%-- 										 時間：${sg_infoVO.sg_date}<br> --%>
										
<!-- 										</a> -->
<!-- 										<div class="list-group-item"  style="display:flex;margin-top: 37.5px;margin-bottom: 37.5px;border:0;"> -->
<%-- 										${sg_infoVO.sg_status} --%>
<!-- 										</div> -->
<%-- 								</c:forEach> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="container"> -->
<!-- 						<div class="row"> -->
<!-- 							<h3>我參加過的揪團</h3> -->
<!-- 							<div class="grid-container" style="display:grid;align-item:center;"> -->
<%-- 								<c:forEach var="sg_memVO" items="${sg_mem}"> --%>
<%-- 									<c:forEach var="sg_infoVO" items="${sghisall}"> --%>
<%-- 											<c:if test="${sg_infoVO.sg_no eq sg_memVO.sg_no}"> --%>
<!-- 												<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;"> -->
<%-- 												<img src="<%= request.getContextPath()%>/Sg_info/Sg_infoGetByPkForJoinMem.jsp?sg_no=${sg_infoVO.sg_no}" --%>
<!-- 												style="height:100%;position:absolute;"> -->
<!-- 												</div> -->
<%-- 												<a href="<%=request.getContextPath()%>/Sg_info/Sg_info.do?sg_no=${sg_infoVO.sg_no}"  --%>
<!-- 												 class="list-group-item" style="display:flex;height:100%;border:0;"> -->
<%-- 												${sg_infoVO.sg_name}<br> --%>
<%-- 										 		團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br> --%>
<%-- 										 		時間：${sg_infoVO.sg_date}<br> --%>
<!-- 												</a> -->
<!-- 												<a href="Evaofmem.do?action=Evaluate_Sg" -->
<!-- 												class="list-group-item" style="display:flex;height:100%;border:0;"> -->
<%-- 												<input type="hidden" name="evaluated_no" value="${sg_infoVO.mem_no}"> --%>
<%-- 												<input type="hidden" name="sg_no" value="${sg_infoVO.sg_no}"> --%>
<%-- 												<input type="hidden" name="evaluate_no" value="${memberlistVO.mem_no}"> --%>
<!-- 												<input id="input-1" name="input-1" class="rating rating-loading" data-min="0" data-max="5" data-step="0.1" value=""> -->
<!-- 												<input type="submit" style="border:0;"> -->
<!-- 												</a> -->
<%-- 											</c:if> --%>
<%-- 									</c:forEach> --%>
<%-- 								</c:forEach> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 					<div class="container"> -->
<!-- 						<div class="row"> -->
<!-- 							<h3>我舉辦過的揪團</h3> -->
<!-- 							<div class="grid-container" style="display:grid;align-item:center;"> -->
<%-- 								<c:forEach var="sg_infoVO" items="${sghislist}"> --%>
<!-- 									<div style="width:100%;height:0;position:relative;padding-bottom:75%;overflow:hidden;border-radius:10px;"> -->
<%-- 									<img src="<%= request.getContextPath()%> --%>
<%-- 									/Sg_info/Sg_infoImg.do?sg_no=${sg_infoVO.sg_no}" style="height:100%;position:absolute;"> --%>
<!-- 									</div> -->
<%-- 									<a href="<%=request.getContextPath()%>/front-end/Sg_info/Sg_infoGetByPkForHead.jsp?Sg_no=${sg_infoVO.sg_no}" --%>
<!-- 									class="list-group-item" style="display:flex;margin-top: 37.5px;margin-bottom: 37.5px;border:0;"> -->
<%-- 									${sg_infoVO.sg_name}<br> --%>
<%-- 									團長：${memberlistService.getOneMem(sg_infoVO.mem_no).mem_name}<br> --%>
<%-- 									時間：${sg_infoVO.sg_date}<br> --%>
<!-- 									</a> -->
<%-- 								</c:forEach> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div>	 -->
<!-- 			</div> -->
<!-- 		</div> -->
	
		<jsp:include page="/front-end/CA105G1_footer_bt4.jsp"/>
		<!-- Popper js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
		<!-- Bootstrap js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
		<!-- All Plugins js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
		<!-- Active js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>
	<script>
	var status = "${status}";
	var mem_no = "${mem_no}";
	var score = "${score}";
	console.log(mem_no);
	$(function(){
		console.log(status);
		if('succeed'===status){
			swal("退團成功！", "另尋新歡吧", "success");
		}else if('false'===status){
			swal("退團失敗！", "你已經被鎖定了，無法離開", "error");
		}else if('duplicate'===status){
			swal("不能退", "哪有人退了再退退了再退", "warning");
		}else if('evaluated'===status){
			swal("評價成功", "分數:"+score+"分", "success");
		}else if('evaluatederr'===status){
			swal("評價失敗", "再試試吧", "error");
		}
		
		$('#input-1').click(function(){
			
		});
	})
	</script>
	</body>
</html>