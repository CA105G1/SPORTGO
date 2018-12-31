package com.region.model;

import java.util.List;
import java.util.Map;

public class Util_Check_Region_Parameter {
	
	public static Map<String, String[]> checkRegionMap(Map<String, String[]> map, List<String> errorMsgs) {
		map = checkReg_no(map, errorMsgs);
		return map;
	}
	public static Map<String, String[]> checkReg_no(Map<String, String[]> map, List<String> errorMsgs) {
		String key_reg_no = "reg_no";
		try {
			if(map.containsKey(key_reg_no)) {
				String reg_no = map.get(key_reg_no)[0];
				if(reg_no == null || reg_no.trim().length()==0) {
					return map;
				}
				Integer reg_no_int = new Integer(reg_no);
			}
		}catch (Exception e) {
			map.remove(key_reg_no);
			errorMsgs.add("郵遞區號碼格式不對");
		}
		return map;
	}
}
