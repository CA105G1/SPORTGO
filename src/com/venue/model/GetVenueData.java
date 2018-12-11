package com.venue.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class GetVenueData {
	
	public static void main(String[] args) {
		
		String url = "https://iplay.sa.gov.tw/api/GymSearchAllList?$format=application/json;odata.metadata=none&Keyword=中央&City=桃園市&Country=中壢區&GymType=籃球場";
		
		try {
			findVenue(url);
		} catch (IOException | JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private static int count = 0;
		
	public static void findVenue(String myUrl) throws IOException, JSONException {
		
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
		
		JSONArray jArray = new JSONArray(sb.toString());
		
		for (int i = 0; i < jArray.length(); i++) {
			
			JSONObject data = jArray.getJSONObject(i);
			
			VenueDAO_interface vi = new VenueJDBCDAO();
			
			VenueVO vo = new VenueVO();
			
//			System.out.println("名字= " + data.getString("Name"));
//			System.out.println("電話 = " + data.getString("OperationTel"));
//			System.out.println("地址 = " + data.getString("Address"));
//			System.out.println("圖片 = " + data.getString("Photo1"));
//			String[] Latlng = data.getString("LatLng").split(",");
//			System.out.println("緯度 = " + Latlng[0]);
//			System.out.println("經度 = " + Latlng[1]);
//			System.out.println("開放狀態 = " + data.getString("OpenState"));
//			System.out.println("功能 = " + data.getString("GymFuncList"));
			
			vo.setV_no("V00000" + ++count);
			vo.setV_name(data.getString("Name"));
			vo.setVt_no("VT001");
			vo.setReg_no(320);
			vo.setV_lat(Double.parseDouble(data.getString("LatLng").split(",")[0]));
			vo.setV_long(Double.parseDouble(data.getString("LatLng").split(",")[1]));
			vo.setV_pic(data.getString("Photo1"));
			vo.setV_address(data.getString("Address"));
			vo.setV_phoneno(data.getString("OperationTel"));
			vo.setV_status(data.getString("OpenState"));
			vo.setV_func(data.getString("GymFuncList"));
			
			System.out.println(vo.getV_no());
			System.out.println(vo.getV_name());
			System.out.println(vo.getVt_no());
			System.out.println(vo.getReg_no());
			System.out.println(vo.getV_lat());
			System.out.println(vo.getV_long());
			System.out.println(vo.getV_pic());
			System.out.println(vo.getV_address());
			System.out.println(vo.getV_phoneno());
			System.out.println(vo.getV_status());
			System.out.println(vo.getV_func());
			
			System.out.println("=========================");
			
			vi.insert(vo);
			
		}
		
		System.out.println("共 "+ count + " 筆");
	}
	
//	public static int[] findVenueById(int[] arr) throws IOException, JSONException {
//		
//		for (int i = 0; i < arr.length; i++) {
//		
//			String myUrl = "https://iplay.sa.gov.tw//odata/Gym(" + arr[i] + ")?$format=application/json;odata.metadata=none&$expand=GymFuncData";
//			
//			URL url = new URL(myUrl);
//			HttpURLConnection con = (HttpURLConnection)url.openConnection();
//			con.setRequestMethod("GET");
//			con.setUseCaches(false);
//			con.setConnectTimeout(5000);
//			InputStream is = con.getInputStream();
//			InputStreamReader isr = new InputStreamReader(is);
//			BufferedReader br = new BufferedReader(isr);
//			
//			StringBuilder sb = new StringBuilder();
//			
//			String str;
//			while ((str = br.readLine()) != null) {
//				sb.append(str);
//			}
//			
//			br.close();
//			isr.close();
//			is.close();
//			con.disconnect();
//
//				JSONObject data = new JSONObject(sb.toString());
//				
//				System.out.println("名字= " + data.getString("Name"));
//				System.out.println("電話 = " + data.getString("OperationTel"));
//				System.out.println("地址 = " + data.getString("Addr"));
//				System.out.println("網址 = " + data.getString("WebUrl"));
//				System.out.println("緯度 = " + data.getDouble("Lat"));
//				System.out.println("緯度 = " + data.getDouble("Lng"));
//				System.out.println("圖片 = " + data.getString("Photo1Url"));
//				System.out.println("簡介 = " + data.getString("Introduction"));
//				System.out.println("======================" + ++count);
//			
//		}
//		
//		return arr;
//	}

}


//System.out.println("名字= " + data.getString("Name"));
//System.out.println("電話 = " + data.getString("OperationTel"));
//System.out.println("地址 = " + data.getString("Address"));
//System.out.println("圖片 = " + data.getString("Photo1"));
//String[] Latlng = data.getString("LatLng").split(",");
//System.out.println("緯度 = " + Latlng[0]);
//System.out.println("經度 = " + Latlng[1]);
////System.out.println("經度 = " + data.getDouble("long"));
//System.out.println("開放狀態 = " + data.getString("OpenState"));
//System.out.println("功能 = " + data.getString("GymFuncList"));
