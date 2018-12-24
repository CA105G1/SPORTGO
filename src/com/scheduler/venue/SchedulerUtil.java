package com.scheduler.venue;

public class SchedulerUtil {
	
	public static String getOpendataVenueURLByRegAndVenueType(String reg_name, String reg_dist,String venueType_name){
		StringBuilder opendataVenueURL = new StringBuilder();
		opendataVenueURL.append("https://iplay.sa.gov.tw/api/GymSearchAllList?$format=application/json;odata.metadata=none")
						.append("&City=").append(reg_name)
						.append("&Country=").append(reg_dist)
						.append("&GymType=").append(venueType_name);
		return opendataVenueURL.toString();
	}
	
}
