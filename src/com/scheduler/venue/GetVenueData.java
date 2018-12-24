package com.scheduler.venue;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.venue.model.VenueDAO_interface;
import com.venue.model.VenueJDBCDAO;
import com.venue.model.VenueVO;
import com.venuetype.model.VenueTypeDAO_interface;
import com.venuetype.model.VenueTypeJDBCDAO;
import com.venuetype.model.VenueTypeVO;

public class GetVenueData {
	
	public static void main(String[] args) throws IOException, JSONException {
		System.out.println(123);
		
		VenueTypeDAO_interface vi  = new VenueTypeJDBCDAO();
		
		List<VenueTypeVO> vtVO = vi.getAll();
		
		for (int i = 0 ; i < vtVO.size(); i++) {
		
			try {
				
				String vt_no = vtVO.get(i).getVt_no();
				String vt_name = vtVO.get(i).getVt_name();

				findVenue(vt_no, vt_name);
				
			} catch (IOException e) {
				e.printStackTrace();
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
	}
	
	
	private static int count = 0;
	
	
	public static void findVenue(String vt_no, String vt_name) throws IOException, JSONException {
		
		String myUrl = "https://iplay.sa.gov.tw/api/GymSearchAllList?"
				+ "$format=application/json;odata.metadata=none&"
				+ "City=桃園市&Country=中壢區&GymType=" + vt_name;
		
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
		
		Set<VenueVO> veSet = new HashSet<VenueVO>();
		
		VenueDAO_interface vi = new VenueJDBCDAO();
		
		for (int i = 0; i < jArray.length(); i++) {
			
			JSONObject data = jArray.getJSONObject(i);
			
			VenueVO vo = new VenueVO();
			
			vo.setV_name(data.getString("Name"));
			vo.setVt_no(vt_no);
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
			
//			veSet.add(vo);
			try {
				vi.insert(vo);
			}catch (RuntimeException e) {
			}
			++count;
			
		}
		
		System.out.println("共 "+ count + " 筆");
		
	}
}
