package com.memberlist.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.List;
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

import org.json.JSONException;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.memberlist.model.MemberlistRedisDAO;

@ServerEndpoint("/MemChatServer/{userName}")
public class MemberChatServer {

	public MemberChatServer() {
	}
	
	private static final Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();
	
	@OnOpen
	public void onOpen(@PathParam("userName")String userName,Session userSession) throws IOException, JSONException {
		sessionsMap.put(userName, userSession);
//		上線通知 尚未完成
//		JSONObject json = new JSONObject();
//		json.append("userName", userName);
//		json.append("message", "上線嘍～～～");
//		Collection<Session> sessions = sessionsMap.values();
//		for(Session session : sessions) {
//			if(session.isOpen())
//				session.getAsyncRemote().sendObject(json);
//		}
		System.out.println(userName+" connected");
		//上線時抓歷史訊息
		MemberlistRedisDAO dao = new MemberlistRedisDAO();
		try {
			List<String> historydata = dao.getHistoryMsg(userName);
			Session session = sessionsMap.get(userName);
			if(session.isOpen()) {
				for(String data : historydata) {
					session.getBasicRemote().sendText(data);
//					System.out.println("historymessage rebuild");
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
	}
	
	@OnMessage
	public void onMessage(Session userSession, String message) {
		JsonObject jsonIn = gson.fromJson(message, JsonObject.class);
		String userName = jsonIn.get("userName").getAsString();
		String chatFriend = jsonIn.get("to").getAsString();
		//存進Redis
		MemberlistRedisDAO dao = new MemberlistRedisDAO();
		try {
			dao.saveChatMessage(userName, chatFriend, message);
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("Redis save error");
		}
		Collection<String> Name = sessionsMap.keySet();
		Session session1 = null;
		Session session2 = null;
		for(String name : Name) {
			if(name.equals(userName)) 
				session1 = sessionsMap.get(name);
			if(name.equals(chatFriend))
				session2 = sessionsMap.get(name);
		}
		if(session1!=null) {
			if(session1.isOpen())
				session1.getAsyncRemote().sendText(message);
		}
		if(session2!=null) {
			if(session2.isOpen())
				session2.getAsyncRemote().sendText(message);
		}
//		Collection<Session> sessions = sessionsMap.values();
//		for(Session session : sessions) {
//			if(session.isOpen())
//				session.getAsyncRemote().sendText(message);
//		}
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
		e.printStackTrace(System.err);
		System.out.println("Error: "+e.toString());
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
