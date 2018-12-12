package com.region.model;

public class RegVO {
	private Integer reg_no;
	private String reg_name;
	private String reg_dist;
	
	public RegVO() {
		super();
	}
	
	public RegVO(Integer reg_no, String reg_name, String reg_dist) {
		super();
		this.reg_no = reg_no;
		this.reg_name = reg_name;
		this.reg_dist = reg_dist;
	}
	
	public Integer getReg_no() {
		return reg_no;
	}
	public void setReg_no(Integer reg_no) {
		this.reg_no = reg_no;
	}
	public String getReg_name() {
		return reg_name;
	}
	public void setReg_name(String reg_name) {
		this.reg_name = reg_name;
	}

	public String getReg_dist() {
		return reg_dist;
	}

	public void setReg_dist(String reg_dist) {
		this.reg_dist = reg_dist;
	}	
	
}
