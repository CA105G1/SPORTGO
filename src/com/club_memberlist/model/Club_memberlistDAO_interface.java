package com.club_memberlist.model;

import java.util.List;
import java.util.Map;

import com.club.model.ClubVO;

public interface Club_memberlistDAO_interface {
	public void insert(Club_memberlistVO clubmemberlistVO);
    public void update(Club_memberlistVO clubmemberlistVO);
//    public void delete(String club_no,String mem_no);
    public Club_memberlistVO findByPrimaryKey(String club_no,String mem_no);
    public List<Club_memberlistVO> findByMem(String mem_no);
    public List<Club_memberlistVO> findByMemHost(String mem_no);
    public List<Club_memberlistVO> findByMemPart(String mem_no);
    public List<Club_memberlistVO> findByMemPartWait(String mem_no);
    public List<Club_memberlistVO> getAll();
    public List<Club_memberlistVO> getAll(Map<String, String[]> map);
    public void delete(String club_no, String mem_no);
	
}
