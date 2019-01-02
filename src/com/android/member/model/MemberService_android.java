package com.android.member.model;

public class MemberService_android {

	private MemberDAO_interface_android dao;
	public MemberService_android() {
		dao = new MemberDAO_android();
	}
	
	public MemberVO_android getMember(String mem_no) {
		
		return dao.findByPrimaryKey(mem_no);
		
	}

	public String isMember(String mem_no, String mem_pswd) {
		return dao.isMember(mem_no, mem_pswd);

	}
	
	public byte[] getProfilePic(String mem_no) {
		return dao.getImage(mem_no);
	}

}
