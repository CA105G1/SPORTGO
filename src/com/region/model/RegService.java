package com.region.model;

import java.util.List;

public class RegService {
	private RegDAO_interface regDAO = null;
	
	public RegService() {
		this.regDAO = new RegDAO();
	}
	
	public List<RegVO> getAll(){
		return regDAO.getAll();
	}
	
	public RegVO getRegVOFromAddress(String address) {
		return regDAO.getRegVOFromAddress(address);
	}

}
