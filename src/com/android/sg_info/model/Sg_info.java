package com.android.sg_info.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class Sg_info extends Sg_infoVO_android implements Serializable{

	//Join後得到的欄位
	private String mem_name;
	private String sp_name;
	private String club_name;
	private String v_name;
	private Double v_lat;
	private Double v_long;
	private String rep_status;
	
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
	
	public String getClub_name() {
		return club_name;
	}

	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}


	public Double getV_lat() {
		return v_lat;
	}

	public void setV_lat(Double v_lat) {
		this.v_lat = v_lat;
	}

	public Double getV_long() {
		return v_long;
	}

	public void setV_long(Double v_long) {
		this.v_long = v_long;
	}

	public String getRep_status() {
		return rep_status;
	}

	public void setRep_status(String rep_status) {
		this.rep_status = rep_status;
	}	
	
}
