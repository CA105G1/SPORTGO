package com.memberlist.model;

import java.util.*;

public interface MemberlistDAO_interface {
	public void insert(MemberlistVO memberlist);
	public void updatePrivacy(MemberlistVO memberlist);
	public void updatePicture(MemberlistVO memberlist);
	public void updatePassword(MemberlistVO memberlist);
	public void updateCraditcard(MemberlistVO memberlist);
	public void updateStatus(String mem_no,String mem_status);
	public MemberlistVO findByPrimaryKey(String mem_no);
	public List<MemberlistVO> getAll();
}
