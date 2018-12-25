package com.scheduler.venue;

import com.venue.model.VenueDAO_interface;
import com.venue.model.VenueJDBCDAO;

public class ReadVenueDataToAFileNoPic {

	public static void main(String[] args) {
		VenueDAO_interface venueDAO = new VenueJDBCDAO();
		venueDAO.getAll();
		
		
		
		
		
		
	}
	
	
	
}
