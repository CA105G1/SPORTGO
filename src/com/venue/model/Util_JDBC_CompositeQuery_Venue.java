package com.venue.model;

import java.util.Set;
import java.util.TreeMap;
import java.lang.reflect.MalformedParameterizedTypeException;
import java.security.KeyStore.PrivateKeyEntry;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Util_JDBC_CompositeQuery_Venue {
	
	public static String get_Right_Join_SubSelectForGetScoreBetween(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer right_join_clanse = new StringBuffer();
		Map<String, String> scoreMap = new HashMap<>();
		for(String key:keys) {
			if("score_max".equals(key) || "score_min".equals(key)) {
				String value = map.get(key)[0];
				if(value!=null && value.trim().length()>0) {
					scoreMap.put(key, value);
				}
			}
		}
		if(scoreMap.size()!=0) {
			if(!scoreMap.containsKey("score_max")) {
				scoreMap.put("score_max", "5");
			}
			if(!scoreMap.containsKey("score_min")) {
				scoreMap.put("score_min", "1");
			}
			right_join_clanse.append(" right join ")
							 .append(" ( select v_no, avg(score) score ")
							 .append(" from v_evaluation ")
							 .append(" group by v_no ")
							 .append(" having avg(score) between ")
							 .append(scoreMap.get("score_min"))
							 .append(" and ")
							 .append(scoreMap.get("score_max"))
							 .append(" ) a ")
							 .append(" on a.v_no = venue.v_no ");
		}else {
			return "";
		}
		return right_join_clanse.toString();
	}
	
	
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
		}else if( "reg_name".equals(columnName) || "reg_dist".equals(columnName)) {
			aCondition = columnName + " like '%"+value+"%' ";
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
		int countSub = 0;
		for(String key:keys) {
			String value = map.get(key)[0];
			if(value != null && value.trim().length() != 0 && !"action".equals(key) 
					&& !"whichPage".equals(key) && !"requestURL".equals(key) && !"hasChangePictiure".equals(key)
					&& !"reg_no".equals(key) && !"score_min".equals(key) && !"score_max".equals(key) 
					) {
				count++;
				
				String aCondition = get_aCondition_For_Oracle(key, value.trim());
//				System.out.println("aCondition : "+aCondition);
				if("reg_name".equals(key) || "reg_dist".equals(key)) {
					// 設定list<String> 收集 reg_name or red_dist
					if(count==1) count--;
					countSub++;
					if(countSub==1)
						initSubAConditionRegion();
					addSubAConditionRegion(aCondition);
				}else {
					if(count==1) {
						whereCondition.append(" where "+aCondition);
					}else {
						whereCondition.append(" and "+aCondition);
					}
				}
//				System.out.println("送出的欄位數"+count);
			}
		}
		if(countSub>0) {
			if(count == 0)
				whereCondition.append(" where ");
			else
				whereCondition.append( " and ");
			
			whereCondition.append(" reg_no in ").append("(select reg_no from region ");
			
			for(int i = 0 ; i < subAConditionRegion.size(); i++) {
				if(i==0) {
					whereCondition.append(" where "+subAConditionRegion.get(i)+" ");
				}else {
					whereCondition.append(" and "+subAConditionRegion.get(i)+" ");
				}
			}
			whereCondition.append(" ) ");
			destorySubAConditionRegion();
		}
		if(isFrontEnd) {
			if(count==0 && countSub ==0) {
				whereCondition.append(" where v_fitall='Y' and v_display='顯示' and open_state in ('免費對外開放使用', '付費對外開放使用') ");
			}else {
				whereCondition.append(" and v_fitall='Y' and v_display='顯示'  and open_state in ('免費對外開放使用', '付費對外開放使用') ");				
			}
		}
		return whereCondition.toString();
	}
	
//	select * from venue where reg_no in
//	(select reg_no from region where reg_name='桃園市' and reg_dist='中壢區')
//	
	private static List<String> subAConditionRegion;
	private static void initSubAConditionRegion() {
		subAConditionRegion = new ArrayList<>();
	}
	private static void addSubAConditionRegion(String aCondition) {
		subAConditionRegion.add(aCondition);
	}
	private static void destorySubAConditionRegion() {
		subAConditionRegion = new ArrayList<>();
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
