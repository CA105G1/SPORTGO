package com.gym.model;

import java.util.List;

public interface GymDAO_interface {
	public void insert(GymVO gymVO);
	public List<Integer> getAllGymID();
	
}
