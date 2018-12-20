package com.sg_info.model;

import java.sql.Timestamp;
import java.util.List;

public class Sg_infoService {
	private Sg_infoDAO_interface dao = null;
	
	public Sg_infoService() {
		dao = new Sg_infoJDBCDAO();
	}
	
	public Sg_infoVO insertSg_info(String mem_no, String sg_name, Timestamp sg_date, Timestamp apl_start, Timestamp apl_end, 
			Integer sg_fee, byte[] sg_pic, String sg_pic_ext, String sg_per, String sp_no, String venue_no, 
			Integer sg_maxno, Integer sg_minno, Integer sg_ttlapl, Integer sg_chkno, String sg_extrainfo, Double loc_start_lat, 
			Double loc_start_lng,Double loc_end_lat, Double loc_end_lng) {
		
		Sg_infoVO vo = new Sg_infoVO();
		
		vo.setMem_no(mem_no);
		vo.setSg_name(sg_name);
		vo.setSg_date(sg_date);
		vo.setApl_start(apl_start);
		vo.setApl_end(apl_end);
		vo.setSg_fee(sg_fee);
		vo.setSg_pic(sg_pic);
		vo.setSg_pic_ext(sg_pic_ext);
		vo.setSg_per(sg_per);
		vo.setSp_no(sp_no);
		vo.setVenue_no(venue_no);
		vo.setSg_maxno(sg_maxno);
		vo.setSg_minno(sg_minno);
		vo.setSg_ttlapl(sg_ttlapl);
		vo.setSg_chkno(sg_chkno);
		vo.setSg_extrainfo(sg_extrainfo);
		vo.setLoc_start_lat(loc_start_lat);
		vo.setLoc_start_lng(loc_start_lng);
		vo.setLoc_end_lat(loc_end_lat);
		vo.setLoc_end_lng(loc_end_lng);
		
		dao.insert(vo);
		return vo;
	}
	
	
	
	
	public Sg_infoVO updateSg_info(String sg_no, String mem_no, String sg_name, Timestamp sg_date, Timestamp apl_start, Timestamp apl_end, 
			Integer sg_fee, byte[] sg_pic, String sg_pic_ext, String sg_per, String sp_no, String venue_no, 
			Integer sg_maxno, Integer sg_minno, Integer sg_ttlapl, String sg_extrainfo, Double loc_start_lat, 
			Double loc_start_lng,Double loc_end_lat, Double loc_end_lng) {
		
		Sg_infoVO vo = new Sg_infoVO();
		
		vo.setSg_no(sg_no);
		vo.setMem_no(mem_no);
		vo.setSg_name(sg_name);
		vo.setSg_date(sg_date);
		vo.setApl_start(apl_start);
		vo.setApl_end(apl_end);
		vo.setSg_fee(sg_fee);
		vo.setSg_pic(sg_pic);
		vo.setSg_pic_ext(sg_pic_ext);
		vo.setSg_per(sg_per);
		vo.setSp_no(sp_no);
		vo.setVenue_no(venue_no);
		vo.setSg_maxno(sg_maxno);
		vo.setSg_minno(sg_minno);
		vo.setSg_ttlapl(sg_ttlapl);
		vo.setSg_extrainfo(sg_extrainfo);
		vo.setLoc_start_lat(loc_start_lat);
		vo.setLoc_start_lng(loc_start_lng);
		vo.setLoc_end_lat(loc_end_lat);
		vo.setLoc_end_lng(loc_end_lng);
		
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
	
	
	
	
}
