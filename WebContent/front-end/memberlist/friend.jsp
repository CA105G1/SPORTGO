<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.memberlist.model.*" %>
<%@ page import = "com.friend.model.*" %>
<%@ page import = "java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberlistService service = new MemberlistService();
	List<FriendVO> friendlist =(List<FriendVO>)request.getAttribute("friendlist");
	List<FriendVO> possiblefriend =(List<FriendVO>)request.getAttribute("possiblefriend");
	List<FriendVO> whoaddme =(List<FriendVO>)request.getAttribute("whoaddme");
	List<MemberlistVO> memberlist = service.getAllMem();
	if(friendlist==null)
		response.sendRedirect("Login.jsp");
	pageContext.setAttribute("friendlist",friendlist);
	pageContext.setAttribute("memberlist",memberlist);
%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		
<!-- 		<script src='//production-assets.codepen.io/assets/editor/live/console_runner-079c09a0e3b9ff743e39ee2d5637b9216b3545af0de366d4b9aad9dc87e26bfd.js'></script> -->
<!-- 	    <script src='//production-assets.codepen.io/assets/editor/live/events_runner-73716630c22bbc8cff4bd0f07b135f00a0bdc5d14629260c3ec49e5606f98fdd.js'></script> -->
<!-- 	    <script src='//production-assets.codepen.io/assets/editor/live/css_live_reload_init-2c0dc5167d60a5af3ee189d570b1835129687ea2a61bee3513dee3a50c115a77.js'></script> -->
	    <meta name="robots" content="noindex">
	    <link rel="shortcut icon" type="image/x-icon" 
	    href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
	    <link rel="mask-icon" type="" 
	    href="//production-assets.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg"/>
	    <link rel="canonical" href="https://codepen.io/tanjalehner/pen/bgzpQx?limit=all&page=91&q=contact+" />
		
		<title>SPORTGO 會員頁面</title>
		<style type="text/css">
			.container{
				width: 100%;
			}
			center{
				font-size: xx-large;
				color: red;
			}
			.grid-container{
				grid-template-columns:repeat(3,33.33%);
				grid-gap:10px;
			}
			.grid-item{
			text-align:center;
			}
			
			
			* {font-family: 'Roboto', sans-serif;margin: 0px;padding: 0px;box-sizing: border-box;}

			body {background: #dbdbdb;}

			i {width: 60px;margin: auto;}
/* ------ FONTS ------ */
			.font-name {color: #000000;font-size: 1em;font-weight: inherit;padding-bottom: 3px;}

			.font-preview {color: #444444;font-size: 0.9em;font-weight: inherit;}

			.font-online {color: #777777;font-size: 0.8em;font-weight: inherit;}

			.green-background {background: #009688;height: 130px;width: 100%;position: fixed;top: 0;z-index: -100;}

			.wrap {display: flex;height: 100vh;min-width: 600px;max-width: 1200px;margin: auto;box-shadow: 0 2px 2px #aaaaaa;}
/* ------ LEFT SIDE ------ */
			.left {max-width: 300px;width:100%;}

			.profile {width: 100%;height: auto;background: #eeeeee;border-right: 1px solid #dbdbdb;display: flex;justify-content: space-between;}

			.profile img {width: 40px;height: 40px;margin: 10px;border-radius: 50%;}

			.icons {color: #777777;display: flex;}

			.wrap-search {width: 100%;height: 45px;background: #fbfbfb;display: flex;}

			.search { width: calc(100% - 20px);height: 30px;background: #ffffff;margin: auto;border: 1px solid #eeeeee;border-radius: 5px;display: flex;}

			.search i {widht: 60px;}

			.search i, .wrap-message i {color: #aaaaaa;text-align: center;}

			.input-search {width: 100%;border: none;}

			.input-search:focus {outline: none;}

			.contact-list {background-color: #ffffff;width: 100%;height: calc(100% - 105px);overflow-y: auto;}

			.contact, .active-contact, .new-message-contact {height: 70px;background-color: #ffffff;display: flex;}

			.contact img, .active-contact img, .new-message-contact img {width: 50px;height: 50px;margin: 10px;border-radius: 50%;}

			.active-contact {background-color: #ebebeb;}

			.contact:hover, .new-message-contact:hover {background-color: #f5f5f5;}

			.new-message-contact {font-weight: bold;}	

			.contact-preview {width: 100%;height: 70px;border-bottom: 1px solid #eeeeee;display: flex;overflow: hidden;}

			.contact-text {height: 40px;margin: auto 0;overflow: hidden;}

			.contact-time {width: 55px;color: rgba(0,0,0,0.4);font-size: 0.8em;display: flex;
			flex-direction: column;justify-content: space-between;padding: 10px;border-bottom: 1px solid #eeeeee;}

			.new-message {background: #09d261;border-radius: 50%;width: 20px;height: 20px;display: flex;
			margin: auto;flex-direction: column;color: white;}

			.new-message p {margin: auto;}

/* ------ RIGHT SIDE ------ */
			.right {width:100%;}

			.chat-head {background-color: #eeeeee;width: 100%;height: 60px;display: flex;}

			.chat-head img {width: 40px;height: 40px;margin: 10px;border-radius: 50%;}

			.chat-head i {color: #aaaaaa;width: 60px;margin: auto;text-align: center;}

			#close-contact-information {display: none;}

			.chat-name {width: 100%;margin: auto;}

			.wrap-chat {height: calc(100% - 120px);display: flex;}

			.chat {background-color: #e5ddd5;background-image: url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/1089577/background.png);
    		width: 100%;padding: 0px 10%;padding-top: 7px;overflow-y: auto;}

			.information {width: 100%;position: relative;background: #f7f7f7;display: none;flex-direction: column;overflow: auto;}

			.information div {background: #ffffff;padding: 10px;margin-bottom: 20px;}

			.information img {width: 200px;height: 200px;	margin: 20px auto;border-radius: 50%;float: left;}

			.information h1 {color: #009688;font-size: 14px;margin-bottom: 5px;}

			.listGroups {display: flex;margin: 0px !important;}

			.listGroups img {width: 40px;height: 40px;margin: 0px 10px 0px 0px;}

			.listGroups p {margin: auto 0px;}

/* ------ CHAT ------ */
			.chat-bubble {border-radius: 7px;box-shadow: 0 2px 2px rgba(0,0,0,0.05);padding: 5px 7px;width: 350px;max-width: 100%;position: relative;}

			.you {background: #ffffff;margin: 0px auto 10px 0px;}

			.me {background: #dcf8c6;margin: 0px 0px 10px auto;}

			.your-mouth {width: 0;height: 0;border-bottom: 10px solid white;border-left: 10px solid transparent;
    		position: absolute;bottom: 10px;left: -10px;}

			.my-mouth {width: 0;height: 0;border-bottom: 10px solid #dcf8c6;border-right: 10px solid transparent;
			position: absolute;bottom: 10px;left: 100%;}

			.content {margin: 0.5em 0;line-height: 120%;font-size: 0.9em;}

			.content img {width: 100%;}

			.time {color: rgba(0,0,0,0.4);font-size: 0.6em;text-align: right;margin-top: -10px;}

			.pink {color: #EE33AA;}

			.green {color: #44FF66;}

			.orange {color: #FF8811;}

			.wrap-message {width: 100%;height: 60px;background: #f1f1f1;display: flex;}

			.message {width: 100%;height: 45px;background: #ffffff;margin: auto;border: 1px solid #eeeeee;border-radius: 5px;display: flex;}

			.input-message {width: 100%;margin: 0px 10px;border: none;}

			.input-message:focus {outline: none;}

/* ------ SCROLLBAR ------ */

body::-webkit-scrollbar, .contact-list::-webkit-scrollbar, .chat::-webkit-scrollbar, .information::-webkit-scrollbar {
    width: 0.4em;
    height: 0.4em;
}

body::-webkit-scrollbar-thumb, .contact-list::-webkit-scrollbar-thumb, .chat::-webkit-scrollbar-thumb, .information::-webkit-scrollbar-thumb {
    background-color: rgba(0,0,0,0.2);
}

/* ------ MEDIA QUERIES ------ */
@media (min-width: 1200px) {
    .wrap {
        margin-bottom: 2vh;
        margin-top: 25px;
        height: calc(98vh - 25px);
    }
}

@media (max-width: 600px) {
    .wrap {
        height: calc(100vh - 0.4em);
    }
}
	</style>
	<link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet">
	<script src="https://use.fontawesome.com/1c6f725ec5.js"></script>
	</head>
	<body>
		<jsp:include page="/front-end/SportyGo_Header.html"/>
		
		<!-- 右選單 -->
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<jsp:include page="list_group.jsp"/>
				</div>
<!-- 				聊天區 -->
				<div class="col-xs-12 col-sm-6">
					<div class="row wrap">
<!-- 						左邊好友欄 -->
						<section class="left">
							<div class="profile">
								<img src="<%=request.getContextPath()%>
											/front-end/memberlist/showPicture.do?mem_no=${memberlistVO.mem_no}">
								<h1 id="userName" style="max-width:100%;max-height:100%">${memberlistVO.mem_name}</h1>
								<div class="icons">
									<i class="fa fa-commenting fa-lg" aria-hidden="true"></i>
									<i class="fa fa-bars fa-lg" aria-hidden="true"></i>
								</div>
							</div>
							<div class="wrap-search">
								<div class="search">
									<i class="fa fa-search fa" aria-hidden="true"></i>
									<input type="text" class="input-search" placeholder="搜尋好友">
								</div>
							</div>
<!-- 							好友的地方 -->
						<div class="contact-list"></div>
				</section>

				<section class="right">
						<div class="chat-head">
								<img src="">
								<div class="chat-name">
										<h1 class="font-name">${memberlistVO.mem_name}</h1>
										<p class="font-online"></p>
								</div>
<!-- 						聊天室上方的放大鏡..等 -->
								<i class="fa fa-search fa-lg" aria-hidden="true"></i>
								<i class="fa fa-paperclip fa-lg" aria-hidden="true"></i>
								<i class="fa fa-bars fa-lg" aria-hidden="true" id="show-contact-information"></i>
								<i class="fa fa-times fa-lg" aria-hidden="true" id="close-contact-information"></i>
						</div>
<!-- 						聊天室中間 -->
						<div class="wrap-chat" id="messageArea">
								<div class="chat" id="chat"></div>
								<div class="information"></div>
						</div>
<!-- 					    聊天室下方輸入聊天訊息的區塊 -->
						<div class="wrap-message">
								<i class="fa fa-smile-o fa-lg" aria-hidden="true"></i>
								<div class="message">
									<input type="text" class="input-message" id="input-message" placeholder="請輸入聊天訊息"
									onkeydown="if(event.keyCode== 13)sendMessage();">
								</div>
								<i class="fa fa-microphone fa-lg" aria-hidden="true"></i>
						</div>
				</section>
				</div>
				</div>
				<div class="col-xs-12 col-sm-3">
				<!-- 好友管理 -->
				<h1>我的捧油</h1><br>
				<div class="grid-container" style="display:grid;">
					<c:forEach var="friend" items="${friendlist}">
						<c:forEach var="member" items="${memberlist}">
							<c:if test="${memberlistVO.mem_no eq friend.mem1_no}">
								<c:if test="${friend.mem2_no eq member.mem_no}" >
									<form method="post" action="Friend.do"  class="grid-item">
										<a href="public_Member_page.jsp?mem_no=${member.mem_no}">
											<img src="<%=request.getContextPath()%>
											/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"
											style="width:80px;height:80px;border-radius:50%;"><br>
											<label>${member.mem_name}</label><br>
											<input type="hidden" name="action" value="delete_Friend">
											<input type="hidden" name="mem2_no" value="${member.mem_no}">
											<button type="submit" class="btn btn-danger">超堵爛你</button>
										</a>
									</form>
								</c:if>
							</c:if>
							<c:if test="${memberlistVO.mem_no eq friend.mem2_no}">
								<c:if test="${friend.mem1_no eq member.mem_no}" >
									<form method="post" action="Friend.do"  class="grid-item">
										<a href="public_Member_page.jsp?mem_no=${member.mem_no}">
											<img src="<%=request.getContextPath()%>
											/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"
											style="width:80px;height:80px;border-radius:50%"><br>
											<label>${member.mem_name}</label><br>
											<input type="hidden" name="action" value="delete_Friend">
											<input type="hidden" name="mem2_no" value="${member.mem_no}">
											<button type="submit" class="btn btn-danger">超堵爛你</button>
										</a>
									</form>
								</c:if>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>
				<h1>捧油拜託加加</h1><br>
				<div class="grid-container" style="display:grid;">
					<c:forEach var="friend" items="${possiblefriend}">
						<c:forEach var="member" items="${memberlist}">
							<c:if test="${memberlistVO.mem_no eq friend.mem1_no}">
								<c:if test="${friend.mem2_no eq member.mem_no}" >
									<form method="post" action="Friend.do"  class="grid-item">
										<a href="public_Member_page.jsp?mem_no=${member.mem_no}">
											<img src="<%=request.getContextPath()%>
											/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"
											style="width:80px;height:80px;border-radius:50%;"><br>
											<label>${member.mem_name}</label><br>
											<input type="hidden" name="action" value="delete_Friend">
											<input type="hidden" name="mem2_no" value="${member.mem_no}">
											<button type="submit" class="btn btn-danger">超堵爛你</button>
										</a>
									</form>
								</c:if>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>
				<h1>哪些捧油誰想加我呀</h1><br>
				<div class="grid-container" style="display:grid;">
					<c:forEach var="friend" items="${whoaddme}">
						<c:forEach var="member" items="${memberlist}">
							<c:if test="${memberlistVO.mem_no eq friend.mem2_no}">
								<c:if test="${friend.mem1_no eq member.mem_no}" >
									<form method="post" action="Friend.do"  class="grid-item">
										<a href="public_Member_page.jsp?mem_no=${member.mem_no}">
											<img src="<%=request.getContextPath()%>
											/front-end/memberlist/showPicture.do?mem_no=${member.mem_no}"
											style="width:80px;height:80px;border-radius:50%;"><br>
											<label>${member.mem_name}</label><br>
											<input type="hidden" name="action" value="update_Friend">
											<input type="hidden" name="mem2_no" value="${member.mem_no}">
											<button type="submit" class="btn btn-info">來～加加</button>
										</a>
									</form>
								</c:if>
							</c:if>
						</c:forEach>
					</c:forEach>
				</div>
			</div>	
		</div>
		
		
	<script src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script><script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js'></script>
		
	</div>
	<jsp:include page="/front-end/SportyGo_Footer.html"/>
	<script>
		var userName = '${memberlistVO.mem_name}';
		var MemPoint = '/MemChatServer'+'/'+userName;
		var host = window.location.host;
		var endPointURL = 'ws://'+host+'/CA105G1'+MemPoint;
		console.log(userName);
		
		var webSocket;
		
		$(function(){
			connect();
		})
		
		function connect(){
			webSocket = new WebSocket(endPointURL);
			
			webSocket.onopen =function(event){
				console.log("WebSocket connected successful");
				
			};
			
			webSocket.onmessage = function(event){
				var messageArea = document.getElementById("chat");
				var jsonObj = JSON.parse(event.data);
				var message = jsonObj.userName + ": "+jsonObj.message+ "\r\n";
				if(jsonObj.userName===userName){
					$("#chat").append("<div style='text-align:right;'>" + message+ "</div>");
				}else{
					$("#chat").append("<div>" + message+ "</div>");
				}
				messageArea.value = messageArea.value + message;
				messageArea.scrollTop = messageArea.scrollHeight;
			};
			
			webSocket.onclose = function(event){
				console.log("WebSocket disconnected");
			};
		}
	
		function sendMessage(){
			var inputMessage = document.getElementById("input-message");
			var message = inputMessage.value;
			var jsonObj = {
					"userName" :userName,
					"message" :message
			};
			webSocket.send(JSON.stringify(jsonObj));
			inputMessage.value = "";
			inputMessage.focus();
		}
		
	</script>
	</body>
</html>