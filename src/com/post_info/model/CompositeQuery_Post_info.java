package com.post_info.model;

import java.util.Map;
import java.util.Set;

public class CompositeQuery_Post_info {
	public static String get_aCondition_For_Oracle(String keyword,String club_no) {
		String aCondition = null;
		
			aCondition = "post_topic" + " like '%" + keyword + "%' or post_content" + " like '%" + keyword + "%'"
						+ " and " + " club_no= '" + club_no+"'";
//			select * from post_info where (post_topic like '%運動%' or post_content like '%運動%') and club_no='C0001' order by post_no;
		return aCondition + " ";
		}

	public static String get_WhereCondition(String keyword,String club_no) {
		StringBuffer whereCondition = new StringBuffer();
			if (keyword != null && !keyword.isEmpty()) {
				String aCondition = get_aCondition_For_Oracle(keyword.trim(),club_no);

				whereCondition.append(" where " + aCondition);
			}
		return whereCondition.toString();
	}

}

