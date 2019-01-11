package com.android.friend.model;

import java.util.List;

import com.android.member.model.MemberService_android;

public class FriendService_android {

	private FriendDAO_interface dao;
	private MemberService_android service = new MemberService_android();
	
	public FriendService_android() {
		dao = new FriendDAO_android();
	}
	
	public Friend addFriend(String mem1_no,String mem2_no) {
		Friend Friend = new Friend();
		Friend.setMem1_no(mem1_no);
		Friend.setMem2_no(mem2_no);
		dao.insert(mem1_no, mem2_no);
		return Friend;
	}
	
	public void deleteFriend(String mem1_no,String mem2_no) {
		dao.delete(mem1_no, mem2_no);
	}
	
	public List<Friend> findMyFriend(String mem_no){
		List<Friend> list = dao.findMyFriend(mem_no);
		for (Friend x: list) {
			x.setMem1_name(service.getMember(x.getMem1_no()).getMem_name());
			x.setMem2_name(service.getMember(x.getMem2_no()).getMem_name());
		}
		
		return list;
	}
	
	public List<Friend> findMyPossibleFriend(String mem_no){
		List<Friend> list = dao.findMyPossibleFriend(mem_no);
		for (Friend x: list) {
			x.setMem1_name(service.getMember(x.getMem1_no()).getMem_name());
			x.setMem2_name(service.getMember(x.getMem2_no()).getMem_name());
		}
		
		return list;
	}
	
	public List<Friend> findWhoAdd(String mem_no){
		List<Friend> list = dao.findWhoAddMe(mem_no);
		for (Friend x: list) {
			x.setMem1_name(service.getMember(x.getMem1_no()).getMem_name());
			x.setMem2_name(service.getMember(x.getMem2_no()).getMem_name());
		}
		
		return list;
	}
	
	public List<Friend> getAll(){
		return dao.findAll();
	}
	
	public Friend changeStatus(String mem1_no,String mem2_no,String status) {
		Friend Friend = new Friend();
		Friend.setMem1_no(mem1_no);
		Friend.setMem2_no(mem2_no);
		Friend.setFriend_status(status);
		dao.updateStatus(mem1_no, mem2_no, status);
		return Friend;
	}
	
	public Friend changeReletionship(String mem1_no,String mem2_no,String relationship) {
		Friend Friend = new Friend();
		Friend.setMem1_no(mem1_no);
		Friend.setMem2_no(mem2_no);
		dao.updateRelationship(mem1_no, mem2_no, relationship);
		return Friend;
	}
	
}
