package com.gym.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GetGymID {
	
	public static void main(String[] args) {
		
		List<String> gymJSONStringList = new ArrayList<>();
		//// get json array string list
		try {
			gymJSONStringList.add(getGymSetJSONStringByUrl("籃球場"));
			gymJSONStringList.add(getGymSetJSONStringByUrl("排球場"));
			gymJSONStringList.add(getGymSetJSONStringByUrl("網球場"));
			gymJSONStringList.add(getGymSetJSONStringByUrl("棒球場"));
			gymJSONStringList.add(getGymSetJSONStringByUrl("羽球場"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(gymJSONStringList.size()!=5) {
			System.out.println("size is not 5");
			System.out.println("gymJSONStringList.size() : "+gymJSONStringList.size());
			return;
		}
		///////
		//////collection gymVO by hashMap
		Map<Integer, GymVO> gymVOCollectionMap = new HashMap<>();
		try {
			for(String gymJSONString : gymJSONStringList) {
				collectAndTransJSONStringToGymVO(gymJSONString,gymVOCollectionMap);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		///////
		////// use gymVO input data into DB
		
		Collection<GymVO> gymVOCollection = gymVOCollectionMap.values(); 
		for(GymVO gymVO : gymVOCollection) {
			useGymVOInputDB(gymVO);
		}
	}
	
	public static String getGymSetJSONStringByUrl(String vt_name) throws IOException{
		List<String> gymJSON = new ArrayList<>();
		
		String myUrl = "https://iplay.sa.gov.tw/api/GymSearchAllList?"
				+ "$format=application/json;odata.metadata=none&"
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
	}
	
	
	public static void collectAndTransJSONStringToGymVO(String gymJSONString , Map<Integer, GymVO> gymVOCollectionMap) throws JSONException{
		
		JSONArray jArray = new JSONArray(gymJSONString);
		for(int i = 0 ; i < jArray.length() ; i++ ) {
			JSONObject data = jArray.getJSONObject(i);
			GymVO gymVO = new GymVO();
			
			gymVO.setGym_id(data.getInt("GymID"));
			gymVO.setGym_name(data.getString("Name"));
			gymVO.setGym_funclist(data.getString("GymFuncList"));
			
			gymVOCollectionMap.put(gymVO.getGym_id(), gymVO);
		}
		
		
	}
	
	public static void useGymVOInputDB(GymVO gymVO) {
		GymService gymService = new GymService();
		gymService.insert(gymVO);
	}
	
	
	
}
