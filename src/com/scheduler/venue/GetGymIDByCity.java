package com.scheduler.venue;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.gym.model.GymVO;

public class GetGymIDByCity {
	private static int stepCount = 0;
	public static Set<Integer> getGymIdByCity(String city){
		
		System.out.println("-------"+(++stepCount)+"-------"); // 1
		Set<Integer> linkedHashSet = new LinkedHashSet<>();
		
		List<String> gymJSONStringList = new ArrayList<>();
		try {
			String str1 = getGymSetJSONStringByUrl(city,"籃球場");
			gymJSONStringList.add(str1);
			System.out.println(str1);
			System.out.println(city+", 籃球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl(city,"排球場"));
			System.out.println(city+", 排球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl(city,"網球場"));
			System.out.println(city+", 網球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl(city,"棒球場"));
			System.out.println(city+", 棒球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl(city,"羽球場"));
			System.out.println(city+", 羽球場 is done");
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(gymJSONStringList.size()!=5) {
			System.out.println("size is not 5");
			System.out.println("gymJSONStringList.size() : "+gymJSONStringList.size());
			return linkedHashSet;
		}else {
			System.out.println("gymJSONStringList.size() : "+gymJSONStringList.size());
		}
		System.out.println("-------"+(++stepCount)+"-------"); // 2
		/// refine JSONString to get Gym id and collection by HashMap
		try {
			for(int i = 0; i<gymJSONStringList.size(); i++) {
				System.out.println("_______________");

				System.out.println(gymJSONStringList.get(i));
				
				System.out.println("_______________");

				JSONArray jArray = new JSONArray(gymJSONStringList.get(i));
				for(int j = 0; j<jArray.length();j++) {
					JSONObject data = jArray.getJSONObject(j);
					linkedHashSet.add(data.getInt("GymID"));
				}
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return linkedHashSet;
	}
	
	
	public static String getGymSetJSONStringByUrl(String city,String vt_name) throws IOException{
		String myUrl = "https://iplay.sa.gov.tw/api/GymSearchAllList?"
				+ "$format=application/json;odata.metadata=none&"
				+ "city="+city +"&"
				+ "GymType="+vt_name;
		
		URL url = new URL(myUrl);
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
		con.setRequestMethod("GET");
		con.setUseCaches(false);
		con.setConnectTimeout(5000);
		InputStream is = con.getInputStream();
		InputStreamReader isr = new InputStreamReader(is);
		BufferedReader br = new BufferedReader(isr);
		
		StringBuilder sb = new StringBuilder();
		
		String str;
		while ((str = br.readLine()) != null) {
			sb.append(str);
		}
		
		br.close();
		isr.close();
		is.close();
		con.disconnect();		
		return sb.toString();
		
//		String myUrl = "https://iplay.sa.gov.tw/api/GymSearchAllList?"
//				+ "$format=application/json;odata.metadata=none&"
//				+ "city="+city +"&"
//				+ "GymType="+vt_name;
////		https://iplay.sa.gov.tw/odata/GymSearch?$format=application/json;odata.metadata=none&City=桃園市&GymType=羽球場
//		
//		// 以HttpsUtil工具類別建立URLConnection物件
//		URLConnection urlConn;
//		InputStream is = null;
//		try {
//			urlConn = HttpsUtil.getURLConnection(myUrl);
//		
//	    // 以下模擬瀏覽器的user-agent請求標頭(Servlet講義p79-範例HeaderSnoop.java ; 或講義p185-範例EL10.jsp)
//		urlConn.setRequestProperty("user-agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko");
//		// 以URLConnection物件取得輸入資料流
//		urlConn.connect();
//		
//		is = urlConn.getInputStream();
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		InputStreamReader isr = new InputStreamReader(is);
//		BufferedReader br = new BufferedReader(isr);
//		
//		StringBuilder sb = new StringBuilder();
//		
//		String str;
//		while ((str = br.readLine()) != null) {
//			sb.append(str);
//		}
//		
//		br.close();
//		isr.close();
//		is.close();
//		//urlConn.disconnect();		
//		
//		return sb.toString();
	}
	
	
	
	
	
}



