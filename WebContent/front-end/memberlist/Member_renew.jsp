<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>修改個人資訊</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
	<link rel="icon" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/img/core-img/leaf.png">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/style.css">
	<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/jquery/jquery-2.2.4.min.js"></script>
	<script src="<%= request.getContextPath()%>/datetimepicker/jquery.js"></script>
	<script src="<%= request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>
  <style type="text/css">
  	img{
  		max-width:300px;
  		max-higth:300px;
  	}
  	.error{
  		color:red;
  	}
  	.container{
  		align:center;
  	}
  	.form-group{
  		display:flex;
  	}
  </style>
</head>
<body>
	<jsp:include page="/front-end/CA105G1_header_bt4.jsp"/>
	<div class="breadcrumb-area">
	    <div class="top-breadcrumb-area bg-img bg-overlay d-flex align-items-center justify-content-center" style="background-image: url(<%= request.getContextPath()%>/img/badmintoncount.JPG);">
	    </div>
	</div>
	<div class="container">
            <div class="row">
                <div class="col-12">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/index.jsp"><i class="fa fa-home"></i>首頁</a></li>
                            <li class="breadcrumb-item" aria-current="page"><a href="public_Member_page.jsp">會員專區</a></li>
                            <li class="breadcrumb-item active" aria-current="page">個人頁面管理</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
	<div class="container">
		<div class="row">
		<div class="col-12 col-sm-3 col-md-3">
			<jsp:include page="list_group.jsp"/>
		</div>
		<div class="col-12 col-sm-9 col-md-9">
		
		  <h2>修改個人資訊</h2>
		  <form method="post" class="form-horizontal" enctype="multipart/form-data" action="MemManager.do">
			  <div style="text-align:center;">
			  	<img class="preview" src="showPicture.do?mem_no=${memberlistVO.mem_no}">
			  </div>
		  		<br>
<!-- 		  錯誤時的畫面 -->
		  	<c:if test="${not empty errorMsgs}">
				<ul class="error">
					<c:forEach var="message" items="${errorMsgs}">
						<li>${message.value}</li>
					</c:forEach>
				</ul>
				<div class="form-group">
			      <label class="control-label col-sm-2" for="picture">更換大頭貼</label>
			      <div class="col-sm-10">
					<input type="file" name="picture" class="upl">
			      </div>
			    </div>
				<div class="form-group">
			      <label class="control-label col-sm-2" for="name">姓名</label>
			      <div class="col-sm-10">
			        <input type="text" class="form-control" size="30" id="name" value="${mem_name}" name="name">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="nick">暱稱</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" size="30" id="nick" value="${mem_nick}" name="nick">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="password">密碼</label>
			      <div class="col-sm-10">          
			        <input type="password" class="form-control" size="30" id="password" value="${mem_pswd}" name="password">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="email">電子郵件</label>
			      <div class="col-sm-10">          
			        <input type="email" class="form-control" size="30" id="email" value="${mem_email}" name="email">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="phone">電話</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" size="30" id="phone" value="${mem_phone}" name="phone">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="emgc">緊急聯絡人</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" size="30" id="emgc" value="${mem_emgc}" name="emgc">
			      </div>
			    </div>
			    <div class="form-group">
				    <div  style="display:flex;justify-content:center;">
				        <button type="submit" class="btn btn-info" name="action" value="Member_renew">修改</button>
				        <button type="submit" class="btn btn-info" name="action" value="cancel">取消</button>
				    </div>        
		    	</div>
			</c:if>
<!-- 			剛進入的畫面 帶入原本的值 -->
			<c:if test="${empty errorMsgs}">
				<div class="form-group">
			      <label class="control-label col-sm-2" for="picture">更換大頭貼</label>
			      <div class="col-sm-10">
					<input type="file" name="picture" class="upl">
			      </div>
			    </div>
			    <div class="form-group" size="10">
			      <label class="control-label col-sm-2" for="name">姓名</label>
			      <div class="col-sm-10">
			        <input type="text" class="form-control" size="30" id="name" value="${memberlistVO.mem_name}" name="name">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="nick">暱稱</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" size="30" id="nick" value="${memberlistVO.mem_nick}" name="nick">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="password">密碼</label>
			      <div class="col-sm-10">          
			        <input type="password" class="form-control" size="30" id="password" value="${memberlistVO.mem_pswd}" name="password">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="email">電子郵件</label>
			      <div class="col-sm-10">          
			        <input type="email" class="form-control" size="30" id="email" value="${memberlistVO.mem_email}" name="email">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="phone">電話</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" size="30" id="phone" value="${memberlistVO.mem_phone}" name="phone">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="emgc">緊急聯絡人</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" size="30" id="emgc" value="${memberlistVO.mem_emgc}" name="emgc">
			      </div>
			    </div>
			    <div class="form-group">        
			      <div class="col-sm-12">
			        <button type="submit" class="btn btn-info" name="action" value="Member_renew">修改</button>
			        <button type="submit" class="btn btn-info" name="action" value="cancel">取消</button>
			      </div>
			    </div>
		    </c:if>
		  </form>
		  </div>
		  </div>
		  </div>
	<jsp:include page="/front-end/CA105G1_footer_bt4.jsp"/>
		<!-- Popper js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/popper.min.js"></script>
		<!-- Bootstrap js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/bootstrap/bootstrap.min.js"></script>
		<!-- All Plugins js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/plugins/plugins.js"></script>
		<!-- Active js -->
		<script src="<%=request.getContextPath()%>/front-end/pro/alazea-gh-pages/js/active.js"></script>
<script>
$(function (){
	function format_float(num, pos){
        var size = Math.pow(10, pos);
        return Math.round(num * size) / size;
    }
function preview(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('.preview').attr('src', e.target.result);
           /*  var KB = format_float(e.total / 1024, 2);
            $('.size').text("檔案大小：" + KB + " KB"); */
        }
        reader.readAsDataURL(input.files[0]);
    }
}
function format_float(num, pos){
    var size = Math.pow(10, pos);
    return Math.round(num * size) / size;
}
$("body").on("change", ".upl", function (){
    preview(this);
})
})
</script>
</body>
</html>