<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.club.model.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.club_memberlist.model.*"%>
<%@ page import="com.memberlist.model.*"%>
<!DOCTYPE html>
<html lang=""> 
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>club_pageRight</title>
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
		
	</head> 
	<body>
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row" style="text-align:center" >
				<div class="card" style="background-color:#444444;width:100%">
					<div class="card-header" >
						<h6 id="club_name" style=" font-weight:bold;  color:white">
							${clubVO.club_name}
						</h6>
					</div>
					<div class="list-group list-group-flush" style="width:100%; ">
						<a href="<%= request.getContextPath()%>/front-end/club/club_intro_page.jsp" class="list-group-item list-group-item-action">簡介</a>
						<a href="<%= request.getContextPath()%>/front-end/post_info/create_post.jsp" class="list-group-item list-group-item-action" >建立貼文</a>
						<a href="<%= request.getContextPath()%>/front-end/club/club_page.jsp" class="list-group-item list-group-item-action">貼文列表</a>
						<a href="<%= request.getContextPath()%>/front-end/club/Sg_infoList.jsp" class="list-group-item list-group-item-action">專屬揪團</a>
						<a href="<%= request.getContextPath()%>/front-end/club_memberlist/reviewaddclub.jsp" id="clubManage" class="list-group-item list-group-item-action" style="display:none">社團管理</a>
						<a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp"class="list-group-item list-group-item-action">返回列表</a>
					</div>	
					<button type="button" class="btn btn-dark" id="joinbtn" style="display:">加入社團</button>	
					<button type="button" class="btn btn-dark" id="outbtn" style="display:none">退出社團</button>	
				</div>
			</div>
		</div>
	</body>
	
<script>
<%MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");%>

<%if(memberlistVO == null){
	session.setAttribute("location", request.getRequestURI());%>
	$("#joinbtn").click(function(){
		document.location.href="<%= request.getContextPath()%>/front-end/memberlist/Login.jsp";
		return;
	});
<%}else{%>

	//判斷是否為管理員
	<%
	boolean isManager = false;
	Club_memberlistService svc = new Club_memberlistService();
	String club_no = (String)session.getAttribute("club_no");
	System.out.println("club_no======="+club_no);
	Club_memberlistVO club_memberlistVO = svc.getOneClubmemberlist(club_no, memberlistVO.getMem_no());
	System.out.println("club_memberlistVO==="+club_memberlistVO.getCmem_class());
	if(club_memberlistVO != null && "管理員".equals(club_memberlistVO.getCmem_class())){
		isManager = true;
	}
 	%> 
 	
 	
	//若是管理員才能進入社團管理頁面
	if(<%=isManager%>){
		console.log($("#clubManage"));
		console.log(<%=isManager%>);
		console.log("test");
		$("#clubManage").show();
// 		document.getElementById("clubManage").style.display("");
// 		$("a[name='someName']").css("display","");
	}
	

	//判斷是否重複加入
	<%
	boolean isJoin = false;
	List<Club_memberlistVO> list2 = svc.getByMem(memberlistVO.getMem_no());
System.out.print("memno="+memberlistVO.getMem_no());
	for(Club_memberlistVO club_memberlistvo : list2) {
		if(club_memberlistvo.getClub_no().equals(club_no)) {
			isJoin = true;
		}
	}
	%>
	
	//變換加入或退出按鍵
	if(<%=isJoin%>){
		$("#joinbtn").css("display","none");
		$("#outbtn").css("display","");
		
	}


//////////////////加入社團按鍵設定///////////////////////////
	$("#joinbtn").click(function(){
		$.ajax({
			type: "POST",
			url: "<%= request.getContextPath()%>/club_memberlist.do",
			data: {"action" : "addintoclub", "club_no" : "${club_no}", "mem_no" : "<%= memberlistVO.getMem_no()%>", "location" : "<%=request.getRequestURI()%>"},
			dataType: "json",
			error: function(){
				alert("發生錯誤!");
			},
			success: function(data){
				swal({
					  title: "成功提出申請!", type: "success", showCloseButton: true,confirmButtonText: "確定"
					}).then(
						function (result) {
						if(result){
							location.reload();
						}
						},function(dismiss) {
							location.reload();
						});
			}
		}); //ajax
	}); //joinbtn click
	
	
	$("#outbtn").click(function(){
		swal({
		  title: "確定退出?", type: "warning", showCancelButton: true, showCloseButton: true,
		}).then(
			function (result) {
			if(result){
				$.ajax({
					type: "POST",
					url: "<%= request.getContextPath()%>/club_memberlist.do",
					data: {"action" : "dropoutclub", "club_no" : "${club_no}", "mem_no" : "<%= memberlistVO.getMem_no()%>", "location" : "<%=request.getRequestURI()%>"},
					dataType: "json",
					error: function(){
						alert("發生錯誤!");
					},
					success: function(data){
						location.reload();
					}
				});
			}
		});
	});
	
	
	
	
	
<%}%> //else

</script>
	
	
</html>