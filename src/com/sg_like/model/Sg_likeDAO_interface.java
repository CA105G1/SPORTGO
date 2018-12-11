package com.sg_like.model;

import java.util.*;

public interface Sg_likeDAO_interface {
	//push like button use insert
	public void insert(Sg_likeVO sg_like);
	//push dislike button(may same as like button) use delete
	public void delete(Sg_likeVO sg_like);
	//find how much people like this SG
	public List<Sg_likeVO> Sg_getAll(String sg_no);
	//find this people like which SGs
	public List<Sg_likeVO> Mem_getAll(String mem_no);
}
