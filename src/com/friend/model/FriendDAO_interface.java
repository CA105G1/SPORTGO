package com.friend.model;

import java.util.*;

public interface FriendDAO_interface {
		
	public void insert(String mem1_no, String mem2_no);
	public void delete(String mem1_no, String mem2_no);
	public List<FriendVO> findMyFriend(String mem_no);
	public List<FriendVO> findMyPossibleFriend(String mem_no);
	public List<FriendVO> findWhoAddMe(String mem_no);
	public List<FriendVO> findAll();
	public void updateStatus(String mem1_no, String mem2_no,String status);
	public void updateRelationship(String mem1_no, String mem2_no,String relationship);
	
}
