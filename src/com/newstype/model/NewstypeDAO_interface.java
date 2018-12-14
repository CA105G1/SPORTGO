package com.newstype.model;

import java.util.List;

public interface NewstypeDAO_interface {
	
	public void insert(NewstypeVO newstypeVO);
    public void update(NewstypeVO newstypeVO);
    public void delete(String newstype_no);
    public NewstypeVO findByPrimaryKey(String newstype_no);
    public List<NewstypeVO> getAll();
		
}
