package com.sg_info.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class Sg_infoService {
	private Sg_infoDAO_interface dao = null;
	
	public Sg_infoService() {
		dao = new Sg_infoDAO();
	}
	
	public Sg_infoVO insertSg_info(String mem_no, String sg_name, Timestamp sg_date, String club_no, Timestamp apl_end, 
			Integer sg_fee, byte[] sg_pic, String sg_pic_ext, String sg_per, String sp_no, String v_no, 
			Integer sg_maxno, Integer sg_minno, Integer sg_ttlapl, Integer sg_chkno, String sg_extrainfo, String loc_start, 
			String loc_end) {
		
		Sg_infoVO vo = new Sg_infoVO();
		
		vo.setMem_no(mem_no);
		vo.setSg_name(sg_name);
		vo.setSg_date(sg_date);
		vo.setClub_no(club_no);
		vo.setApl_end(apl_end);
		vo.setSg_fee(sg_fee);
		vo.setSg_pic(sg_pic);
		vo.setSg_pic_ext(sg_pic_ext);
		vo.setSg_per(sg_per);
		vo.setSp_no(sp_no);
		vo.setV_no(v_no);
		vo.setSg_maxno(sg_maxno);
		vo.setSg_minno(sg_minno);
		vo.setSg_ttlapl(sg_ttlapl);
		vo.setSg_chkno(sg_chkno);
		vo.setSg_extrainfo(sg_extrainfo);
		vo.setLoc_start(loc_start);
		vo.setLoc_end(loc_end);
		
		dao.insert(vo);
		return vo;
	}
	
	
	
	
	public Sg_infoVO updateSg_info(String sg_no, String mem_no, String sg_name, Timestamp sg_date, String club_no, Timestamp apl_end, 
			Integer sg_fee, byte[] sg_pic, String sg_pic_ext, String sg_per, String sp_no, String v_no, 
			Integer sg_maxno, Integer sg_minno, String sg_extrainfo, String loc_start, 
			String loc_end) {
		
		Sg_infoVO vo = new Sg_infoVO();
		
		vo.setSg_no(sg_no);
		vo.setMem_no(mem_no);
		vo.setSg_name(sg_name);
		vo.setSg_date(sg_date);
		vo.setClub_no(club_no);
		vo.setApl_end(apl_end);
		vo.setSg_fee(sg_fee);
		vo.setSg_pic(sg_pic);
		vo.setSg_pic_ext(sg_pic_ext);
		vo.setSg_per(sg_per);
		vo.setSp_no(sp_no);
		vo.setV_no(v_no);
		vo.setSg_maxno(sg_maxno);
		vo.setSg_minno(sg_minno);
		vo.setSg_extrainfo(sg_extrainfo);
		vo.setLoc_start(loc_start);
		vo.setLoc_end(loc_end);
		
		dao.update(vo);
		return vo;
	}
	
	public void deleteSg_info(String sg_no) {
		dao.delete(sg_no);
	}
	
	
	public Sg_infoVO GetByPK(String sg_no) {
		return dao.findByPk(sg_no);
	}
	
	public List<Sg_infoVO> getAll(){
		return dao.getAll();
	}
	public List<Sg_infoVO> getAllForPublic(){
		return dao.getAllForPublic();
	}
	
	public List<Sg_infoVO> getAllByQuery(Map<String,String[]> map){
		return dao.getAll(map);
	}
	
	public void updateStatus(String sg_no, String sg_status) {
		dao.updateStatus(sg_no, sg_status);
	}
	
	public void updateTtlapl(String sg_no, Integer sg_ttlapl) {
		dao.updateTtlapl(sg_no, sg_ttlapl);
	}
	
	
}
