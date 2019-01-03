package com.android.sg_like.model;

import java.util.*;

public interface Sg_likeDAO_interface_android {
	
	public void insert(Sg_likeVO_android sg_like);
	public void delete(Sg_likeVO_android sg_like);
	public List<Sg_likeVO_android> findBySg(String sg_no);
	public List<Sg_likeVO_android> findByMem(String mem_no);
}
