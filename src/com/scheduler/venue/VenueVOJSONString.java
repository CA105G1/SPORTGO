package com.scheduler.venue;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.Callable;

public class VenueVOJSONString implements Callable<String>{
	
	private Integer gym_id;
	
	public VenueVOJSONString(Integer gym_id){
		this.gym_id = gym_id;
	}
	
	@Override
	public String call() throws Exception {
		return this.getVenueSetJSONStringByUrl();
	}

	private static int jjj = 0;
	
	public String getVenueSetJSONStringByUrl(){
		System.out.println("------------- 第"+(++jjj)+"筆資料解析------------");
		String myURLString = getURLAboutVenueByGymID(gym_id);
		URL url;
		HttpURLConnection connection = null;
		InputStream inputStream = null;
		InputStreamReader inputStreamReader = null;
		BufferedReader bufferedReader = null;
		StringBuffer stringBuffer = new StringBuffer();
		try {
			url = new URL(myURLString);
			connection = (HttpURLConnection)url.openConnection();
			connection.setRequestMethod("GET");
			connection.setUseCaches(false);
			connection.setConnectTimeout(5000);
		
			inputStream = connection.getInputStream();
			inputStreamReader = new InputStreamReader(inputStream);
			bufferedReader = new BufferedReader(inputStreamReader);
			
			String string;
			while((string = bufferedReader.readLine())!=null) {
				stringBuffer.append(string);
			}
			
		}catch (MalformedURLException e1) {
			e1.printStackTrace();
		}catch (IOException e) {
			e.printStackTrace();
		}finally {
			if(bufferedReader!=null) {
				try {
					bufferedReader.close();
				}catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(inputStreamReader!=null) {
				try {
					inputStreamReader.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(inputStream!=null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				connection.disconnect();
			}
		}
		return stringBuffer.toString();
		
	}
	
	private String getURLAboutVenueByGymID(Integer gym_id) {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("https://iplay.sa.gov.tw//odata/Gym(");
		stringBuffer.append(gym_id.toString());
		stringBuffer.append(")?$format=application/json;odata.metadata=none&$expand=GymFuncData");
		return stringBuffer.toString().trim();
	}
}
