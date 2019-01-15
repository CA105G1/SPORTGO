<%@page import="com.memberlist.model.MemberlistService"%>
<%@page import="com.memberlist.model.MemberlistVO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="com.post_info.model.*"%>
<%@ page import="com.respones.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	ClubService clubSvc = new ClubService();
	List<ClubVO> list = clubSvc.getAll();
	pageContext.setAttribute("list", list);
	
	Post_infoService post_infoSvc = new Post_infoService();
	Post_infoVO post_infoVO = (Post_infoVO)request.getAttribute("post_infoVO");
 	
/***依照社團編號去找對應的貼文*******************************************************************/	
// 	List<Post_infoVO> postvolist=(ArrayList)request.getAttribute("postvolist");
/*********************************************************************************************/
 	ResponesVO responesVO = new ResponesVO();
 	String post_no = request.getParameter("post_no");
 	
 	
/***回文的會員*********************************************************************************/ 	
 	MemberlistService memSvc = new MemberlistService();
 	List<MemberlistVO> list2 = memSvc.getAllMem();
 	pageContext.setAttribute("list2", list2);
/*********************************************************************************************/ 
	
//  	ResponesService responesSvc = new ResponesService(); 
//  	List<ResponesVO> responeslist = responesSvc.getallfrompost(post_no);
//  	pageContext.setAttribute("list",list);
		String club_no = request.getParameter("club_no");
		ClubVO clubVO = clubSvc.getOneClub(club_no);
		request.setAttribute("ClubVO", clubVO);

		Post_infoService postinfo = new Post_infoService();
		List<Post_infoVO> postvolist = postinfo.getAllfromclub(club_no);
		request.setAttribute("postvolist", postvolist);
	
		request.getSession().setAttribute("club_no", club_no);
 	
%>


<html >
	<head>
	 	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
   		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<script src="https://cdn.ckeditor.com/ckeditor5/11.2.0/classic/ckeditor.js"></script>
		
		<style type="text/css">
			
			textarea {
  			resize : none; 
			}

			.modal-footer{
			display:flex;
   			align-items:center;
    		justify-content:center; 
			}
			
			#club_name{
			font-family:Microsoft JhengHei
			}
		
			#postsearch{
    			padding-left: 5px;
    			padding-right: 5px;
    			padding-top: 2px;
    			padding-bottom: 2px;
			}
			
		</style>
	</head>

	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	
	<%@ include file="/front-end/CA105G1_header.file" %>
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-lg-1" id="xx1"></div>
				
				<div class="col-xs-12 col-lg-2" style="margin-right: -;padding-left: 5px;padding-right: 5px;">
					<jsp:include page="club_pageRight.jsp" />
				</div>
						
				<div class="col-xs-12 col-lg-7">
<!------------------------建立貼文------------------------------------------------------------>		
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post_info.do" name="form">
						<div class="card text-center">
				  			<div class="card-header">
				   				<h3>建立貼文</h3>
				  			</div>
				  			<div class="card-body">
				    			<div class="form-group">
									<label class="post_topic">
										貼文主題
										<input type="text" name="post_topic" id="post_topic" class="form-control"  size="50">
									</label>
									<br>
									<br>
									<label class="post_content" >
										貼文內容
									<br>
									<textarea name="content" id="editor" class="form-control" ><!--貼文內容輸入框-->
										This is some sample content.
									</textarea>
									<input type="hidden" name="club_no" id="club_no" value="${post_infoVO.club_no}"/>
									<input type="hidden" name="mem_no" id="mem_no" value="${post_infoVO.mem_no}"/>
									<!-- 時間可以 -->
									</label>
								</div>
				  			</div>
				  			<div class="card-footer text-muted">
				  				<input type="hidden" name="action" value="insert">
				   				<button type="submit" class="btn btn-primary">建立</button>
				  			</div>
						</div>
					</FORM>
<!------------------------建立貼文------------------------------------------------------------>	
				<div class="col-xs-12 col-lg-2" id="xx"></div>
				</div><!-- col-xs-12 col-lg-7結束 -->
			</div><!-- row結束 -->
		</div><!-- container-fluid結束 -->
				
		<%@ include file="/front-end/CA105G1_footer.file" %>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
		$(document).ready(function() {
			$(".responesShow").click(function() {
//	 			$(".answer:not(this)").hide("slow"),
				$(this).next().slideToggle("slow");
			});
		});
			ClassicEditor
				.create( document.querySelector( '#editor' ) )
				.then( editor => {
					console.log( editor );
				} )
				.catch( error => {
					console.error( error );
				} );
		</script>
	

	</body>
</html>