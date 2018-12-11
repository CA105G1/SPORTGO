package com.memberlist.model;

import java.util.*;

public interface MemberlistDAO_interface {
	public void insert(MemberlistVO memberlist);
	public void update(MemberlistVO memberlist);
	public MemberlistVO findByPrimaryKey(String mem_no);
	public List<MemberlistVO> getAll();
}
