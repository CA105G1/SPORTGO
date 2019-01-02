package com.sport.model;

import java.util.List;


public class SportService {
	
	private SportDAO_interface dao = null;
	
	public SportService() {
		dao = new SportDAO();
	}
	
	public SportVO insert(String sp_name) {
		SportVO vo = new SportVO();
		vo.setSp_name(sp_name);
		
		dao.insert(vo);
		return vo;
	}
	
	public SportVO update(String sp_name) {
		SportVO vo = new SportVO();
		vo.setSp_name(sp_name);
		
		dao.update(vo);
		return vo;
	}
	
	public void delete(String sp_no) {
		dao.delete(sp_no);
	}
	
	public SportVO getByPK(String sp_no) {
		return dao.findByPk(sp_no);
	}
	
	public List<SportVO> getAll(){
		return dao.getAll();
	}
	
	
	

}
