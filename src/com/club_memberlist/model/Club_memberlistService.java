package com.club_memberlist.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class Club_memberlistService {

	private Club_memberlistDAO_interface dao;
	
	public Club_memberlistService() {
		dao = new Club_memberlistDAO();
	}
	
	public Club_memberlistVO addClubmemberlist(String cmem_status,String cmem_class,Timestamp silence_time) {
		
		Club_memberlistVO clubmemberlistVO = new Club_memberlistVO();

		
		clubmemberlistVO.setCmem_status(cmem_status);
		clubmemberlistVO.setCmem_class(cmem_class);
		clubmemberlistVO.setSilence_time(silence_time);

		dao.insert(clubmemberlistVO);
		
		return clubmemberlistVO;
	}
	
	public Club_memberlistVO addintoClubmemberlist(String cmem_status,String cmem_class) {
		
		Club_memberlistVO clubmemberlistVO = new Club_memberlistVO();

		
		clubmemberlistVO.setCmem_status(cmem_status);
		clubmemberlistVO.setCmem_class(cmem_class);
		

		dao.insert(clubmemberlistVO);
		
		return clubmemberlistVO;
	}
	
	
	public Club_memberlistVO updateClubmemberlist(String club_no,String mem_no,String cmem_status,String cmem_class,Timestamp silence_time) {
		
		Club_memberlistVO clubmemberlistVO = new Club_memberlistVO();
		
		clubmemberlistVO.setClub_no(club_no);
		clubmemberlistVO.setMem_no(mem_no);
		clubmemberlistVO.setCmem_status(cmem_status);
		clubmemberlistVO.setCmem_class(cmem_class);
		clubmemberlistVO.setSilence_time(silence_time);

		dao.update(clubmemberlistVO);
		
		return clubmemberlistVO;
	}
	
	
	public void updateStatus(String club_no, String mem_no, String cmem_status) {
		dao.updateStatus(club_no, mem_no, cmem_status);
	}
	
	
	public Club_memberlistVO getOneClubmemberlist(String club_no,String mem_no) {
		return dao.findByPrimaryKey(club_no, mem_no);
	}
	
	public List<Club_memberlistVO> getAll(){
		return dao.getAll();
	}
	
	public List<Club_memberlistVO> getByClub(String club_no){
		return dao.findByClub(club_no);
	}
	public List<Club_memberlistVO> getByMem(String mem_no){
		return dao.findByMem(mem_no);
	}
	public List<Club_memberlistVO> getByMemHost(String mem_no){
		return dao.findByMemHost(mem_no);
	}
	public List<Club_memberlistVO> getByMemPart(String mem_no){
		return dao.findByMemPart(mem_no);
	}
	public List<Club_memberlistVO> getByMemPartWait(String mem_no){
		return dao.findByMemPartWait(mem_no);
	}
	
	public List<Club_memberlistVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
	
	


public Club_memberlistVO privilege(String club_no, String mem_no, String cmem_status, String cmem_class) {
	Club_memberlistVO clubmemberlistVO = new Club_memberlistVO();
	
	clubmemberlistVO.setClub_no(club_no);
	clubmemberlistVO.setMem_no(mem_no);
	clubmemberlistVO.setCmem_status(cmem_status);
	clubmemberlistVO.setCmem_class(cmem_class);
	
	dao.update(clubmemberlistVO);
	
	return clubmemberlistVO;
}

public Club_memberlistVO addintoclub(String club_no, String mem_no) {
	Club_memberlistVO clubmemberlistVO = new Club_memberlistVO();
	
	clubmemberlistVO.setClub_no(club_no);
	clubmemberlistVO.setMem_no(mem_no);
	clubmemberlistVO.setCmem_status("待審核");
	clubmemberlistVO.setCmem_class("一般成員");
	dao.insert(clubmemberlistVO);
	
	return clubmemberlistVO;
}

public void dropoutclub(String club_no, String mem_no) {
	dao.delete(club_no, mem_no);
}




}
