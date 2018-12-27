package com.scheduler.venue;

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

import com.gym.model.GymDAO_interface;
import com.gym.model.GymJDBCDAO;
import com.gym.model.GymVO;

public class GetGymIDJDBC {
	
	private static int stepCount = 0;
	private static int gymCount = 0;
	private static int inputDBCount = 0;
	private static int gymCountInfactCapture = 0;
	private static int inputDBCountInfactWantToDo = 0;
	
	public static void main(String[] args) {
		System.out.println("-------"+(++stepCount)+"-------"); // 1
		List<String> gymJSONStringList = new ArrayList<>();
		//// get json array string list
		try {
			gymJSONStringList.add(getGymSetJSONStringByUrl("籃球場"));
			System.out.println("籃球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl("排球場"));
			System.out.println("排球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl("網球場"));
			System.out.println("網球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl("棒球場"));
			System.out.println("棒球場 is done");
			gymJSONStringList.add(getGymSetJSONStringByUrl("羽球場"));
			System.out.println("羽球場 is done");
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(gymJSONStringList.size()!=5) {
			System.out.println("size is not 5");
			System.out.println("gymJSONStringList.size() : "+gymJSONStringList.size());
			return;
		}
		///////
		System.out.println("-------"+(++stepCount)+"-------"); // 2
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
		System.out.println("-------"+(++stepCount)+"-------"); // 3
		////// use gymVO input data into DB
		
		Collection<GymVO> gymVOCollection = gymVOCollectionMap.values(); 
		int iii = 0;
		for(GymVO gymVO : gymVOCollection) {
			if(iii%20==0) {
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			iii++;
			useGymVOInputDB(gymVO);
		}
		
		System.out.println("-------"+(++stepCount)+"-------END"); //4
	}
	
	public static String getGymSetJSONStringByUrl(String vt_name) throws IOException{

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
			System.out.println("+++希望加入第"+(++gymCountInfactCapture)+"筆物件GymVO+++++--------------------");
			JSONObject data = jArray.getJSONObject(i);
			GymVO gymVO = new GymVO();
			
			gymVO.setGym_id(data.getInt("GymID"));
			gymVO.setGym_name(data.getString("Name"));
			gymVO.setGym_funclist(data.getString("GymFuncList"));
			
			gymVOCollectionMap.put(gymVO.getGym_id(), gymVO);
			System.out.println("+++成功加入第"+(++gymCount)+"筆物件GymVO+++++");
		}
		
		
	}
	public static void useGymVOInputDB(GymVO gymVO) {
//		GymService gymService = new GymService();
		System.out.println("--------希望輸入DB第"+(++inputDBCountInfactWantToDo)+"筆-------");
		GymDAO_interface gymDAO = new GymJDBCDAO();
		gymDAO.insert(gymVO);
		System.out.println("--------成功輸入DB第"+(++inputDBCount)+"筆-------");
	}
	
	
	
}
