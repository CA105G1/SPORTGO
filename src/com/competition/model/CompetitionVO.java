package com.competition.model;

import java.sql.Date;

public class CompetitionVO {

	private String comp_no;
	private String comp_name;
	private Date comp_startdate;
	private Date comp_enddate;
	private String comp_cont;
	
	public CompetitionVO(){
	}

	public String getComp_no() {
		return comp_no;
	}

	public void setComp_no(String comp_no) {
		this.comp_no = comp_no;
	}

	public String getComp_name() {
		return comp_name;
	}

	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}

	public Date getComp_startdate() {
		return comp_startdate;
	}

	public void setComp_startdate(Date comp_startdate) {
		this.comp_startdate = comp_startdate;
	}

	public Date getComp_enddate() {
		return comp_enddate;
	}

	public void setComp_enddate(Date comp_enddate) {
		this.comp_enddate = comp_enddate;
	}

	public String getComp_cont() {
		return comp_cont;
	}

	public void setComp_cont(String comp_cont) {
		this.comp_cont = comp_cont;
	}

	
	
}
