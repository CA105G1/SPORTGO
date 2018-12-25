package com.android.member.model;

import java.util.*;

public interface MemberDAO_interface_Android {
	public void insert(MemberVO_Android memberlist);
	public void updatePrivacy(MemberVO_Android memberlist);
//	public void updatePicture(MemberlistVO memberlist);
	public void updatePassword(MemberVO_Android memberlist);
	public void updateCraditcard(MemberVO_Android memberlist);
	public void updateStatus(String mem_no,String mem_status);
	public MemberVO_Android findByPrimaryKey(String mem_no);
	public List<MemberVO_Android> getAll();
	public String isMember(String mem_account, String mem_pswd);
	public byte[] getImage(String mem_no);
}
