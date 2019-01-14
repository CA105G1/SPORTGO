package com.memberlist.controller;

import java.io.IOException;
import java.util.List;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import com.memberlist.model.MemberlistRedisDAO;

@ServerEndpoint("/MemEchoServer/{mem_no}")
public class MemberEchoServer {

	public MemberEchoServer() {
	}
	
	Session session = null;
	@OnOpen
	public void onOpen(@PathParam("mem_no") String mem_no, Session userSession) throws IOException {
		session = userSession;
		System.out.println(mem_no+" connected");
		MemberlistRedisDAO dao = new MemberlistRedisDAO();
		List<String> notation = dao.getNotationMsg(mem_no);
		if(notation!=null) {
			for(String list : notation) {
				System.out.println(list.toString());
				userSession.getBasicRemote().sendText(list.toString());
			}
		}
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
//		e.printStackTrace(System.err);
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		session = null;
		System.out.println(userSession.getId()+" Disconnected :"+ Integer.toString(reason.getCloseCode().getCode()));
	}
	

}
