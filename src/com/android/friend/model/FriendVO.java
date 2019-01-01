package com.android.friend.model;

public class FriendVO implements java.io.Serializable{

	private static final long serialVersionUID = 86L;
	public FriendVO() {
	}
	
	private String mem1_no;//apply for becoming friend
	private String mem2_no;//who be invited for becoming friend
	private String relationship;
	private String friend_status;
	private String mem_chat;
	public String getMem1_no() {
		return mem1_no;
	}
	public void setMem1_no(String mem1_no) {
		this.mem1_no = mem1_no;
	}
	public String getMem2_no() {
		return mem2_no;
	}
	public void setMem2_no(String mem2_no) {
		this.mem2_no = mem2_no;
	}
	public String getRelationship() {
		return relationship;
	}
	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}
	public String getFriend_status() {
		return friend_status;
	}
	public void setFriend_status(String friend_status) {
		this.friend_status = friend_status;
	}
	public String getMem_chat() {
		return mem_chat;
	}
	public void setMem_chat(String mem_chat) {
		this.mem_chat = mem_chat;
	}
}
