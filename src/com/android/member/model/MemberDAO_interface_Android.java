package com.android.member.model;

import java.util.*;

public interface MemberDAO_interface_Android {
	public void insert(MemberVO_Andorid memberlist);
	public void updatePrivacy(MemberVO_Andorid memberlist);
//	public void updatePicture(MemberlistVO memberlist);
	public void updatePassword(MemberVO_Andorid memberlist);
	public void updateCraditcard(MemberVO_Andorid memberlist);
	public void updateStatus(String mem_no,String mem_status);
	public MemberVO_Andorid findByPrimaryKey(String mem_no);
	public List<MemberVO_Andorid> getAll();
	public boolean isMember(String mem_account, String mem_pswd);
}
