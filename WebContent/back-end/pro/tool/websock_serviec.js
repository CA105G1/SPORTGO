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
			getReload(obj.pro_name);
			
//			var test = 'helloworld';
//			test.scrollTop = test.scrollHeight;
		};

		webSocket.onclose = function(event) {
			console.log("WebSocket 已離線");
		};
	}
	function starWebsock(){
		var pro_name = $('#productname').val();
		var jsonObj = {"pro_name" : pro_name};
        webSocket.send(JSON.stringify(jsonObj));//會觸發java端onMessage
	}
	
	function disconnect () {
		webSocket.close();

	}
	function getReload(data){
		swal({
			title:"成功上架搂!",
			html:$("<div>").html('商品:'+ data+"<br>"+'已成功上架'), 
			type:"success"
		}).then(
			function (result) {
                if (result) {
                	document.getElementById('formSubmit').submit();
                }
			}
		);
	}
	
	