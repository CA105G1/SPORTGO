package com.friend.model;

public class FriendTest {

	public FriendTest() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		FriendDAO jdbc = new FriendDAO();
		jdbc.updateStatus("M001","M003","好友");
		System.out.println("update completed.");
	
	
	}

}
