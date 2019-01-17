package com.multimedia.model;

import java.util.List;

public class MultimediaService {
	private MultimediaDAO_interface multimediaDAO;
	
	public MultimediaService(){
		this.multimediaDAO = new MultimediaDAO();
	}
	
	public void insert(MultimediaVO multimediaVO) {
		multimediaDAO.insert(multimediaVO);
	}
    public void update(MultimediaVO multimediaVO) {
    	multimediaDAO.update(multimediaVO);
    }
    public void delete(String media_no) {
    	multimediaDAO.delete(media_no);
    }
    public MultimediaVO findByPrimaryKey(String media_no) {
    	return multimediaDAO.findByPrimaryKey(media_no);
    }
    public List<MultimediaVO> getAllMediaInClub(String club_no){
    	return multimediaDAO.getAllMediaInClub(club_no);
    }
    public List<MultimediaVO> getAllMediaInClubByTitle(String club_no,String media_title){
    	return multimediaDAO.getAllMediaInClubByTitle(club_no, media_title);
    }
	
}
