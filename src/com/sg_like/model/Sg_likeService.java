package com.sg_like.model;

import com.sg_mem.model.Sg_memVO;

public class Sg_likeService {
	private Sg_likeDAO_interface dao = null;
	
	public Sg_likeService () {
		dao = new Sg_likeJDBCDAO();
	}
	
	public Sg_likeVO insertSg_like(String sg_no, String mem_no) {
		Sg_likeVO vo = new Sg_likeVO();
		
		vo.setSg_no(sg_no);
		vo.setMem_no(mem_no);
		
		dao.insert(vo);
		return vo;
	}
	
	public void deleteSg_like(String sg_no, String mem_no) {
		dao.delete(sg_no,mem_no);
	}
	
	public boolean isLike(String sg_no, String mem_no) {
		return dao.isLike(sg_no, mem_no);
	}
	
	
}
