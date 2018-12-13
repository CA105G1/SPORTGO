package com.ord.model;

import java.sql.Date;
import java.sql.Timestamp;

public class OrdVO {
	
	private String ord_no;
	private String mem_no;
	private Timestamp ord_date;
	private Timestamp ord_deldate;
	private String ord_status;
	private Timestamp ord_backdeldate;
	private Integer ord_amount;
	private Integer ord_backamount;
	public String getOrd_no() {
		return ord_no;
	}
	public void setOrd_no(String ord_no) {
		this.ord_no = ord_no;
	}
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public Timestamp getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(Timestamp ord_date) {
		this.ord_date = ord_date;
	}
	public Timestamp getOrd_deldate() {
		return ord_deldate;
	}
	public void setOrd_deldate(Timestamp ord_deldate) {
		this.ord_deldate = ord_deldate;
	}
	public String getOrd_status() {
		return ord_status;
	}
	public void setOrd_status(String ord_status) {
		this.ord_status = ord_status;
	}
	public Timestamp getOrd_backdeldate() {
		return ord_backdeldate;
	}
	public void setOrd_backdeldate(Timestamp ord_backdeldate) {
		this.ord_backdeldate = ord_backdeldate;
	}
	public Integer getOrd_amount() {
		return ord_amount;
	}
	public void setOrd_amount(Integer ord_amount) {
		this.ord_amount = ord_amount;
	}
	public Integer getOrd_backamount() {
		return ord_backamount;
	}
	public void setOrd_backamount(Integer ord_backamount) {
		this.ord_backamount = ord_backamount;
	}
	
	
	
	

}
