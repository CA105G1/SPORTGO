package com.android.sg_info.controller;

import java.io.IOException;
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


@ServerEndpoint("/QR_webSocket/{mem_no}")
public class QR_webSocket {
	
	private static final Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	
	Session session = null;
	
	@OnOpen
	public void onOpen(@PathParam("mem_no") String mem_no, Session userSession) throws IOException {
		System.out.println(mem_no + " is in");
		sessionsMap.put(mem_no, userSession);
	}
	
	@OnMessage
	public void onMessage(Session userSession, String message) {
		System.out.println(message);
		sessionsMap.get(message).getAsyncRemote().sendText("success");
	}
	
	@OnError
	public void onError(Session userSession, Throwable e) {
		e.printStackTrace(System.err);
	}
	
	@OnClose
	public void onClose(Session userSession, CloseReason reason) {
		String userNameClose = null;
		Set<String> userNames = sessionsMap.keySet();
		for (String userName : userNames) {
			if (sessionsMap.get(userName).equals(userSession)) {
				userNameClose = userName;
				sessionsMap.remove(userName);
				break;
			}
		}
		System.out.println(userNameClose + " is out");
	}
}
