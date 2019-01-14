package com.android.member.model;

import java.util.*;

public interface MemberDAO_interface_android {
	public void insert(MemberVO_android memberlist);
	public void updatePrivacy(MemberVO_android memberlist);
//	public void updatePicture(MemberlistVO memberlist);
	public void updatePassword(MemberVO_android memberlist);
	public void updateCraditcard(MemberVO_android memberlist);
	public void updateStatus(String mem_no,String mem_status);
	public Member findByPrimaryKey(String mem_no);
	public List<MemberVO_android> getAll();
	public Member isMember(String mem_account, String mem_pswd);
	public byte[] getImage(String mem_no);
}
