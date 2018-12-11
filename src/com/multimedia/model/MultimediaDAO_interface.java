package com.multimedia.model;

import java.util.List;

public interface MultimediaDAO_interface {

	public void insert(MultimediaVO multimediaVO);
    public void update(MultimediaVO multimediaVO);
    public void delete(Integer media_no);
    public MultimediaVO findByPrimaryKey(Integer media_no);
    public List<MultimediaVO> getAll();
    public List<MultimediaVO> getMultimediaByDeptno(Integer media_no);
	
}
