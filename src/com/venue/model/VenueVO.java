package com.venue.model;


public class VenueVO {
	private String v_no;
	private String v_name;
	private String vt_no;
	private Integer reg_no;
	private Double v_lat;
	private Double v_long;
	private String v_pic;
	private String v_address;
	private String v_phoneno;
	private String v_status;
	private String v_func;


	public VenueVO() {
		super();
	}

	public String getV_no() {
		return v_no;
	}


	public void setV_no(String v_no) {
		this.v_no = v_no;
	}


	public String getV_name() {
		return v_name;
	}


	public void setV_name(String v_name) {
		this.v_name = v_name;
	}


	public String getVt_no() {
		return vt_no;
	}


	public void setVt_no(String vt_no) {
		this.vt_no = vt_no;
	}


	public Integer getReg_no() {
		return reg_no;
	}


	public void setReg_no(Integer reg_no) {
		this.reg_no = reg_no;
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


	public String getV_func() {
		return v_func;
	}


	public void setV_func(String v_func) {
		this.v_func = v_func;
	}
	
	
	public String getV_pic() {
		return v_pic;
	}

	public void setV_pic(String v_pic) {
		this.v_pic = v_pic;
	}


	public String getV_address() {
		return v_address;
	}


	public void setV_address(String v_address) {
		this.v_address = v_address;
	}


	public String getV_phoneno() {
		return v_phoneno;
	}


	public void setV_phoneno(String v_phoneno) {
		this.v_phoneno = v_phoneno;
	}


	public String getV_status() {
		return v_status;
	}


	public void setV_status(String v_status) {
		this.v_status = v_status;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((v_name == null) ? 0 : v_name.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		VenueVO other = (VenueVO) obj;
		if (v_name == null) {
			if (other.v_name != null)
				return false;
		} else if (!v_name.equals(other.v_name))
			return false;
		return true;
	}
	
	
	
	
}
