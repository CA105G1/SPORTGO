    
    var MyPoint = "/MyEchoServer";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
    var statusOutput  = document.getElementById("statusOutput");
    var statusPublish = document.getElementById("statusPublish");
	var webSocket;
//	document.write("<script type=\"text/javascript\" src=\"sweetalert2.css\"></script>");
	function connect() {
		// 建立 websocket 物件
		console.log('host:'+host);
		console.log('path:'+path);
		console.log('webCtx:'+webCtx);
		console.log('endPointURL:'+endPointURL);
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			console.log("WebSocket 成功連線");
		};

		webSocket.onmessage = function(event) {
			var obj = eval("(" + event.data + ")");
			console.log(obj)
			console.log(obj.pro_no);
			console.log(obj.pro_name);
			getReload(obj.pro_no);
//			var test = 'helloworld';
//			test.scrollTop = test.scrollHeight;
		};

		webSocket.onclose = function(event) {
			console.log("WebSocket 已離線");
		};
	}
//	function starWebsock(){
//		var pro_name = $('#productname').val();
//		var jsonObj = {"pro_name" : pro_name};
//        webSocket.send(JSON.stringify(jsonObj));//會觸發java端onMessage
//	}
	
	function disconnect () {
		webSocket.close();

	}
	function getReload(data){
		swal({
   			html: $("<div>").text('全新商品上架囉!'),
   			background : 'url(/CA105G1/back-end/pro/tool/test3.jpg)',
   			customClass: 'swal-wide',
   			showCancelButton : true,
   			confirmButtonColor : '#3085d6',
   			cancelButtonColor : '#d33',
   			confirmButtonText : 'Yes, 馬上搶購去!',
   			cancelButtonText : '等會再買!',
   			closeOnConfirm : false,
   			closeOnCancel : false
   		}).then(function() {
   			window.location.replace("/CA105G1/pro/pro.do?action=herf_Display&pro_no="+data);
   		 }, function(dismiss) {
				swal({
					  title: "您還不購買嗎",   
					  html:     '<b>千萬別錯過</b>' +'<br>前往搶購新品'+ '<br><a href="/CA105G1/pro/pro.do?action=herf_Display&pro_no='+data+'" style="color:red"">SportGO ~ EShop</a>'  ,
					  width: 300,
					  padding: 20, 
					  showConfirmButton: true,
					  confirmButtonText : 'No, 仍是等會再買!',
				});
   		    }
		)
	}
	
	
	