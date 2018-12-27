package com.android.sg_like.model;

public class Sg_likeVO_Android implements java.io.Serializable{
	
	private String sg_no;
	private String sg_name;
	private String mem_no;
	private String mem_name;
	
	public Sg_likeVO_Android() {
	}

	public Sg_likeVO_Android(String sg_no, String mem_no) {
		this.sg_no = sg_no;
		this.mem_no = mem_no;
	}

	public String getSg_no() {
		return sg_no;
	}

	public void setSg_no(String sg_no) {
		this.sg_no = sg_no;
	}

	public String getSg_name() {
		return sg_name;
	}

	public void setSg_name(String sg_name) {
		this.sg_name = sg_name;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

}
