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
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<title>SPORTGO 會員頁面</title>
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
		<jsp:include page="/front-end/CA105G1_header.jsp"/>
		
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="list_group.jsp"/>
				</div>
				<div class="col-xs-12 col-sm-9 tab-content">
				<!-- 訂單管理 -->
<c:forEach var="ord" items="${ordlist}">
				
        
       <div class="well col-xs-8 col-sm-8 col-md-8 col-lg-8 col-xs-offset-2 col-sm-offset-2 col-md-offset-2 col-lg-offset-2">
<!--          一開始看到畫面 -->
        <div class="row user-row">
            <div class="col-xs-1 col-sm-1">
<!--                 <img class="img-circle" -->
<!--                      src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=50" -->
<!--                      alt="User Pic"> -->
            </div>
            <div class="col-xs-10 col-sm-10">
                <strong>下訂日期</strong><br>
                <span class="text-muted">${ord.ord_date}</span><br>
                <span class="text-muted">${ord.ord_status}</span>
            </div>
            <div class="col-xs-1 col-sm-1 dropdown-user" id="drop_${ord.ord_no}" data-for=".cyruxx">
                <i class="glyphicon glyphicon-chevron-down text-muted"></i>
            </div>
        </div>
        
        
        <div class="row user-infos cyruxx">
            <div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 col-xs-offset-0 col-sm-offset-0 col-md-offset-1 col-lg-offset-1">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title">訂單資訊</h3>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                        <c:forEach var="detail" items="${OrddetailSvc.getOneOrd(ord.ord_no)}">
                            <div class="col-xs-2 col-sm-2" >
                                <img class="img-circle"
                                     src="<%=request.getContextPath()%>/pro/proImg.do?pro_no=${detail.pro_no}"
                                     alt="User Pic" style="max-width:55px;max-height:55px;border-redius:1px;">
                            </div>
<!--                             比較小的的跳行 -->
                            <div class="col-xs-10 col-sm-10">
                                <strong>商品：${prdSvc.getOneProduct(detail.pro_no).pro_name}</strong><br>
                                <strong>數量：${detail.pro_count}</strong><br>
                                <strong>數量：${detail.pro_no}</strong><br>
                            </div>
<!--                             比較大的使用table表示 -->
                        </c:forEach>
                        </div>
                    </div>
                    <div class="panel-footer">
                        <button class="btn btn-sm btn-primary" type="button"
                                data-toggle="tooltip"
                                data-original-title="Send message to user"><i class="glyphicon glyphicon-envelope"></i></button>
                        <span class="pull-right">
                            <button class="btn btn-sm btn-warning" type="button"
                                    data-toggle="tooltip"
                                    data-original-title="Edit this user"><i class="glyphicon glyphicon-edit"></i></button>
                            <button class="btn btn-sm btn-danger" type="button"
                                    data-toggle="tooltip"
                                    data-original-title="Remove this user"><i class="glyphicon glyphicon-remove"></i></button>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        </div>
				
				
				
				</c:forEach>				
				
				
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/CA105G1_footer.jsp"/>
	
	<script>
	$(document).ready(function() {
	    var panels = $('.user-infos');
	    panels.hide();
	    var panelsButton = $('.dropdown-user');
	    //Click dropdown
	    panelsButton.click(function() {
	        //get data-for attribute
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