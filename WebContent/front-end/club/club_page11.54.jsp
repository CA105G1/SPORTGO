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
	
//  Post_infoService post_infoSvc = new Post_infoService();
// 	Post_infoVO post_infoVO = post_infoSvc.getOnePost_info("P0001");
 //	Post_infoVO post_infoVO = (Post_infoVO)request.getAttribute("post_infoVO");
 	
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
					
<!---------------------------- 貼文列表 ------------------------------------->
					<div><!-- 貼文搜尋 -->
						<input type="text" class="form-control" placeholder="search" style="width:15em" />
	  					<button class="btn btn-primary" type="button" id="postsearch">送出</button>
					</div>
					<div class="card text-center" id="post">
							<br>
  							<div class="card-body">
								<c:forEach var="postinfoVO" items="${postvolist}">
    								<h3 class="card-title"  class="list-group-item">主題：${postinfoVO.post_topic}</h3>
    								<p class="card-text">${postinfoVO.post_content}</p>
    								
    								
<!-------------------------------------------- 留言版 --------------------------------------------------->
							<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/respones.do" name="form">  
  							<div class="card-footer text-muted">
									<div class="card" id="respones">
							  			<div class="card-body">
					    <!-- 留言輸入框 -->  <textarea class="form-control" name="res_content" id="res_content" placeholder="我要留言" row="5"></textarea>
											<input type="hidden" name="club_no" id="club_no" value="${postinfoVO.club_no}"/>
											<input type="hidden" name="post_no" id="post_no" value="${postinfoVO.post_no}">
											<input type="hidden" name="mem_no" id="mem_no" value="${memberlistVO.mem_no}">
											<input type="hidden" name="requestURL" id="requestURL" value="/front-end/club/club_page.jsp">
							  			</div>
							  		<br>
							  			<div class="card-footer text-muted">
							  				<input type="hidden" name="action" value="insert">
							    			<button type="submit" class="btn btn-primary">送出</button>
							  			</div>
									</div>
  							</div>
							</FORM> <!-- /respones.do -->		
  							
<!-------------------------------------------- 留言版 ---------------------------------------------------->
<!----------------------------------------------回文------------------------------------------------------>
							<div class="dropdown">
					  			<button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
					    			顯示所有留言
					  			</button>
  									<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">  
										<div class="dropdown-item">
												<table class="table">
													<jsp:useBean id="responesSvc" scope="page" class="com.respones.model.ResponesService"/>
													<c:forEach var="responesVO" items="${responesSvc.getallfrompost(postinfoVO.post_no)}">
											<!-- 刪除 --><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/respones.do" name="form">
				    									<tr>
				    										<input type="hidden" name="res_no" id="res_no" value="${responesVO.res_no}"/>
				    										<jsp:useBean id="post_infoSvc" scope="page" class="com.post_info.model.Post_infoService"/>
				    										<input type="hidden" name="club_no" id="club_no" value="${post_infoSvc.getOnePost_info(responesVO.post_no).getClub_no()}"/>
					      			 <!-- 回文者的照片-->    		<td scope="col">
					      			 								<img src="<%=request.getContextPath()%>/showPicture?mem_no=${responesVO.mem_no}" >
					      			 							</td>
					      				 <!-- 回文內容-->		<td scope="col">
					      				 							${responesVO.res_content}
				      				 							</td>
				      				 							<td>
			 													<button type="submit" class="btn btn-light" name="action" value="delete" >
 							 										刪除 
 																</button>
				      				 							</td> 
 				      				 						
				    									</tr>
											<!-- 刪除 --></FORM>
			    									</c:forEach>	
												</table>
										</div>
  									</div>
							</div>
<!----------------------------------------------回文------------------------------------------------------>
   								</c:forEach><!-- 最外層postinfoVO的 -->
  							</div> <!-- card-body結束 -->


					
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