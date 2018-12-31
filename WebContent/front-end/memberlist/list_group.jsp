<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<title>SPORTGO 會員頁面</title>
		<style type="text/css">
			.container{
				width: 100%;
			}
			.list-group-item{
				text-align: center;
				font-size: large;
				height: 80px;
				display: flex;
				justify-content: center;
				justify-items:center;
				align-items:center;
			}
			center{
				font-size: xx-large;
				color: red;
			}
		</style>
	</head>
	<body>
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<div class="list-group" id="myTab">
					<a href="Member_page.jsp" class="list-group-item">個人頁面</a>
					<a href="calendar.jsp" class="list-group-item">行事曆</a>
					<a href="Member_renew.jsp" class="list-group-item">個人頁面管理</a>
					<a href="sg.jsp" class="list-group-item">個人揪團管理</a>
					<a href="club.jsp" class="list-group-item">個人社團管理</a>
					<a href="friend.jsp" class="list-group-item">好友管理</a>
					<a href="order.jsp" class="list-group-item">訂單管理</a>
					<a href="prolike.jsp" class="list-group-item">最愛的商品</a>
				</div>
			</div>
		</div>
	<script>
	var action = "${action}";
	$(function(){
	    $(document).on('shown.bs.tab', 'a[data-toggle="tab"]', function (e) {
	        localStorage.setItem('activeTab', $(e.target).attr('href'));
	    })

	    var hash = window.location.hash;
	    var activeTab = localStorage.getItem('activeTab');

	    if(hash){
	          $('#project-tabs  a[href="' + hash + '"]').tab('show');   
	    }else if (activeTab){
	        $('#project-tabs a[href="' + activeTab + '"]').tab('show');
	    }
	    
	    changePage();
	});
	function changePage(){
		console.log(action);
		if(action === 'Member_renew'){
			$('#myTab').find('a[href="#renew"]').trigger('click');
		} else if(action === ''){
			
		} else {
			$('#myTab').find('a[href="#mem"]').trigger('click');
		}
	}
	</script>
	</body>
</html>