package com.region.model;

public class RegVO {
	private Integer reg_no;
	private String reg_name;
	
	public RegVO() {
		super();
	}
	
	public RegVO(Integer reg_no, String reg_name) {
		super();
		this.reg_no = reg_no;
		this.reg_name = reg_name;
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
	
}
