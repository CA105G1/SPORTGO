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
	
//    Post_infoService post_infoSvc = new Post_infoService();
// 	Post_infoVO post_infoVO = post_infoSvc.getOnePost_info("P0001");

 //	Post_infoVO post_infoVO = (Post_infoVO)request.getAttribute("post_infoVO");
 	
/*********************************************************************************************/	
	List<Post_infoVO> postvolist=(ArrayList)request.getAttribute("postvolist");
/*********************************************************************************************/
	
// 	ResponesVO responesVO = new ResponesVO();
// 	String post_no = request.getParameter("post_no");
	
// 	ResponesService responesSvc = new ResponesService(); 
	
// 	List<ResponesVO> responeslist = responesSvc.getallfrompost(post_no);
// 	pageContext.setAttribute("list",list);
	
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
					
<!---------------------------- 貼文列表 ------------------------------------->
					<div>
						<input type="text" class="form-control" placeholder="search" style="width:15em" />
	  					<button class="btn btn-primary" type="button" id="postsearch">送出</button>
					</div>
					<div class="card text-center" id="post">
							<div class="card-header"></div>
							<br>
  							<div class="card-body">
								<c:forEach var="postinfo" items="${postvolist}">
    								<h3 class="card-title"  class="list-group-item">主題：${postinfo.post_topic}</h3>
    								<p class="card-text">${postinfo.post_content}</p>
<!--     								回文 -->
<%--     								<jsp:useBean id="responesSvc" scope="page" class="com.respones.model.ResponesService" /> --%>
<%-- 									<c:forEach var="responesVO" items="${responesSvc.all}"> --%>
<!--     									<div class="h3"> -->
<%--     										${responesVO.res_no}--- --%>
<!--     									</div> -->
<!--     									<div class="h3"> -->
<%--     										${responesVO.res_content} --%>
<!--     									</div> -->
<%--     								</c:forEach>	 --%>
    							</c:forEach>
  							</div> <!-- card-body結束 -->
<!-------------------------------------------- 留言版 --------------------------------------------------->
  							<div class="card-footer text-muted">
								<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/respones.do?" name="form">  
									<div class="card" id="respones">
							  			<div class="card-header">
							   				留言版
							  			</div>
							  				<div class="card-body">
							    			<textarea class="form-control" name="res_content" id="res_content"></textarea><!--留言區塊-->
											<input type="hidden" name="post_no" id="post_no">
											<input type="hidden" name="mem_no" id="mem_no">
											<input type="hidden" name="res_date" id="res_date">
							  				</div>
							  				<br>
							  			<div class="card-footer text-muted">
							  				<input type="hidden" name="action" value="insert">
							    			<button type="submit" class="btn btn-primary">送出</button>
							  			</div>
									</div>
								</FORM> 		
  							</div>
<!-------------------------------------------- 留言版 ---------------------------------------------------->
<!----------------------------------------------回文------------------------------------------------------>
							<div class="res_content">
    								<jsp:useBean id="responesSvc" scope="page" class="com.respones.model.ResponesService" />
									<c:forEach var="responesVO" items="${responesSvc.all}">
    									<div class="h3">
    										${responesVO.res_no}---
    									</div>
    									<div class="h3">
    										${responesVO.res_content}
    									</div>
    								</c:forEach>	
							</div>
<!----------------------------------------------回文------------------------------------------------------>
					
							<div class="col-xs-12 col-lg-2" id="xx">
								<div>好友列表</div>
							</div>
						</div>
					</div>
				</div>
			</div>
				
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