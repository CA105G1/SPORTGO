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

public class ImportRegByMainJDBC {
	
	public static void main(String[] args) throws FileNotFoundException, JSONException {
		
//		int count = 0;
		
		
        BufferedReader br = new BufferedReader(new FileReader("WebContent\\postcode2ver.json"));
		
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
		/////sb為josn字串
		///for postcode2vr.json
		RegDAO_interface regDAO = new RegJDBCDAO();
		int countDistrict = 0;
		JSONObject jObject = new JSONObject(sb.toString());
		JSONArray data = jObject.getJSONArray("data");
		for(int i = 0 ; i<data.length(); i++) {
			if(i%15==0) {
				try {
					Thread.sleep(500);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			JSONObject jReg = data.getJSONObject(i);
			RegVO regVO = new RegVO();
			regVO.setReg_no(Integer.valueOf(jReg.getString("zip_code")));
			System.out.println("第"+(countDistrict+1)+"筆的reg_no : "+regVO.getReg_no());
			regVO.setReg_name(jReg.getString("city"));
			regVO.setReg_dist(jReg.getString("district"));
				
			regDAO.insert(regVO);
			countDistrict++;
			System.out.println("第"+countDistrict+"筆完成輸入");

		}
		System.out.println("全部完成，總共"+countDistrict+"筆資料");
		
		
		
//		/////for postcode.json
//		JSONArray jArray = new JSONArray(sb.toString());
//		for (int i = 0; i < jArray.length(); i++) {
//			count++;
//			JSONObject reg = jArray.getJSONObject(i);
//			
//			JSONArray  dist = reg.getJSONArray("districts");
//			
//			for (int j = 0; j < dist.length(); j++) {
//				RegVO ro = new RegVO();
//				
//				ro.setReg_name(reg.getString("name"));
//				ro.setReg_no(dist.getJSONObject(j).getInt("zip"));
//				ro.setReg_dist(dist.getJSONObject(j).getString("name"));
//				try{
//					ri.insert(ro);
//				}catch (RuntimeException e) {
//					
//				}
//			}	
//		}
//		System.out.println(count);
	}

}
