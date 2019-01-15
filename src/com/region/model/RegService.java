package com.region.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RegService {
	private RegDAO_interface regDAO = null;
	
	public RegService() {
		this.regDAO = new RegDAO();
	}
	
	public List<RegVO> getAll(){
		return regDAO.getAll();
	}
	
	public RegVO getRegVOFromAddress(String address) {
		return regDAO.getRegVOFromAddress(address);
	}
	
	public RegVO getRegVOByPK(Integer reg_no) {
		return regDAO.findByPrimaryKey(reg_no);
	}
	
	public List<RegVO> getRegVOFormRegName(String reg_name) {
		Map<String, String[]> map = new HashMap<>();
		String[] reg_name_array = {reg_name};
		map.put("reg_name", reg_name_array);
		return regDAO.getAll(map);
	}
	

}
