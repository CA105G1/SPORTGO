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
// 	String mem_no = (String)session.getAttribute("mem_no");
String club_no = (String)session.getAttribute("club_no");
request.setAttribute("club_no", club_no);
ClubService clubSvc = new ClubService();
ClubVO clubVO = clubSvc.getOneClub(club_no);
request.setAttribute("clubVO", clubVO);
%>

<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>編輯貼文</title>
		
<link   rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
			.ck-editor__editable{
				min-height: 350px;
			}
			
		</style>
</head>
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
                        <li class="breadcrumb-item active" aria-current="page">編輯貼文</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>

<div class="container">
			<div class="row">
				
				<div class="col-xs-12 col-sm-2" style="margin-right: -;padding-left: 5px;padding-right: 5px;">
					<jsp:include page="/front-end/club/club_pageRight.jsp" />
				</div>
						
				<div class="col-xs-12 col-sm-7">
<!------------------------建立貼文------------------------------------------------------------>		
		<!-- FORM開始 --><FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post_info.do" name="form">
<%-- 						<c:forEach var="Post_infoVO" items="${list}"> --%>
						<jsp:useBean id="post_infoSvc" scope="page" class="com.post_info.model.Post_infoService"/>
						<div class="card text-center" style="border-style:none;">
				  			<div class="card-header" style="border-style:none;">
				   				<h3>編輯貼文</h3>
				  			</div>
				  			<br>
				  			<div class="card-body">
				    			<div class="form-group">
									<label class="post_topic">
										貼文主題
										<input type="text" name="post_topic" id="post_topic" class="form-control"  size="50" value="${post_infoVO.post_topic}">
									</label>
									<br>
									<br>
									<label>
										貼文內容
										<br>
										<!--貼文內容輸入框-->
										<textarea name="editor" id="editor"  class="form-control" >
									 		${post_infoVO.post_content}
										</textarea>
									</label>
									<input type="hidden" name="post_no" id="post_no" value="${post_infoVO.post_no}"/>
									<input type="hidden" name="club_no" id="club_no" value="${post_infoVO.club_no}"/>
									<input type="hidden" name="mem_no" id="mem_no" value="${post_infoVO.mem_no}"/>
									<input type="hidden" name="post_date" id="post_date" value="${post_infoVO.post_date}"/>
								</div>
				  			</div>
				  			<div class="card-footer text-muted" style="border-style:none;">
				  				<input type="hidden" name="action" value="update">
				   				<button type="submit" class="btn btn-success">送出修改</button>
				  			</div>
						</div>
<%-- 					</c:forEach> --%>
<!-- FORM結束-->	</FORM> 
					
						<%-- 錯誤表列 --%>
						<c:if test="${not empty errorMsgs}">
							<font style="color:red">請修正以下錯誤:</font>
							<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color:red">${message}</li>
							</c:forEach>
							</ul>
						</c:if>
<!------------------------建立貼文------------------------------------------------------------>	
				</div><!-- col-xs-12 col-lg-8結束 -->
				<div class="col-xs-12 col-sm-3" id="xx"><!--社團成員列表-->
					<jsp:include page="/front-end/club_memberlist/clubmember_list.jsp" />
				</div>
			</div><!-- row結束 -->
		</div><!-- container-fluid結束 -->
				
		<!-- Footer頁尾 -->
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