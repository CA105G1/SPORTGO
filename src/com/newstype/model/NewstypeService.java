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
	
	public NewstypeVO getOneNewsType(String newstype_no) {
		return this.newstypeDAO.findByPrimaryKey(newstype_no);
	}
	
	
}
