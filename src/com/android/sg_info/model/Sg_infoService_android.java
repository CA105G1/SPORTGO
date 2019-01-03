package com.android.sg_info.model;

import java.sql.Timestamp;
import java.util.List;


public class Sg_infoService_android {
	
	private Sg_infoDAO_interface_android dao = null;
	
	public Sg_infoService_android() {
		dao = new Sg_infoDAO_android();
	}
	
	public Sg_infoVO_android insertSg_info(String mem_no, String sg_name, Timestamp sg_date, Timestamp apl_start, Timestamp apl_end, 
			Integer sg_fee, String sg_per, String sp_no, String v_no, 
			Integer sg_maxno, Integer sg_minno, Integer sg_ttlapl, Integer sg_chkno, String sg_extrainfo, String loc_start,String loc_end) {
		
		Sg_infoVO_android vo = new Sg_infoVO_android();
		
		vo.setMem_no(mem_no);
		vo.setSg_name(sg_name);
		vo.setSg_date(sg_date);
		vo.setApl_start(apl_start);
		vo.setApl_end(apl_end);
		vo.setSg_fee(sg_fee);
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
	
	public Sg_infoVO_android updateSg_info(String sg_no, String mem_no, String sg_name, Timestamp sg_date, Timestamp apl_start, Timestamp apl_end, 
			Integer sg_fee, String sg_per, String sp_no, String v_no, 
			Integer sg_maxno, Integer sg_minno, Integer sg_ttlapl, String sg_extrainfo,String loc_start,String loc_end) {
		
		Sg_infoVO_android vo = new Sg_infoVO_android();
		
		vo.setSg_no(sg_no);
		vo.setMem_no(mem_no);
		vo.setSg_name(sg_name);
		vo.setSg_date(sg_date);
		vo.setApl_start(apl_start);
		vo.setApl_end(apl_end);
		vo.setSg_fee(sg_fee);
		vo.setSg_per(sg_per);
		vo.setSp_no(sp_no);
		vo.setV_no(v_no);
		vo.setSg_maxno(sg_maxno);
		vo.setSg_minno(sg_minno);
		vo.setSg_ttlapl(sg_ttlapl);
		vo.setSg_extrainfo(sg_extrainfo);
		vo.setLoc_start(loc_start);
		vo.setLoc_end(loc_end);
		
		dao.update(vo);
		return vo;
	}
	
	public void cancelSG(String sg_no) {
		dao.cancel(sg_no);
	}
	
	
	public List<Sg_info> getBySP(String sp_no) {
		return dao.findBySp(sp_no);
		
	}
	
	public Sg_info getByPK(String sg_no) {
		return dao.findByPK(sg_no);
		
	}
	
	public List<Sg_info> getByMem(String mem_no) {
		return dao.findByMem(mem_no);
		
	}
	
	public List<Sg_info> getByLike(String mem_no) {
		return dao.findByLike(mem_no);
		
	}
	
	public List<Sg_info> getAll(){
		return dao.getAll();

	}
	
	public byte[] getPic(String sg_no) {
		return dao.getImage(sg_no);
	}
	
	
}
