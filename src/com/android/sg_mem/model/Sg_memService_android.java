package com.android.sg_mem.model;

import java.sql.SQLException;
import java.util.List;

public class Sg_memService_android {
	
	private Sg_memDAO_interface_android dao;
	
	public Sg_memService_android() {
		dao = new Sg_memDAO_android();
	}
	
	public void insertSGMember(Sg_memVO_android sg_memVO) throws SQLException {
		dao.insert(sg_memVO);
	}
	
	public void deleteSGMember(String sg_no, String mem_no) {
		dao.delete(sg_no, mem_no);
	}
	
	public void checkIn(String sg_no, String mem_no) throws SQLException {
		dao.update(sg_no, mem_no);
	}
	
	public List<SGMember> getSGMember(String sg_no) {
		return dao.findBySG(sg_no);
	}
	
	public List<SGMember> getMemberSG(String mem_no) {
		return dao.findByMem(mem_no);
	}
	
}
