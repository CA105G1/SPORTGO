package com.product.model;
import java.sql.Date;

public class ProductVO implements java.io.Serializable{
	private String pro_no;
	private String pro_classid;
	private String pro_name;
	private byte[] pro_pic;
	private String pro_pic_ext;
	private String pro_format;
	private Integer pro_bonus;
	private Integer pro_stock;
	private Integer pro_safestock;
	private String pro_details;
	private String pro_shelve;
	private Integer pro_all_assess;
	private Integer pro_all_assessman;
	
	
	
	public String getPro_no() {
		return pro_no;
	}
	public void setPro_no(String pro_no) {
		this.pro_no = pro_no;
	}
	public String getPro_classid() {
		return pro_classid;
	}
	public void setPro_classid(String pro_classid) {
		this.pro_classid = pro_classid;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	
	public byte[] getPro_pic() {
		return pro_pic;
	}
	public void setPro_pic(byte[] pro_pic) {
		this.pro_pic = pro_pic;
	}
	public String getPro_pic_ext() {
		return pro_pic_ext;
	}
	public void setPro_pic_ext(String pro_pic_ext) {
		this.pro_pic_ext = pro_pic_ext;
	}
	public String getPro_format() {
		return pro_format;
	}
	public void setPro_format(String pro_format) {
		this.pro_format = pro_format;
	}
	public Integer getPro_bonus() {
		return pro_bonus;
	}
	public void setPro_bonus(Integer pro_bonus) {
		this.pro_bonus = pro_bonus;
	}
	public Integer getPro_stock() {
		return pro_stock;
	}
	public void setPro_stock(Integer pro_stock) {
		this.pro_stock = pro_stock;
	}
	public Integer getPro_safestock() {
		return pro_safestock;
	}
	public void setPro_safestock(Integer pro_safestock) {
		this.pro_safestock = pro_safestock;
	}
	public String getPro_details() {
		return pro_details;
	}
	public void setPro_details(String pro_details) {
		this.pro_details = pro_details;
	}
	public String getPro_shelve() {
		return pro_shelve;
	}
	public void setPro_shelve(String pro_shelve) {
		this.pro_shelve = pro_shelve;
	}
	public Integer getPro_all_assess() {
		return pro_all_assess;
	}
	public void setPro_all_assess(Integer pro_all_assess) {
		this.pro_all_assess = pro_all_assess;
	}
	public Integer getPro_all_assessman() {
		return pro_all_assessman;
	}
	public void setPro_all_assessman(Integer pro_all_assessman) {
		this.pro_all_assessman = pro_all_assessman;
	}
	
	
	

}
