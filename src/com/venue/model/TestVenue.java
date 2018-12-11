package com.venue.model;


public class TestVenue {
	
	public static void main(String[] args) {
		
		VenueDAO_interface vi = new VenueJDBCDAO();
		
		VenueVO vo = vi.findByPrimaryKey("V000003");
		
		System.out.println(vo.getV_name() + vo.getV_address());
		
	}
	
}
