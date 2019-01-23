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

import com.friend.model.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.memberlist.model.*;

@ServerEndpoint("/MemChatServer/{userName}")
public class MemberChatServer {

	public MemberChatServer() {
	}
	
	private static final Map<String, Session> sessionsMap = new ConcurrentHashMap<>();
	Gson gson = new Gson();
	
	@OnOpen
	public void onOpen(@PathParam("userName")String userName,Session userSession) throws IOException, JSONException {
		sessionsMap.put(userName, userSession);
		System.out.println(userName+" connected");
		//上線時抓歷史訊息
		MemberlistRedisDAO dao = new MemberlistRedisDAO();
		try {
			List<String> historydata = null;
			if(dao.isOpen())
				historydata = dao.getHistoryMsg(userName);
			Session session = sessionsMap.get(userName);
			if(session.isOpen()) {
				for(String data : historydata) {
					session.getBasicRemote().sendText(data);
//					System.out.println("historymessage rebuild");
				}
			}
			//
			FriendService friendSvc = new FriendService();
			List<FriendVO> friendlist = friendSvc.findMyFriend(userName);
			Set<String> names =sessionsMap.keySet();
			for(FriendVO list : friendlist) {
				for(String name : names ) {
					if(name.equals(list.getMem1_no())) {
						String online = "{\"type\":\"online\",\"userName\":\""+name+"\"}";
						Session sess = sessionsMap.get(list.getMem2_no());
						if(sess!=null) {
							if(sess.isOpen())
								sess.getBasicRemote().sendText(online);
						}
					}else if(name.equals(list.getMem2_no())) {
						String online = "{\"type\":\"online\",\"userName\":\""+name+"\"}";
						Session sess = sessionsMap.get(list.getMem1_no());
						if(sess!=null) {
							if(sess.isOpen())
								sess.getBasicRemote().sendText(online);
						}
					}
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
			if(dao.isOpen())
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
		try {
			if(session1!=null) {
				if(session1.isOpen())
					session1.getBasicRemote().sendText(message);
			}
			if(session2!=null) {
				if(session2.isOpen())
					session2.getBasicRemote().sendText(message);
			}
			System.out.println("Message received: "+message);
		}catch(Exception e) {
			e.printStackTrace(System.err);
		}
//		Collection<Session> sessions = sessionsMap.values();
//		for(Session session : sessions) {
//			if(session.isOpen())
//				session.getAsyncRemote().sendText(message);
//		}
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
		FriendService friendSvc = new FriendService();
		String userName = null;
		try {
			Set<String> names =sessionsMap.keySet();
			for(String Name : names) {
				if(sessionsMap.get(Name).equals(userSession)) {
					userName = Name;
					break;
				}
			}
			List<FriendVO> friendlist = friendSvc.findMyFriend(userName);
			for(FriendVO list : friendlist) {
				for(String name : names ) {
					if(name.equals(list.getMem1_no())) {
						String offline = "{\"type\":\"offline\",\"userName\":\""+name+"\"}";
						Session sess = sessionsMap.get(list.getMem2_no());
						if(sess!=null) {
							if(sess.isOpen())
								sess.getBasicRemote().sendText(offline);
						}
					}else if(name.equals(list.getMem2_no())) {
						String offline = "{\"type\":\"offline\",\"userName\":\""+name+"\"}";
						Session sess = sessionsMap.get(list.getMem1_no());
						if(sess!=null) {
							if(sess.isOpen())
								sess.getBasicRemote().sendText(offline);
						}
					}
				} 
			}
			sessionsMap.remove(userName);
		}catch (Exception e) {
				e.printStackTrace(System.err);
			}
		System.out.println(userName+"disconnected");
	}
	

}
