package com.android.sg_mem.model;

import java.io.Serializable;

public class SGMember extends Sg_memVO_android implements Serializable{

	//Join後得到的欄位
	private String sg_name;
	private String mem_name;
	
	public SGMember() {
	}
	
	public String getSg_name() {
		return sg_name;
	}
	
	public void setSg_name(String sg_name) {
		this.sg_name = sg_name;
	}

	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	
}
