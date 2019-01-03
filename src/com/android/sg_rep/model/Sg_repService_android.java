package com.android.sg_rep.model;

import java.sql.SQLException;
import java.util.List;

public class Sg_repService_android {

	private Sg_repDAO_interface_android dao;
	
	public Sg_repService_android() {
		dao = new Sg_repDAO_android();
	}
	
	public void insert(Sg_repVO_android sg_repVO) throws SQLException {
		dao.insert(sg_repVO);
	}

	public void Update(Sg_repVO_android sg_repVO) {
		dao.update(sg_repVO);
	}
	
	public void delete(String rep_no) {
		dao.delete(rep_no);
	}
	
	public List<Sg_rep> findByMem(String mem_no) {
		return dao.findByMem(mem_no);
	}
	
	public List<Sg_rep> getAll() {
		return dao.getAll();
	}

}
