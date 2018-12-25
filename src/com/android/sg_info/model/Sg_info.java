package com.android.sg_info.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Sg_info extends Sg_infoVO_Android implements Serializable{

	//Join後得到的欄位
	private String mem_name;
	private String sp_name;
	private String v_name;
	
	public Sg_info() {
		
	}
	
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getSp_name() {
		return sp_name;
	}
	public void setSp_name(String sp_name) {
		this.sp_name = sp_name;
	}
	public String getV_name() {
		return v_name;
	}
	public void setV_name(String v_name) {
		this.v_name = v_name;
	}
	
}
