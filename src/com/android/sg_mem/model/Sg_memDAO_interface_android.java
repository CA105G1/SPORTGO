package com.android.sg_mem.model;

import java.sql.SQLException;
import java.util.List;

public interface Sg_memDAO_interface_android {
	public void insert(Sg_memVO_android sg_memVO) throws SQLException;
	public void update(String sg_no, String mem_no) throws SQLException;
	public void delete(String sg_no, String mem_no);
	public List<SGMember> findBySG(String sg_no);
	public List<SGMember> findByMem(String mem_no);
	
}
