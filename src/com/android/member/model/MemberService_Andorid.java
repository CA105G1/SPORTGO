package com.android.member.model;

import java.util.*;

public class MemberService_Andorid {

	private MemberDAO_interface_Android dao;
	public MemberService_Andorid() {
		dao = new MemberDAO_Andorid();
	}
	
	public MemberVO_Andorid addmemberlist(String mem_name,String mem_account,String mem_pswd,
			String mem_email,String mem_phone) {
		
		MemberVO_Andorid memberlistVO = new MemberVO_Andorid(mem_name,mem_account,mem_pswd,
				mem_email,mem_phone);
		dao.insert(memberlistVO);
		
		return memberlistVO;
	}
	
	public MemberVO_Andorid renewPrivacy(String mem_no,String mem_name,String mem_nick,
			String mem_email,String mem_phone,String mem_emgc, String mem_emgcphone) {
		
		MemberVO_Andorid memberlistVO = new MemberVO_Andorid(mem_no,mem_name,mem_nick,
				mem_email,mem_phone,mem_emgc,mem_emgcphone);
		dao.updatePrivacy(memberlistVO);
		
		return memberlistVO;
	}
	
	public MemberVO_Andorid renewCard(String mem_no,String mem_card, String mem_expiry) {
		
		MemberVO_Andorid memberlistVO = new MemberVO_Andorid(mem_no,mem_card,mem_expiry);
		dao.updateCraditcard(memberlistVO);
		
		return memberlistVO;
	}
	
	public MemberVO_Andorid renewPassword(String mem_no, String mem_password) {
		
		MemberVO_Andorid memberlistVO = new MemberVO_Andorid(mem_no,mem_password);
		dao.updatePassword(memberlistVO);
		
		return memberlistVO;
	}
	
//	public MemberlistVO renewPicture(String mem_no, byte[] mem_pic,String mem_pickind) {
//		MemberlistVO memberlistVO = new MemberlistVO(mem_no,mem_pic,mem_pickind);
//		dao.updatePicture(memberlistVO);
//		
//		return memberlistVO;
//	}
	
	public void changeStatus(String mem_no, String mem_status) {
		dao.updateStatus(mem_no, mem_status);
	}
	
	public MemberVO_Andorid getOneMem(String mem_no) {	
		return dao.findByPrimaryKey(mem_no);
	}
	
	public List<MemberVO_Andorid> getAllMem(){
		return dao.getAll();
	}
}
