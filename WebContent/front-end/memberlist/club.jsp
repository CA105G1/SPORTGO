<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>

<% 
	String action = (String) request.getAttribute("action");
// 	if(action == null)
// 		pageContext.setAttribute("action", "");
// 	else
		pageContext.setAttribute("action", action);
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
				<!-- 社團管理 -->
				社團
				
				
				
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/CA105G1_footer.jsp"/>
	<script>
	var action = "${action}";
	
	$(function(){
	    $(document).on('shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
	        localStorage.setItem('activeTab', $(e.target).attr('href'));
	    })

	    var hash = window.location.hash;
	    var activeTab = localStorage.getItem('activeTab');

	    if(hash){
	          $('#project-tabs  a[href="' + hash + '"]').tab('show');   
	    }else if (activeTab){
	        $('#project-tabs a[href="' + activeTab + '"]').tab('show');
	    }
	    
	    changePage();
	});
	
	function changePage(){
		console.log(action);
		if(action === 'Member_renew'){
			$('#myTab').find('a[href="#renew"]').trigger('click');
		} else if(action === ''){
			
		} else {
			$('#myTab').find('a[href="#mem"]').trigger('click');
		}
	}
	</script>
	</body>
</html>