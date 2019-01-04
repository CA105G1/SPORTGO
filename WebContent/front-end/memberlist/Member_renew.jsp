<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>修改個人資訊</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style type="text/css">
  	img{
  		max-width:300px;
  		max-higth:300px;
  	}
  	.error{
  		color:red;
  	}
  </style>
</head>
<body>
	<jsp:include page="/front-end/SportyGo_Header.html"/>
	<div class="container-fluid">
		<div class="col-xs-12 col-sm-3">
			<jsp:include page="list_group.jsp"/>
		</div>
		<div class="col-xs-12 col-sm-9">
		  <h2>修改個人資訊</h2>
		  <h1>更換大頭貼</h1>
		  <form method="post" class="form-horizontal" enctype="multipart/form-data" action="MemManager.do">
		  		<input type="file" name="picture" class="upl">
		  <div>
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
			      <label class="control-label col-sm-2" for="name">姓名</label>
			      <div class="col-sm-10">
			        <input type="text" class="form-control" id="name" value="${mem_name}" name="name">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="nick">暱稱</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" id="nick" value="${mem_nick}" name="nick">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="password">密碼</label>
			      <div class="col-sm-10">          
			        <input type="password" class="form-control" id="password" value="${mem_pswd}" name="password">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="email">電子郵件</label>
			      <div class="col-sm-10">          
			        <input type="email" class="form-control" id="email" value="${mem_email}" name="email">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="phone">電話</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" id="phone" value="${mem_phone}" name="phone">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="emgc">緊急聯絡人</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" id="emgc" value="${mem_emgc}" name="emgc">
			      </div>
			    </div>
			    <div class="form-group">        
			      <div class="col-sm-offset-2 col-sm-10">
			        <button type="submit" class="btn btn-info" name="action" value="Member_renew">修改</button>
			        <button type="submit" class="btn btn-info" name="action" value="cancel">取消</button>
			      </div>
		    	</div>
			</c:if>
<!-- 			剛進入的畫面 帶入原本的值 -->
			<c:if test="${empty errorMsgs}">
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="name">姓名</label>
			      <div class="col-sm-10">
			        <input type="text" class="form-control" id="name" value="${memberlistVO.mem_name}" name="name">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="nick">暱稱</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" id="nick" value="${memberlistVO.mem_nick}" name="nick">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="password">密碼</label>
			      <div class="col-sm-10">          
			        <input type="password" class="form-control" id="password" value="${memberlistVO.mem_pswd}" name="password">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="email">電子郵件</label>
			      <div class="col-sm-10">          
			        <input type="email" class="form-control" id="email" value="${memberlistVO.mem_email}" name="email">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="phone">電話</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" id="phone" value="${memberlistVO.mem_phone}" name="phone">
			      </div>
			    </div>
			    <div class="form-group">
			      <label class="control-label col-sm-2" for="emgc">緊急聯絡人</label>
			      <div class="col-sm-10">          
			        <input type="text" class="form-control" id="emgc" value="${memberlistVO.mem_emgc}" name="emgc">
			      </div>
			    </div>
			    <div class="form-group">        
			      <div class="col-sm-offset-2 col-sm-10">
			        <button type="submit" class="btn btn-info" name="action" value="Member_renew">修改</button>
			        <button type="submit" class="btn btn-info" name="action" value="cancel">取消</button>
			      </div>
			    </div>
		    </c:if>
		  </form>
		</div>
	</div>
	<jsp:include page="/front-end/SportyGo_Footer.html"/>
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