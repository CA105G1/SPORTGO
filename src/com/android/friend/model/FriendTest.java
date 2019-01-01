package com.android.friend.model;

public class FriendTest {

	public FriendTest() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		FriendJDBCDAO jdbc = new FriendJDBCDAO();
		jdbc.updateStatus("M001","M003","好友");
		System.out.println("update completed.");
	
	
	}

}
