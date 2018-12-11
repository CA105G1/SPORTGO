package com.product_like.model;

public class Product_likeVO implements java.io.Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String product_no;
	private String mem_no;
	
	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public String getMem_no() {
		return mem_no;
	}

	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}

	public Product_likeVO() {
	}

}
