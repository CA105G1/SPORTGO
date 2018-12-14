package com.multimedia.model;

import java.util.List;

public interface MultimediaDAO_interface {

	public void insert(MultimediaVO multimediaVO);
    public void update(MultimediaVO multimediaVO);
    public void delete(String media_no);
    public MultimediaVO findByPrimaryKey(String media_no);
    public List<MultimediaVO> getAllMediaInClub(String club_no);
    public List<MultimediaVO> getAllMediaInClubByTitle(String club_no,String media_title);
	
}
