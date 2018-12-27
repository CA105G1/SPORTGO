package com.android.sport.model;

import java.util.List;


public class SportService {
	
	private SportDAO_interface_Android dao = null;
	
	public SportService() {
		dao = new SportDAO_Android();
	}
	
	public SportVO_Android insert(String sp_name) {
		SportVO_Android vo = new SportVO_Android();
		vo.setSp_name(sp_name);
		
		dao.insert(vo);
		return vo;
	}
	
	public SportVO_Android update(String sp_name) {
		SportVO_Android vo = new SportVO_Android();
		vo.setSp_name(sp_name);
		
		dao.update(vo);
		return vo;
	}
	
	public void delete(String sp_no) {
		dao.delete(sp_no);
	}
	
	public SportVO_Android GetByPK(String sp_no) {
		return dao.findByPk(sp_no);
	}
	
	public List<SportVO_Android> getAll(){
		return dao.getAll();
	}

}
