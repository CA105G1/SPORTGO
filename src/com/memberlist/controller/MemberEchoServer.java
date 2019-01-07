package com.memberlist.controller;

import java.io.IOException;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/MemEchoServer")
public class MemberEchoServer {

	public MemberEchoServer() {
	}
	
//	private static final Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Session session = null;
	@OnOpen
	public void onOpen(Session userSession) throws IOException {
//		sessionsMap.put(userName, userSession);
//		System.out.println(userName+" connected");
		session = userSession;
		userSession.getBasicRemote().sendText("Hello ni hao from WebSocket");
		System.out.println("WebSocket push succeed.");
		
	}
	
	@OnMessage
	public void onMessage(Session userSession, String message) {
//		if(userSession.isOpen()) {
//			userSession.getAsyncRemote().sendText(message+"Hello from WebSocket");
//		}
//		System.out.println("WebSocket push succeed.");
		
	}
	
	@OnError
	public void onError(Session userSession, Throwable e) {
		e.printStackTrace(System.err);
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		session = null;
		System.out.println(userSession.getId()+" Disconnected :"+ Integer.toString(reason.getCloseCode().getCode()));
	}
	

}
