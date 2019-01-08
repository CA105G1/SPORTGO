package com.pro.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.product.model.ProductService;
import com.product.model.ProductVO;

@ServerEndpoint("/MyEchoServer")
public class MyEchoServer {
	
	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen            //路徑的參數收到植存到旁邊的name
	public void onOpen(Session userSession) throws IOException {
		allSessions.add(userSession);
		System.out.println(userSession.getId() + ": 已連線");

//		userSession.getBasicRemote().sendText("WebSocket 連線成功");
	}
	
	@OnMessage                   
	public void onMessage(Session userSession, String message) {
		StringBuffer sbuf =new StringBuffer();
		sbuf.append(message);
		sbuf.deleteCharAt(sbuf.length()-1);
		
		ProductService proSvc = new ProductService();
		ProductVO proVO = proSvc.getLastProduct();
		sbuf.append(",\"pro_no\":\""+proVO.getPro_no()+"\"}");
		
		for (Session session : allSessions) {
			if (session.isOpen())
				      //用非同步
				session.getAsyncRemote().sendText(sbuf.toString());//傳播給大家
			          //也可以用getBasicRemote()
		}
		System.out.println("Message received: " + message);
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		allSessions.remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}

}
