    
    var MyPoint = "/MyEchoServer";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
    var statusOutput  = document.getElementById("statusOutput");
    var statusPublish = document.getElementById("statusPublish");
	var webSocket;
	
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
			getReload(obj.pro_name);
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
   			html: $("<div>")         .text('請注意，有新品，上市囉!'),
   			showCancelButton : true,
   			confirmButtonColor : '#3085d6',
   			cancelButtonColor : '#d33',
   			confirmButtonText : 'Yes, 馬上搶購去!',
   			cancelButtonText : 'No, 等會再買!',
   			closeOnConfirm : false,
   			closeOnCancel : false
   		}).then(function() {
   			swal(
	   		     '已删除！',
	   		     '你的文件已经被删除。',
	   		     'success'
   		    ); 
   		 }, function(dismiss) {
				swal({
					  title: "~錯過可惜~",   
					  html:     '<b>如果後悔，按以下連結</b>' + '<br><a >電 子 商 店 EShop</a>' + '<br>仍可搶購新品~',
					  width: 300,
					  padding: 20, 
					  showConfirmButton: true,
					  confirmButtonText : 'No, 仍是等會再買!',
				});
   		    }
		)
	}
	
	
	