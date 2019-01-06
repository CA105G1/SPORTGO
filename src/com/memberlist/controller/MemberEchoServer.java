package com.memberlist.controller;

import java.util.*;
import java.util.Set;

import javax.websocket.Session;

public class MemberEchoServer {

	public MemberEchoServer() {
	}
	
	private static final Set<Session> allSessions = Collections.synchronizedSet(new HashSet<Session>());
}
