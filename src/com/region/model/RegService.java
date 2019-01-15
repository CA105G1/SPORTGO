package com.region.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class RegService {
	private RegDAO_interface regDAO = null;
	private List<String> reg_nameList =null;
	
	
	
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
	
	public void setReg_nameList(){
		List<RegVO> regVOs = regDAO.getAll();
		LinkedHashSet<String> reg_nameSet = new LinkedHashSet<>();
		for(int i = 0 ; i<regVOs.size(); i++) {
			String reg_name = regVOs.get(i).getReg_name();
			if(!reg_nameSet.contains(reg_name)) {
				reg_nameSet.add(reg_name);
			}
		}
		reg_nameList = new ArrayList<>();
		for(String reg_name : reg_nameSet) {
			reg_nameList.add(reg_name);
		}
	}
	public List<String> getReg_nameList(){
		if(reg_nameList==null) {
			setReg_nameList();
		}
		return reg_nameList;
	}
	public List<RegVO> getRegVOFormRegName(String reg_name) {
		Map<String, String[]> map = new HashMap<>();
		String[] reg_name_array = {reg_name};
		map.put("reg_name", reg_name_array);
		return regDAO.getAll(map);
	}
	

}
