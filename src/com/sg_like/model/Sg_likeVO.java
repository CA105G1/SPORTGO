package com.sg_like.model;

public class Sg_likeVO implements java.io.Serializable{

	
	private static final long serialVersionUID = 1L;
	private String sg_no;
	private String mem_no;
	
	public Sg_likeVO() {
	}

	public Sg_likeVO(String sg_no, String mem_no) {
		setSg_no(sg_no);
		setMem_no(mem_no);
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
