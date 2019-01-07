package com.newstype.model;

import java.util.List;

public class NewstypeService {
	private NewstypeDAO_interface newstypeDAO;
	
	public NewstypeService() {
		this.newstypeDAO = new NewstypeDAO();
	}
	
	public List<NewstypeVO> getAll(){
		return this.newstypeDAO.getAll();
	}
	
}
