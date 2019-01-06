package com.memberlist.controller;

import java.util.*;
import java.util.Set;

import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;

public class MemberEchoServer {

	public MemberEchoServer() {
	}
	
	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
	
	@OnOpen
	public void onOpen() {
		
	}
	
	@OnMessage
	public void onMessage() {
		
	}
	
	@OnError
	public void onError() {
		
	}
	

}
