package com.sg_rep.model;

import java.util.List;

public class Sg_repService {
	private Sg_repDAO_interface dao = null;
	
	public Sg_repService() {
		dao = new Sg_repDAO();
	}
	
	public Sg_repVO insertSg_rep(String sg_no, String mem_no, String rep_type, String rep_cont) {
		Sg_repVO vo = new Sg_repVO();
		vo.setSg_no(sg_no);
		vo.setMem_no(mem_no);
		vo.setRep_type(rep_type);
		vo.setRep_cont(rep_cont);
		dao.insert(vo);
		
		return vo;
	}
	
	public List<Sg_repVO> getAll(){
		return dao.getAll();
	}
	
	public Sg_repVO update(String rep_no, String rep_status) {
		Sg_repVO vo = new  Sg_repVO();
		vo.setRep_no(rep_no);
		vo.setRep_status(rep_status);
		dao.update(vo);
		
		return vo;
	}
	
}
