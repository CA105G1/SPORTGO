package com.android.sg_info.model;

import java.util.*;

public interface Sg_infoDAO_interface_android {
	public void insert(Sg_infoVO_android sgInfo);
	public void update(Sg_infoVO_android sgInfo);
	public void updateNumber(String sg_no, int num);
	public void cancel(String sg_no);
	public Sg_info findByPK(String sg_no);
	public List<Sg_info> findByMem(String mem_no);
	public List<Sg_info> findByMaster(String mem_no);
	public List<Sg_info> findBySp(String sp_no);
	public List<Sg_info> findByLike(String mem_no);
	public List<Sg_info> findByHistory(String mem_no);
	public List<Sg_info> findBySearch(String mem_name, String venue, String start, String end);
	public List<Sg_info> getAll();
	public byte[] getImage(String sg_no);
}
