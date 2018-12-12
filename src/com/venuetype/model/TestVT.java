package com.venuetype.model;

import java.util.List;

import org.json.JSONObject;

public class TestVT {
	
	public static void main(String[] args) {
		
		VenueTypeDAO_interface vi  = new VenueTypeJDBCDAO();
	
//		
//		VenueTypeVO vt = vi.findByPrimaryKey("VT001");
//		System.out.println(vt.getVt_name());
//		
//		System.out.println("========================");
		
		List<VenueTypeVO> vtVO = vi.getAll();
		
		
		for (VenueTypeVO x : vtVO) {
			System.out.println(x.getVt_no() + " " + x.getVt_name());
		}
		
	}

}
