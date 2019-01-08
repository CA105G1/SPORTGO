<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- sweetalert-link -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<title>Insert title here</title>
</head>
<body >
<h1>
<center>
<textarea id="messagesArea" class="panel message-area" readonly ></textarea>
<button onclick="getReload()">tuch</button>

</center>
</h1>


<%--        <script src="<%=request.getContextPath() %>/back-end/pro/tool/websock_client.js"></script> --%>

       <script type="text/javascript">
       
           
               
          
       
       function getReload(){
//     	   swal({
//     		   title: '确定删除吗？', 
//     		   text: '你将无法恢复它！', 
//     		   type: 'warning',
//     		   showCancelButton: true, 
//     		   confirmButtonColor: '#3085d6',
//     		   cancelButtonColor: '#d33',
//     		   confirmButtonText: '确定删除！', 
//     		   cancelButtonText: '取消删除！',
//     		   confirmButtonClass: 'btn btn-success',
//     		   cancelButtonClass: 'btn btn-danger',
//     		   buttonsStyling: false
//     		 }).then(function() {
//     		   swal(
//     		     '已删除！',
//     		     '你的文件已经被删除。',
//     		     'success'
//     		   ); 
//     		 }, function(dismiss) {
//     		   // dismiss的值可以是'cancel', 'overlay',
//     		   // 'close', 'timer'
//     		   if (dismiss === 'cancel') {
//     		     swal(
//     		       '已取消！',
//     		       '你的虚拟文件是安全的:)',
//     		       'error'
//     		     ); 
//     		   } 
//     		 })
	   		swal({
	   			html: $("<div>")         .text('請注意，有新品，上市囉!'),
	//    			imageUrl: 'C:\Users\Java\Desktop\DBGifReader.gif',
	//    			background: 'url(/TibameF3_MVC_ShoppingCart_WebSocket/images/symphony.png)',
	   			showCancelButton : true,
	   			confirmButtonColor : '#3085d6',
	   			cancelButtonColor : '#d33',
	   			confirmButtonText : 'Yes, 馬上搶購去!',
	   			cancelButtonText : 'No, 等會再買!',
	//    			confirmButtonClass : 'confirm-class',
	//    			cancelButtonClass : 'cancel-class',
	   			closeOnConfirm : false,
	   			closeOnCancel : false
	   		}).then(function() {
	   				window.location.replace("<%= request.getContextPath()%>/front-end/pro/listAllPro_front.jsp");
	   		 }, function(dismiss) {
						swal({
							  title: "~錯過可惜~",   
	// 						  imageUrl: "C:\Users\Java\Desktop\DBGifReader.gif",
	// 						  background: 'url(/TibameF3_MVC_ShoppingCart_WebSocket/images/symphony.png)',
							  html:     '<b>如果後悔，按以下連結</b>' + '<br><a >電 子 商 店 EShop</a>' + '<br>仍可搶購新品~',
							  width: 300,
							  padding: 20, 
							  showConfirmButton: true,
							  confirmButtonText : 'No, 仍是等會再買!',
							 });
					}
				
	   		)
   		
       }
       </script>
</body>
</html>