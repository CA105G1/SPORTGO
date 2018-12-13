package com.promotion.model;

import java.sql.Date;
import java.sql.Timestamp;

public class PromotionVO {
	
	private String prom_project_id;
	private String prom_project_name;
	private Timestamp prom_project_sdate;
	private Timestamp prom_project_edate;
	public String getProm_project_id() {
		return prom_project_id;
	}
	public void setProm_project_id(String prom_project_id) {
		this.prom_project_id = prom_project_id;
	}
	public String getProm_project_name() {
		return prom_project_name;
	}
	public void setProm_project_name(String prom_project_name) {
		this.prom_project_name = prom_project_name;
	}
	public Timestamp getProm_project_sdate() {
		return prom_project_sdate;
	}
	public void setProm_project_sdate(Timestamp prom_project_sdate) {
		this.prom_project_sdate = prom_project_sdate;
	}
	public Timestamp getProm_project_edate() {
		return prom_project_edate;
	}
	public void setProm_project_edate(Timestamp prom_project_edate) {
		this.prom_project_edate = prom_project_edate;
	}
	
	
	
	

}
