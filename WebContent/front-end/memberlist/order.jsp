<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.ord.model.*" %>

<% 
	MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
	if(memberlistVO==null){
		response.sendRedirect("Login.jsp");
		return;
	}
	String mem_no = memberlistVO.getMem_no();
	OrdService ordservice = new OrdService();
	

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
				<!-- 訂單管理 -->
				<a class="btn btn-info" href="Creditcard.jsp">信用卡</a>
				
				
				
				
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/CA105G1_footer.jsp"/>
	<script>
	</script>
	</body>
</html>