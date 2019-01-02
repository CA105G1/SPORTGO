package com.friend.model;

import java.util.List;

public class FriendService {

	private FriendDAO_interface dao;
	public FriendService() {
		dao = new FriendDAO();
	}
	
	public FriendVO addFriend(String mem1_no,String mem2_no) {
		FriendVO friendVO = new FriendVO();
		friendVO.setMem1_no(mem1_no);
		friendVO.setMem2_no(mem2_no);
		dao.insert(mem1_no, mem2_no);
		return friendVO;
	}
	
	public void deleteFriend(String mem1_no,String mem2_no) {
		dao.delete(mem1_no, mem2_no);
	}
	
	public List<FriendVO> findMyFriend(String mem_no){
		return dao.findMyFriend(mem_no);
	}
	
	public FriendVO changeStatus(String mem1_no,String mem2_no,String status) {
		FriendVO friendVO = new FriendVO();
		friendVO.setMem1_no(mem1_no);
		friendVO.setMem2_no(mem2_no);
		friendVO.setFriend_status(status);
		dao.updateStatus(mem1_no, mem2_no, status);
		return friendVO;
	}
	
	public FriendVO changeReletionship(String mem1_no,String mem2_no,String relationship) {
		FriendVO friendVO = new FriendVO();
		friendVO.setMem1_no(mem1_no);
		friendVO.setMem2_no(mem2_no);
		dao.updateRelationship(mem1_no, mem2_no, relationship);
		return friendVO;
	}
	
	
}
