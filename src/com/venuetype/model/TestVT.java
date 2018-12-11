package com.venuetype.model;

import java.util.List;

public class TestVT {
	
	public static void main(String[] args) {
		
		VenueTypeDAO_interface vi  = new VenueTypeJDBCDAO();
		
//		vi.insert(new VenueTypeVO("VT016","籃球"));
//		vi.insert(new VenueTypeVO("VT017","網球"));
//		vi.update(new VenueTypeVO("VT018","棒球"));
//		for (int i = 1; i < 10; i++) {
//			vi.delete("VT00" + i);			
//		}
		
//		
//		VenueTypeVO vt = vi.findByPrimaryKey("VT001");
//		System.out.println(vt.getVt_name());
//		
//		System.out.println("========================");
		
		List<VenueTypeVO> vTVO = vi.getAll();
		
		for (VenueTypeVO x : vTVO) {
			System.out.println(x.getVt_no() + " " + x.getVt_name());
		}
		
	}

}
