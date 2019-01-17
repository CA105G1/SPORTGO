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
	//session中有memberlistVO、club_no，EL直接拿了就用
	String club_no = (String)session.getAttribute("club_no");
	ClubService svc = new ClubService();
	ClubVO clubVO = svc.getOneClub(club_no);
	request.setAttribute("clubVO",clubVO);
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

	<body>
	<jsp:include page="/front-end/CA105G1_header.jsp" />
		<div class="container">
			<div class="row">
				
				<div class="col-xs-12 col-sm-2" style="margin-right: -;padding-left: 5px;padding-right: 5px;">
					<jsp:include page="/front-end/club/club_pageRight.jsp" />
				</div>
						
				<div class="col-xs-12 col-sm-8">
<!------------------------建立貼文------------------------------------------------------------>		
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post_info.do" name="form">
						<div class="card text-center">
				  			<div class="card-header">
				   				<h3>建立貼文</h3>
				  			</div>
				  			<br>
				  			<div class="card-body">
				    			<div class="form-group">
									<label class="post_topic">
										貼文主題
										<input type="text" name="post_topic" id="post_topic" class="form-control"  size="50" value="${post_topic}">
									</label>
									<br>
									<br>
									<label >
										貼文內容
									<br>
									<!--貼文內容輸入框-->
									 <textarea name="editor" id="editor"  class="form-control" value="${editor}"></textarea>
<%-- 									<textarea name="editor" id="post_content"  class="form-control" value="${editor}"></textarea> --%>
               					
									<input type="hidden" name="club_no" id="club_no" value="${club_no}"/>
									<input type="hidden" name="mem_no" id="mem_no" value="${mem_no}"/>
									<!-- 時間可以不寫 -->
									</label>
								</div>
				  			</div>
				  			<div class="card-footer text-muted">
				  				<input type="hidden" name="action" value="insert">
				   				<button type="submit" class="btn btn-primary">建立</button>
				  			</div>
						</div>
					</FORM>
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
				<div class="col-xs-12 col-sm-2" id="xx">
<%-- 					<div>clubVO = ${clubVO }</div> --%>
				</div>
			</div><!-- row結束 -->
		</div><!-- container-fluid結束 -->
				
		<jsp:include page="/front-end/CA105G1_footer.jsp" />
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
		
		  ClassicEditor
          .create( document.querySelector( '#editor' ) ,{
			  cloudServices: {
	                tokenUrl: 'https://36858.cke-cs.com/token/dev/P5oQfFj6vNube6BjhQLtEsAgtQ20tO0VqKeFLOzYFOlf4jS12ccjhd8UW1LX',
	                uploadUrl: 'https://36858.cke-cs.com/easyimage/upload/'
	                	     }
		})
          .then( editor => {
                  console.log( editor );
          } )
          .catch( error => {
                  console.error( error );
          } );
		
		</script>
	

	</body>
</html>