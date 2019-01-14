package com.memberlist.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;


import com.google.gson.Gson;

@ServerEndpoint("/MemChatServer/{userName}")
public class MemberChatServer {

	public MemberChatServer() {
	}
	
	private static final Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();
	
	@OnOpen
	public void onOpen(@PathParam("userName")String userName,Session userSession) throws IOException {
		sessionsMap.put(userName, userSession);
		System.out.println(userName+" connected");
		
	}
	
	@OnMessage
	public void onMessage(Session userSession, String message) {
//		JsonObject jsonIn = gson.fromJson(message, JsonObject.class);
//		String userName = jsonIn.get("userName").getAsString();
//		String jsontostring = jsonIn.get("message").getAsString();
//		System.out.println(jsonIn.get("userName").getAsString());
//		System.out.println(jsonIn.get("message").getAsString());
		
		Collection<Session> sessions = sessionsMap.values();
		for(Session session : sessions) {
			if(session.isOpen())
				session.getAsyncRemote().sendText(message);
		}
		System.out.println("Message received: "+message);
//		if(receiverSession!=null&&receiverSession.isOpen()) {
//			if(messageType.equals("image")) {
//				int imageLength = chatMessage.getContent().getBytes().length;
//				System.out.println("image length = "+imageLength);
//				receiverSession.getAsyncRemote().sendBinary(ByteBuffer.wrap(message.getBytes()));
//			} else {
//				receiverSession.getAsyncRemote().sendText(message);
//				System.out.println("Message received:"+message);
//			}
//		}
	}
	
	@OnError
	public void onError(Session userSession, Throwable e) {
//		e.printStackTrace(System.err);
//		System.out.println("Error: "+e.toString());
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userName = null;
		Set<String> userNames = sessionsMap.keySet();
		for(String Name : userNames) {
			if(sessionsMap.get(Name).equals(userSession)) {
				userName = Name;
				System.out.println(userName+"disconnected");
				sessionsMap.remove(Name);
				break;
			}
		}
	}
	

}
