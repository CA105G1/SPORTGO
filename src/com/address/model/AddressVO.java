package com.address.model;

public class AddressVO implements java.io.Serializable{

	private static final long serialVersionUID = 87L;

	public AddressVO() {
	}
	
	private String addr_no;
	private String mem_no;
	private String receiver;
	private String receiver_phone;
	private String country;
	private String city;
	private String addr_detail;
	private Integer addr_zip;
	
	public AddressVO(String mem_no,String receiver,String receiver_phone,String country
					,String city,String addr_detail,String addr_zip) {
		setMem_no(mem_no);
		setReceiver(receiver);
		setReceiver_phone(receiver_phone);
		setCountry(country);
		setCity(city);
		setAddr_detail(addr_detail);
		try {
			Integer zip = java.lang.Integer.parseInt(addr_zip);
			setAddr_zip(zip);
		} catch (Exception e) {
			throw new RuntimeException("Illegalformat of zipcode. "+e.getMessage());
		}
		
	}
	public String getAddr_no() {
		return addr_no;
	}
	public void setAddr_no(String addr_no) {
		this.addr_no = addr_no;
	}
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getAddr_detail() {
		return addr_detail;
	}
	public void setAddr_detail(String addr_detail) {
		this.addr_detail = addr_detail;
	}
	public Integer getAddr_zip() {
		return addr_zip;
	}
	public void setAddr_zip(Integer addr_zip) {
		this.addr_zip = addr_zip;
	}

	

}
