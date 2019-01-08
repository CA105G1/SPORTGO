package com.news.model;

import java.util.List;
import java.util.Map;

public class Util_Check_News_Parameter {
	
	public static Map<String, String[]> checkNewsMap(Map<String, String[]> map, List<String> errorMsgs) {
		map = checkNewsNews_no(map, errorMsgs);
		map = checkNewsNewstype_no(map, errorMsgs);
		return map;
	}
	public static Map<String, String[]> checkNewsNews_no(Map<String, String[]> map, List<String> errorMsgs) {
		String key_news_no = "news_no";
		if(map.containsKey(key_news_no)) {
			String news_no = map.get(key_news_no)[0];
			String news_noReg = "^[N][0-9]{3}$";
			if(news_no == null || news_no.trim().length()==0) {
				//map.remove(key_v_no);
			}else if(!news_no.trim().matches(news_noReg)) {
				errorMsgs.add("查無此編號---消息編號，格式不符，如:N001");
				map.remove(key_news_no);
			}
		}
		return map;
	}
	public static Map<String, String[]> checkNewsNewstype_no(Map<String, String[]> map, List<String> errorMsgs) {
		String key_newstype_no = "newstype_no";
		if(map.containsKey(key_newstype_no)) {
			String newstype_no = map.get(key_newstype_no)[0];
			String newstype_noReg = "^[NT][0-9]{3}$";
			if(newstype_no == null || newstype_no.trim().length()==0) {
				//map.remove(key_v_no);
			}else if(!newstype_no.trim().matches(newstype_noReg)) {
				errorMsgs.add("查無此編號---消息編號，格式不符，如:NT001");
				map.remove(key_newstype_no);
			}
		}
		return map;
	}
	
	
}
