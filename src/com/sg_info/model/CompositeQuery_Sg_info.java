/*
 *  1. 萬用複合查詢-可由客戶端隨意增減任何想查詢的欄位
 *  2. 為了避免影響效能:
 *        所以動態產生萬用SQL的部份,本範例無意採用MetaData的方式,也只針對個別的Table自行視需要而個別製作之
 * */


package com.sg_info.model;

import java.util.*;

public class CompositeQuery_Sg_info {

	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("sp_no".equals(columnName) || "v_no".equals(columnName)) // 用於sg_info有的欄位
			aCondition = "sg_info."+columnName + " like '%" + value + "%'";
		else if("reg_no".equals(columnName))  // 用於venue有的欄位
			aCondition = "venue."+columnName + " like '%" + value + "%'";
		else if ("sg_date".equals(columnName))                          // 用於Oracle的date
			aCondition = "to_char(" + "sg_info." + columnName + ",'yyyy-mm-dd')='" + value + "'";
		else if("keyword".equals(columnName)) //關鍵字查詢
			aCondition = "sg_info.sg_name" + " like '%" + value + "%'";
			
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		
		return whereCondition.toString();
	}

}
