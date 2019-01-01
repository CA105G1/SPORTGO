package com.android.sg_like.model;

import java.util.*;

public interface Sg_likeDAO_interface_android {
	//push like button use insert
	public void insert(Sg_likeVO_android sg_like);
	//push dislike button(may same as like button) use delete
	public void delete(Sg_likeVO_android sg_like);
	//find how much people like this SG
	public List<Sg_likeVO_android> Sg_getAll(String sg_no);
	//find this people like which SGs
	public List<Sg_likeVO_android> Mem_getAll(String mem_no);
}
