package com.sg_info.model;

import java.util.*;

public interface Sg_infoDAO_interface {
	public void insert(Sg_infoVO sg_infoVO);
	public void update(Sg_infoVO sg_infoVO);
	public void delete(String sg_no);
	public Sg_infoVO findByPk(String sg_no);
	public List<Sg_infoVO> getAll();
	public List<Sg_infoVO> getAllForPublic();
//	public List<Sg_infoVO> getAllForGroup();
	//複合式查詢
	public List<Sg_infoVO> getAll(Map<String, String[]> map);
	//狀態變更
	public void updateStatus(String sg_no, String sg_status);
	//報名人數變更
	public void updateTtlapl(String sg_no, String sg_ttlapl);
}
