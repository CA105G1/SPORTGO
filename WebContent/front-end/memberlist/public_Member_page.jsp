<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
<%
	String mem_no = (String)request.getParameter("mem_no");
	MemberlistService service = new MemberlistService();
	MemberlistVO memberlistVO = service.getOneMem(mem_no);
	pageContext.setAttribute("member", memberlistVO);
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
			.list-group-item{
				text-align: center;
				font-size: large;
				height: 80px;
				display: flex;
				justify-content: space-around;
				align-items: center;
			}
			.center{
				display:flex;
				justify-content:center;
			}
			img{
				max-width:300px;
				max-height:300px;
			}
			
		</style>
	</head>
	<body>
		<%@ include file="/front-end/CA105G1_header.file"%>
		<div class="container-fluid">
		</div>

		<!-- 右選單 -->
		<div class="container-fulid">
			<div class="row">
				<div class="col-xs-12 col-sm-2">
				</div>
				<div class="col-xs-12 col-sm-8 center">
				<!-- 個人頁面 -->
					<div class="tab-pane active" id="mem">
						<img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}">
						<ul class="list">
							<li>姓名 : ${member.mem_name}</li>
							<li>暱稱 : ${member.mem_nick}</li>
						</ul>
					</div>
					<div class="col-xs-12 col-sm-2">
					</div>
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/CA105G1_footer.file"/>
	<script>

	</script>
	</body>
</html>