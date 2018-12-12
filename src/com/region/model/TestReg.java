package com.region.model;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class TestReg {
	
	public static void main(String[] args) throws FileNotFoundException, JSONException {
		
		int count = 0;
		
		RegDAO_interface ri = new RegJDBCDAO();
		
        BufferedReader br = new BufferedReader(new FileReader("src\\DB\\postcode.json"));
		
		StringBuilder sb = new StringBuilder();
		
		String str;
		
		try {
			while ((str = br.readLine()) != null) {
				sb.append(str);
			}
			br.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		JSONArray jArray = new JSONArray(sb.toString());
		
		for (int i = 0; i < jArray.length(); i++) {
			
			JSONObject reg = jArray.getJSONObject(i);
			
			JSONArray  dist = reg.getJSONArray("districts");
			
			for (int j = 0; j < dist.length(); j++) {
				
				RegVO ro = new RegVO();
				
				ro.setReg_name(reg.getString("name"));
				ro.setReg_no(dist.getJSONObject(j).getInt("zip"));
				ro.setReg_dist(dist.getJSONObject(j).getString("name"));
				
				ri.insert(ro);
				
			}	
		}
		System.out.println(++count);
	}

}
