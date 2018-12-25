package com.android.member.model;

public class MemberService_Android {

	private MemberDAO_interface_Android dao;
	public MemberService_Android() {
		dao = new MemberDAO_Android();
	}
	
	public MemberVO_Android getMember(String mem_no) {
		
		return dao.findByPrimaryKey(mem_no);
		
	}

	public String isMember(String mem_no, String mem_pswd) {
		return dao.isMember(mem_no, mem_pswd);

	}
	
	public byte[] getProfilePic(String mem_no) {
		return dao.getImage(mem_no);
	}

}
