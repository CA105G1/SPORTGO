<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.ord.model.*" %>
<%@ page import = "com.orddetails.model.*" %>
<%@ page import = "java.util.*" %>
<jsp:useBean id="prdSvc" scope="page" class="com.product.model.ProductService"/>
<jsp:useBean id="OrddetailSvc" scope="page" class="com.orddetails.model.OrddetailsService"/>
<% 
	MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
	if(memberlistVO==null){
		response.sendRedirect("Login.jsp");
		return;
	}
	String mem_no = memberlistVO.getMem_no();
	OrdService ordservice = new OrdService();
	List<OrdVO> ordlist = ordservice.getAllmem_no(mem_no);
	pageContext.setAttribute("ordlist", ordlist);

%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
		<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
		<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
		<title>SPORTGO 會員訂單管理</title>
		<style type="text/css">
			.container{
				width: 100%;
			}
			center{
				font-size: xx-large;
				color: red;
			}
			.user-row {
    margin-bottom: 14px;
}

.user-row:last-child {
    margin-bottom: 0;
}

.dropdown-user {
    margin: 13px 0;
    padding: 5px;
    height: 100%;
}

.dropdown-user:hover {
    cursor: pointer;
}

.table-user-information > tbody > tr {
    border-top: 1px solid rgb(221, 221, 221);
}

.table-user-information > tbody > tr:first-child {
    border-top: 0;
}


.table-user-information > tbody > tr > td {
    border-top: 0;
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
		<!-- 右選單 -->
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="list_group.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9">
				<!-- 訂單管理 -->
					<c:forEach var="ord" items="${ordlist}">
						<div class="container">
							<div class="well col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xs-offset-2 col-sm-offset-2 col-md-offset-2 col-lg-offset-2">
					        	<div class="row user-row">
					            	<div class="col-xs-3 col-sm-2 col-md-1 col-lg-1">
					<!--                 <img class="img-circle" -->
					<!--                      src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=50" -->
					<!--                      alt="User Pic"> -->
					            	</div>
            						<div class="col-xs-8 col-sm-9 col-md-10 col-lg-10">
						                <strong>下訂日期</strong><br>
						                <span class="text-muted">${ord.ord_date}</span><br>
						                <span class="text-muted">${ord.ord_status}</span>
						            </div>
						            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 dropdown-user"  id="drop_${ord.ord_no}" data-for=".cyruxx_${ord.ord_no}">
						                <i class="fa fa-caret-down"></i>
						            </div>
        						</div>
						        <div class="row user-infos cyruxx_${ord.ord_no}">
						            <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1">
						                <div class="panel panel-primary">
						                    <div class="panel-heading">
						                        <h3 class="panel-title">訂單資訊</h3>
						                    </div>
						                    <div class="panel-body">
						                        <div class="row">
						                        <c:forEach var="detail" items="${OrddetailSvc.getOneOrd(ord.ord_no)}">
						                            <div class="col-xs-2 col-sm-2 hidden-md hidden-lg">
						                                <img class="img-circle"
						                                     src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${detail.pro_no}"
						                                     alt="User Pic" style="max-width:55px;max-height:55px;border-redius:1px;">
						                            </div>
						                            <div class="col-xs-10 col-sm-10">
						                                <strong>商品：${prdSvc.getOneProduct(detail.pro_no).pro_name}</strong><br>
						                                <strong>數量：${detail.pro_count}</strong><br>
						                            </div>
						                        </c:forEach>
						                        </div>
						                    </div>
						                    <div class="panel-footer">
						<!--                         <button class="btn btn-sm btn-primary" type="button" -->
						<!--                                 data-toggle="tooltip" -->
						<!--                                 data-original-title="Send message to user"><i class="glyphicon glyphicon-envelope"></i></button> -->
						<!--                         <span class="pull-right"> -->
						<!--                             <button class="btn btn-sm btn-warning" type="button" -->
						<!--                                     data-toggle="tooltip" -->
						<!--                                     data-original-title="Edit this user"><i class="glyphicon glyphicon-edit"></i></button> -->
						<!--                             <button class="btn btn-sm btn-danger" type="button" -->
						<!--                                     data-toggle="tooltip" -->
						<!--                                     data-original-title="Remove this user"><i class="glyphicon glyphicon-remove"></i></button> -->
						<!--                         </span> -->
						                    </div>
						                </div>
						            </div>
        						</div>
        					</div>
        				</div>
				</c:forEach>				
				
				
				
				
				
				
				
				
				
				</div>	
			</div>
		</div>
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
	$(document).ready(function() {
	    var panels = $('.user-infos');
	    panels.hide();
	    var panelsButton = $('.dropdown-user');
	    //Click dropdown
	    panelsButton.click(function() {
	        //get data-for attribute
	        console.log(this.id);
	        var dataFor = $(this).attr('data-for');
	        var idFor = $(dataFor);

	        //current button
	        var currentButton = $(this.id);
	        idFor.slideToggle(400, function() {
	            //Completed slidetoggle
	            if(idFor.is(':visible'))
	            {
	                currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
	            }
	            else
	            {
	                currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
	            }
	        })
	    });


	    $('[data-toggle="tooltip"]').tooltip();

	    $('button').click(function(e) {
	        e.preventDefault();
	        alert("This is a demo.\n :-)");
	    });
	});
	</script>
	</body>
</html>