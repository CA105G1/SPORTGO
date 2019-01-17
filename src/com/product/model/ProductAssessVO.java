package com.product.model;

public class ProductAssessVO {
	
	private String pro_no;
	private Integer pro_trunc_assess;
	private byte[] pro_pic;
	private Integer pro_bonus;
	
	public ProductAssessVO() {
		super();
	}
	public String getPro_no() {
		return pro_no;
	}
	public void setPro_no(String pro_no) {
		this.pro_no = pro_no;
	}
	public Integer getPro_trunc_assess() {
		return pro_trunc_assess;
	}
	public void setPro_trunc_assess(Integer pro_trunc_assess) {
		this.pro_trunc_assess = pro_trunc_assess;
	}
	public byte[] getPro_pic() {
		return pro_pic;
	}
	public void setPro_pic(byte[] pro_pic) {
		this.pro_pic = pro_pic;
	}
	public Integer getPro_bonus() {
		return pro_bonus;
	}
	public void setPro_bonus(Integer pro_bonus) {
		this.pro_bonus = pro_bonus;
	}
	
    
}
