package com.venue.model;

import java.util.Set;
import java.util.TreeMap;
import java.lang.reflect.MalformedParameterizedTypeException;
import java.util.Map;

public class Util_JDBC_CompositeQuery_Venue {
	public static String get_aCondition_For_Oracle(String columnName, String value) {
		String aCondition = null;
		// Varchar2 like
		if("v_no".equals(columnName)) {
			aCondition = columnName + " = '"+value+"' ";
		}else if("v_name".equals(columnName) || "v_weburl".equals(columnName) 
				 || "v_parktype".equals(columnName) || "vt_no".equals(columnName) || "v_inout".equals(columnName) 
				 || "v_address".equals(columnName) || "v_phoneno".equals(columnName) || "v_fitall".equals(columnName) 
				 || "v_fitinter".equals(columnName) || "open_state".equals(columnName) || "open_time".equals(columnName) 
				 || "openday_mon".equals(columnName) || "openday_tue".equals(columnName) || "openday_wed".equals(columnName) 
				 || "openday_thu".equals(columnName) || "openday_fri".equals(columnName) || "openday_sat".equals(columnName)
				 || "openday_sun".equals(columnName) || "v_display".equals(columnName) ) {
			aCondition = columnName + " like '%"+value+"%' ";
		// Number
		}else if( "reg_no".equals(columnName) || "v_lat".equals(columnName) || "v_long".equals(columnName)) {
			aCondition = " "+columnName + "=" + value+" ";
		}
		return aCondition;
	}
	
	public static String get_WhereCondition(Map<String, String[]> map) {
		return get_WhereCondition(map,false);
	}
	
	public static String get_WhereCondition(Map<String, String[]> map, boolean isFrontEnd) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for(String key:keys) {
			String value = map.get(key)[0];
			if(value != null && value.trim().length() != 0 && !"action".equals(key) 
					&& !"whichPage".equals(key) && !"requestURL".equals(key) && !"hasChangePictiure".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());
//				System.out.println("aCondition : "+aCondition);
				if(count==1) {
					whereCondition.append(" where "+aCondition);
				}else {
					whereCondition.append(" and "+aCondition);
				}
//				System.out.println("送出的欄位數"+count);
			}
		}
		if(isFrontEnd) {
			if(count==0) {
				whereCondition.append(" where v_fitall='Y' and v_display='顯示' and open_state in ('免費對外開放使用', '付費對外開放使用') ");
			}else {
				whereCondition.append(" and v_fitall='Y' and v_display='顯示'  and open_state in ('免費對外開放使用', '付費對外開放使用') ");				
			}
		}
		return whereCondition.toString();
	}
//	
//	public static void main(String[] args) {
//		Map<String, String[]> map = new TreeMap<>();
//		map.put("vt_no", new String[] {"VT005"});
//		
//		String string =Util_JDBC_CompositeQuery_Venue.get_WhereCondition(map, true);
//		System.out.println("String : "+string);
//		
//	}
}
