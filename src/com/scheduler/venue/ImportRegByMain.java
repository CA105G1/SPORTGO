package com.scheduler.venue;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.region.model.RegDAO_interface;
import com.region.model.RegJDBCDAO;
import com.region.model.RegVO;

public class ImportRegByMain {
	
	public static void main(String[] args) throws FileNotFoundException, JSONException {
		
		int count = 0;
		
		RegDAO_interface ri = new RegJDBCDAO();
		
        BufferedReader br = new BufferedReader(new FileReader("C:\\CA105_Han_note_workspace\\CA105G1_han_project\\WebContent\\postcode.json"));
		
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
			count++;
			JSONObject reg = jArray.getJSONObject(i);
			
			JSONArray  dist = reg.getJSONArray("districts");
			
			for (int j = 0; j < dist.length(); j++) {
				RegVO ro = new RegVO();
				
				ro.setReg_name(reg.getString("name"));
				ro.setReg_no(dist.getJSONObject(j).getInt("zip"));
				ro.setReg_dist(dist.getJSONObject(j).getString("name"));
				try{
					ri.insert(ro);
				}catch (RuntimeException e) {
					
				}
			}	
		}
		System.out.println(count);
	}

}
