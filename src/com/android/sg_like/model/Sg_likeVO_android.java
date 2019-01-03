package com.android.sg_like.model;

public class Sg_likeVO_android implements java.io.Serializable{
	
	private String sg_no;
	private String mem_no;
	
	public Sg_likeVO_android() {
	}

	public Sg_likeVO_android(String sg_no, String mem_no) {
		this.sg_no = sg_no;
		this.mem_no = mem_no;
	}

	public String getSg_no() {
		return sg_no;
	}

	public void setSg_no(String sg_no) {
		this.sg_no = sg_no;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

}
