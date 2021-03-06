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
//	依照社團編號去找對應的貼文
// 	List<Post_infoVO> postvolist=(ArrayList)request.getAttribute("postvolist");
 	ResponesVO responesVO = new ResponesVO();
 	
/***回文的會員*********************************************************************************/ 	
 	MemberlistService memSvc = new MemberlistService();
 	List<MemberlistVO> list2 = memSvc.getAllMem();
 	pageContext.setAttribute("list2", list2);
/*********************************************************************************************/ 
	 
		String club_no = (String)session.getAttribute("club_no");
		request.setAttribute("club_no", club_no);
		ClubService clubSvc = new ClubService();
		ClubVO clubVO = clubSvc.getOneClub(club_no);
		request.setAttribute("clubVO", clubVO);
		Post_infoService postinfo = new Post_infoService();
		
		
		
		
		List<Post_infoVO> postvolist = postinfo.getAllfromclub(club_no);
		request.setAttribute("postvolist", postvolist);
////////////

		
%>


<html >
	<head>
	 	<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>貼文列表</title>
		
<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>

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
			
/* 			#club_name{ */
/* 			font-family:Microsoft JhengHei */
/* 			} */
		
			#postsearch{
    			padding-left: 5px;
    			padding-right: 5px;
    			padding-top: 2px;
    			padding-bottom: 2px;
			}
			
			#btnGroupDrop1{
				
    border-left-width: 1px;
    padding-left: 5px;
    padding-right: 5px;
    padding-top: 3px;
    padding-bottom: 3px;

			}
			
			
			
		</style>
	</head>

	<!--data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" -->

	<body>
	
	<jsp:include page="/front-end/CA105G1_header_bt4.jsp" />
	
	
	<!-- 麵包屑 -->
<div class="breadcrumb-area">
    <!-- Top Breadcrumb Area -->
    <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/sgpic/sportbg2.jpg);">
    </div>

    <div class="container">
        <div class="row">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/index.jsp"><i class="fa fa-home"></i> 首頁</a></li>
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/front-end/club/club_list.jsp">社團專區</a></li>
                        <li class="breadcrumb-item active" aria-current="page">貼文列表</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
	
	
		<div class="container">
			<div class="row">
				
				<div class="col-xs-12 col-sm-2" style="margin-right: -;padding-left: 5px;padding-right: 5px;">
					<jsp:include page="club_pageRight.jsp" />
				</div>
						
				<div class="col-xs-12 col-sm-7">
					
<!------------------------------------------ 關鍵字查詢 --------------------------------------------------->
<!--查詢的FORM-->	<form method="post" action="<%= request.getContextPath()%>/post_info.do" style=" margin-left: 380px;">
				  	<div class="input-group" style="width:230px">
                    	<input type="text" class="form-control" placeholder="請輸入關鍵字" name="keyword" id="keyword">
                    	<span class="input-group-btn" ><!--style="display:none"-->
                    		<input type="hidden" name="action" value="postCompositeQuery">
                    		<input type="hidden" name="club_no" value="${sessionScope.club_no}"> 
                        	<button class="btn btn-default" type="submit">GO</button>
                    	</span>
                	</div><!-- input-group -->
<!--查詢的FORM-->	</form>
<!----------------------------------------- 顯示貼文列表 -------------------------------------------------->
<!-- 貼文刪除FORM --><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post_info.do" name="form">  
					<div class="card text-center" id="post" style="border-style:none;">
  							<div class="card-body">
								<c:forEach var="postinfoVO" items="${postvolist}">
    								<h3 class="card-title"  class="list-group-item">
    									${postinfoVO.post_topic}
    								</h3>
    						<c:if test="${memberlistVO.mem_no==postinfoVO.mem_no}"><!--文章僅限發布者修改&刪除-->		
									<a href='<%=request.getContextPath()%>/post_info.do?action=getOnePost_display&post_no=${postinfoVO.post_no}'">編輯</a>
									<a href='<%=request.getContextPath()%>/post_info.do?action=delete&post_no=${postinfoVO.post_no}'">刪除</a>
							</c:if>		
    								<p class="card-text">${postinfoVO.post_content}</p><!--貼文內容 -->   								
