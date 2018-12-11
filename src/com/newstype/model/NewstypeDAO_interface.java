package com.newstype.model;

import java.util.List;

public interface NewstypeDAO_interface {
	
	public void insert(NewstypeVO newstypeVO);
    public void update(NewstypeVO newstypeVO);
    public void delete(Integer newstype_no);
    public NewstypeVO findByPrimaryKey(Integer newstype_no);
    public List<NewstypeVO> getAll();
    public List<NewstypeVO> getNewstypeByDeptno(Integer newstype_no);
		
}
