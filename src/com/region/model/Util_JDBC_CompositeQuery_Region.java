package com.region.model;

import java.util.Set;
import java.util.List;
import java.util.Map;

public class Util_JDBC_CompositeQuery_Region {
	public static String get_aCondition_For_Oracle(String columnName, String value) {
		String aCondition = null;
		// reg_no , reg_name , reg_dist
		// Varchar2 like
		if("reg_name".equals(columnName) || "reg_dist".equals(columnName) ) {
			aCondition = columnName + " like '%"+value+"%' ";
		// Number
		}else if( "reg_no".equals(columnName)) {
			aCondition = " "+columnName + "=" + value+" ";
		}
		return aCondition;
	}
	
	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for(String key:keys) {
			String value = map.get(key)[0];
			System.out.print("(key,value)=("+key+","+value+")");
			if(value != null && value.trim().length() != 0 && !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());
				System.out.println("aCondition : "+aCondition);
				if(count==1) {
					whereCondition.append(" where "+aCondition);
				}else {
					whereCondition.append(" and "+aCondition);
				}
				System.out.println("送出的欄位數"+count);
			}
		}
		return whereCondition.toString();
	}

	

}
