package com.orddetails.model;

import java.util.List;

public class OrddetailsService {
	
	private Orddetails_interface orddetailsDAO;
	
	public OrddetailsService() {
		super();
		orddetailsDAO = new OrddetailsJDBCDAO();
	}
	
	public List<OrddetailsVO> getOneOrd (String ord_no){
		return orddetailsDAO.findByPK(ord_no);
	}
	
	public List<OrddetailsVO> getAll (){
		return orddetailsDAO.getAll();
	}
	
//	public Ord

}
