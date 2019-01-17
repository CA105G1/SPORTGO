package com.news.model;

import java.util.Set;
import java.util.List;
import java.util.Map;

public class Util_JDBC_CompositeQuery_News {
	public static String get_aCondition_For_Oracle(String columnName, String value) {
		String aCondition = null;
		// Varchar2 like
		if("news_no".equals(columnName) || "newstype_no".equals(columnName) || "news_stutas".equals(columnName)) {
			aCondition = columnName + " = '"+value+"' ";
		}else if("news_script".equals(columnName) || "pic_extension".equals(columnName)) {
			aCondition = columnName + " like '%"+value+"%' ";
		// TimeStamp
		}else if( "news_release_date".equals(columnName) || "news_last_date".equals(columnName)) {
			aCondition = "to_char(" + columnName + ",'yyyy-mm-dd hh24:mi')='" + value + "'";
			//to_timestamp('2018-12-08 14:45:32','yyyy-mm-dd hh24:mi:ss')
		}
		return aCondition;
	}
	
	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for(String key:keys) {
			String value = map.get(key)[0];
System.out.println("name : "+key+" ; value : "+value);
			if(value != null && value.trim().length() != 0 
					&& !"action".equals(key) && !"hasChangePicture".equals(key)
					 && !"whichPage".equals(key) && !"requestURL".equals(key)) {
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
		return whereCondition.toString();
	}

	

}
