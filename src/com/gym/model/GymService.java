package com.gym.model;

import java.util.List;

public class GymService {
	private GymDAO_interface gymDAO;
	public GymService() {
		gymDAO = new GymDAO();
	}
	public void insert(GymVO gymVO) {
		gymDAO.insert(gymVO);
	}
	
	public List<Integer> getAllGymID(){
		return gymDAO.getAllGymID();
	}
	
}
