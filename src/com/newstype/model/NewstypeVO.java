package com.newstype.model;

import java.io.Serializable;

public class NewstypeVO implements Serializable{
	private static final long serialVersionUID = 1175869383665511154L;
	
	private String newstype_no;
	private String newstype_name;
	
	public NewstypeVO() {}

	public String getNewstype_no() {
		return newstype_no;
	}

	public void setNewstype_no(String newstype_no) {
		this.newstype_no = newstype_no;
	}

	public String getNewstype_name() {
		return newstype_name;
	}

	public void setNewstype_name(String newstype_name) {
		this.newstype_name = newstype_name;
	}

	@Override
	public String toString() {
		return "NewstypeVO [newstype_no=" + newstype_no + ", newstype_name=" + newstype_name + "]";
	}
	
	
	
	
	
	
}
