package com.post_info.model;

import java.util.Map;
import java.util.Set;

public class CompositeQuery_Post_info {
	public static String get_aCondition_For_Oracle(String keyword) {
		String aCondition = null;
		
			aCondition = "post_topic" + " like '%" + keyword + "%' or post_content" + " like '%" + keyword + "%'";
		
		return aCondition + " ";
		}

	public static String get_WhereCondition(String keyword) {
		StringBuffer whereCondition = new StringBuffer();
			if (keyword != null && !keyword.isEmpty()) {
				String aCondition = get_aCondition_For_Oracle(keyword.trim());

				
					whereCondition.append(" where " + aCondition);
				System.out.println("whereCondition" + whereCondition.toString());

			}
			System.out.println("whereCondition" + whereCondition.toString());
		
		return whereCondition.toString();
	}

}

