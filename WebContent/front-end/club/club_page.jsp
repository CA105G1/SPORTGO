<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.club.model.*"%>
<%@ page import="com.post_info.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	ClubService clubSvc = new ClubService();
	List<ClubVO> list = clubSvc.getAll();
	pageContext.setAttribute("list", list);
	
//    Post_infoService post_infoSvc = new Post_infoService();
// 	Post_infoVO post_infoVO = post_infoSvc.getOnePost_info("P0001");

 //	Post_infoVO post_infoVO = (Post_infoVO)request.getAttribute("post_infoVO");
 	
 	
	List<Post_infoVO> postvolist=(ArrayList)request.getAttribute("postvolist");

	
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
				
					<div class="col-xs-12 col-sm-2" style="margin-right: -;padding-left: 5px;padding-right: 5px;">
						<%@ include file="club_pageRight.file" %>
					</div>
						
				<div class="col-xs-12 col-sm-7">
					
<!---------------------------- 貼文列表 ------------------------------------->
					<div>
						<input type="text" class="form-control" placeholder="search" style="width:15em">
	  					<button class="btn btn-primary" type="button" id="postsearch">送出</button>
					</div>
					<div class="card text-center" id="post">
							<div class="card-header">
							<br>
  							<div class="card-body">
<%-- 	<FORM METHOD="get" ACTION="<%=request.getContextPath()%>/post_info.do?" name="form">  --%>
								<c:forEach var="postinfo" items="${postvolist}">
    								<h3 class="card-title"  class="list-group-item">主題：${postinfo.post_topic}</h3>
    								<p class="card-text">${postinfo.post_content}</p>
    								<!-- 回文 -->
    								<jsp:useBean id="responesSvc" scope="page" class="com.respones.model.ResponesService" />
									<c:forEach var="responesVO" items="${responesSvc.all}">
    									<div class="h3">
    										${responesVO.res_no}---
    									</div>
    									<div class="h3">
    										${responesVO.res_content}
    									</div>
    								</c:forEach>	
    								
    								
    							
    							</c:forEach>
<!--  	</FORM> -->
  							</div> 

  							<div class="card-footer text-muted">
    						回文
  							</div>
					</div>
					<br>
									
				</div>
					
				<div class="col-xs-12 col-lg-2" id="xx">
					<div>好友列表</div>
				</div>
			</div>
		</div>
		



		
		
		</form>
		<%@ include file="/front-end/CA105G1_footer.file" %>
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
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