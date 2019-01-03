<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.sg_info.model.*" %>
<%
	String mem_no = (String)request.getParameter("mem_no");
	MemberlistService service = new MemberlistService();
	MemberlistVO memberlistVO = service.getOneMem(mem_no);
	pageContext.setAttribute("member", memberlistVO);
	
	String status = (String)request.getAttribute("status");
	if(status==null)
		pageContext.setAttribute("status","");
	else
		pageContext.setAttribute("status",status);
	System.out.print(status);
%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
			h1{
				text-align: center;
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
						<h1>${member.mem_name}</h1>
						<img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}">
						<form method="post" action="Friend.do" style="display:flex;justify-content:center;">
							<input type="hidden" name="action" value="add_Friend">
							<input type="hidden" name="mem2_no" value="${member.mem_no}">
							<input type="submit" class="btn btn-info"
							 value="好友加加">
						</form>
					</div>
					<div class="col-xs-12 col-sm-2">
					</div>
				</div>	
			</div>
		</div>
	<jsp:include page="/front-end/CA105G1_footer.file"/>
	<script>
	var status = "${status}";
	$(function(){
		console.log(status);
		if('succeed'===status){
			swal("加入成功！", "等待好友的回應吧", "success");
		}else if('false'===status){
			swal("加入失敗！", "可憐小蟲蟲", "error");
		}else if('duplicate'===status){
			swal("已經是好友了！", "就算很愛他也不可以這樣喔", "warning");
		}
	})
	</script>
	</body>
</html>