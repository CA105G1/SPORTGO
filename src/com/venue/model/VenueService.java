package com.venue.model;

import java.util.List;

public class VenueService {
	
	private VenueDAO_interface venueDAO;
	
	public VenueService() {
		venueDAO = new VenueDAO();
	}
	
	public List<VenueVO> getAll(){
		return venueDAO.getAll();
	}
	
	public VenueVO getOneVenue(String v_no) {
		return venueDAO.findByPrimaryKey(v_no);
	}
	
	public void deleteVenue(String v_no) {
		venueDAO.delete(v_no);
	}
	
	public void addVenue(String v_name, String vt_no, 
			Integer reg_no, Double v_lat, Double v_long,
			String v_pic, String v_address, String v_phoneno,
			String v_status, String v_func) {
		VenueVO venueVO = new VenueVO();
		venueVO.setV_name(v_name);
		venueVO.setVt_no(vt_no);
		venueVO.setReg_no(reg_no);
		venueVO.setV_lat(v_lat);
		venueVO.setV_long(v_long);
		venueVO.setV_pic(v_pic);
		venueVO.setV_address(v_address);
		venueVO.setV_phoneno(v_phoneno);
		venueVO.setV_status(v_status);
		venueVO.setV_func(v_func);
		venueDAO.insert(venueVO);
	}

	public void updateVenue(String v_no, String v_name, String vt_no, 
			Integer reg_no, Double v_lat, Double v_long,
			String v_pic, String v_address, String v_phoneno,
			String v_status, String v_func) {
		VenueVO venueVO = new VenueVO();
		venueVO.setV_no(v_no);
		venueVO.setV_name(v_name);
		venueVO.setVt_no(vt_no);
		venueVO.setReg_no(reg_no);
		venueVO.setV_lat(v_lat);
		venueVO.setV_long(v_long);
		venueVO.setV_pic(v_pic);
		venueVO.setV_address(v_address);
		venueVO.setV_phoneno(v_phoneno);
		venueVO.setV_status(v_status);
		venueVO.setV_func(v_func);
		venueDAO.update(venueVO);
	}
}
