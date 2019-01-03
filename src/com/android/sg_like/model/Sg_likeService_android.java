package com.android.sg_like.model;

import java.util.List;

public class Sg_likeService_android {
	
	private Sg_likeDAO_interface_android dao;
	
	public Sg_likeService_android() {
		dao = new Sg_likeDAO_android();
	}
	
	public void like(Sg_likeVO_android sg_like) {
		dao.insert(sg_like);
	}
	
	public void dislike(Sg_likeVO_android sg_like) {
		dao.delete(sg_like);
	}
	
	public List<Sg_likeVO_android> findBySg(String sg_no) {
		return dao.findBySg(sg_no);
	}
	
	public List<Sg_likeVO_android> findByMem(String mem_no) {
		return dao.findByMem(mem_no);
	}
}
