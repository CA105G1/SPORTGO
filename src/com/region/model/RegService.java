package com.region.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;

public class RegService {
	private RegDAO_interface regDAO = null;
	private List<String> reg_nameList =null;
	private Map<String, List<RegVO>> regionMapKeyReg_name = null;
	
	
	public RegService() {
		this.regDAO = new RegDAO();
//		this.regDAO = new RegJDBCDAO();
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
	
	public void setRegionMapKeyReg_name() {
		if(reg_nameList==null) {
			setReg_nameList();
		}
		regionMapKeyReg_name = new LinkedHashMap<>();
		for(String reg_name: reg_nameList) {
			Map<String, String[]> map = new HashMap<>();
			String[] reg_name_array = {reg_name};
			map.put("reg_name", reg_name_array);
			List<RegVO> list = regDAO.getAll(map);
			regionMapKeyReg_name.put(reg_name, list);
		}
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
	// version 1
//	public List<RegVO> getRegVOFormRegName(String reg_name) {
//		Map<String, String[]> map = new HashMap<>();
//		String[] reg_name_array = {reg_name};
//		map.put("reg_name", reg_name_array);
//		return regDAO.getAll(map);
//	}
	public List<String> getRegVOFormRegName(String reg_name){
		Map<String, String[]> map = new HashMap<>();
		String[] reg_name_array = {reg_name};
		map.put("reg_name", reg_name_array);
		List<RegVO> listRegVO = regDAO.getAll(map);
		List<String> list = new ArrayList<>();
		for(RegVO regVO : listRegVO) {
			list.add(regVO.getReg_dist());
		}
		return list;
	}
	
	
//	// version 2
//	public List<RegVO> getRegVOFormRegName(String reg_name) {
//		return regionMapKeyReg_name.get(reg_name);
//	}
//	public Map<String, List<RegVO>> getRegionMapKeyReg_name(){
//		if(regionMapKeyReg_name==null) {
//			setRegionMapKeyReg_name();
//		}
//		return regionMapKeyReg_name;
//	}
	

}
