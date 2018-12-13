package com.orddetails.model;

import java.util.List;



public interface Orddetails_interface {
	
	//新增
	public abstract int insert (OrddetailsVO orddetailsVO);
	//修改
	public abstract int updata (OrddetailsVO orddetailsVO);
	//刪除
	public abstract int delete (String ord_no);
	
	//單筆查詢
	OrddetailsVO findByPK (String ord_no);
	//多筆查詢
	public abstract List<OrddetailsVO> getAll();

}