<!-- 貼文刪除FORM --></FORM> 
<!-------------------------------------------- 新增留言 --------------------------------------------------->
		<!-- 新增的FORM --><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/respones.do" name="form">  
  							<div class="card-footer text-muted" style="border-style:none;">
									<div class="card" id="respones" style="border-style:none;">
							  			<div class="card-body">
					   	   <!-- 留言輸入框 --><textarea class="form-control" name="res_content" id="res_content" placeholder="我要留言" row="5"></textarea>
											<input type="hidden" name="club_no" id="club_no" value="${postinfoVO.club_no}"/>
											<input type="hidden" name="post_no" id="post_no" value="${postinfoVO.post_no}">
											<input type="hidden" name="mem_no" id="mem_no" value="${memberlistVO.mem_no}">
											<input type="hidden" name="requestURL" id="requestURL" value="/front-end/club/club_page.jsp">
							  			</div>
<!-- 							  		<br> -->
							  			<div class="card-footer text-muted" style="border-style:none;">
							  				<input type="hidden" name="action" value="insert">
							    			<button type="submit" class="btn btn-primary">送出</button>
							  			</div>
									</div>
  							</div>
		<!-- 新增的FORM --></FORM> 	
  							
<!--------------------------------------------新增留言 ---------------------------------------------------->
<!------------------------------------------顯示&刪除留言-------------------------------------------------->
							<jsp:useBean id="responesSvc" scope="page" class="com.respones.model.ResponesService"/>
							<div class="comment_area clearfix">
							    <h4 class="headline">留言區</h4>
							<c:forEach var="responesVO" items="${responesSvc.getallfrompost(postinfoVO.post_no)}"><!-- 內層forEach -->
		 <!-- 刪除的FORM --><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/respones.do" name="form"> 
							    <ol>
							        <!-- Single Comment Area -->
							        <li class="single_comment_area">
							            <div class="comment-wrapper d-flex">
							                <!-- Comment Meta -->
							                <input type="hidden" name="res_no" id="res_no" value="${responesVO.res_no}"/>
							                <jsp:useBean id="post_infoSvc" scope="page" class="com.post_info.model.Post_infoService"/>
							                <input type="hidden" name="club_no" id="club_no" value="${post_infoSvc.getOnePost_info(responesVO.post_no).getClub_no()}"/>
							                <div class="comment-author">
							                    <img src="<%=request.getContextPath()%>/front-end/memberlist/showPicture.do?mem_no=${responesVO.mem_no}" alt=""><!-- 留言者照片 -->
							                </div>
							                <!-- Comment Content -->
							                <div class="comment-content">
							                    <div class="d-flex align-items-center justify-content-between">
<!-- 							                        <h5>留言者名</h5> -->
<%-- 							                        <span type="submit" class="delete_${responesVO.mem_no}" name="action" value="delete" style="display:none;" > --%>
<!-- 			 							 					刪除  -->
<!-- 							                        </span> -->
							                    </div>
							                    <p>${responesVO.res_content}</p>
							                    <button type="submit" class="btn btn-light delete_${responesVO.mem_no}" name="action" value="delete" style="display:none;" >
  							 						刪除  
  												</button> 
							                </div>
							            </div>
							        </li>
							    </ol>
							    </c:forEach><!-- 內層forEach -->
							</div>

<!-- 					  		<button class="responesShow btn  btn-link" type="button" id="dropdownMenuButton" data-toggle="" aria-haspopup="true" aria-expanded="false"> -->
<!-- 					    		顯示所有留言 -->
<!-- 					  		</button> -->
<!------------------------------------------顯示&刪除留言-------------------------------------------------->
   								</c:forEach><!-- 最外層postinfoVO的 -->
  							</div> <!-- card-body結束 -->
					</div><!-- card text-center結束 -->
				</div><!-- col-xs-12 col-lg-7結束-->
				<div class="col-xs-12 col-sm-3" id="xx"><!--社團成員列表-->
					<jsp:include page="/front-end/club_memberlist/clubmember_list.jsp" />
				</div>
			</div><!-- row結束 -->
		</div><!-- 最外層container-fluid結束 -->
				
		<jsp:include page="/front-end/CA105G1_footer_bt4.jsp" />
		
		
	<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
<!-- Popper js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
<!-- Bootstrap js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
<!-- All Plugins js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
<!-- Active js -->
<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>

		
		
		
		
		
		<script>
		console.log("delete_${mem_no}");
		$(function() {
			$(".delete_${mem_no}").css("display","inline");
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