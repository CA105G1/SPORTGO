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
	List<OrddetailsVO> findByPK (String ord_no);
	//多筆查詢
	public abstract List<OrddetailsVO> getAll();
	
	//同時新增部門與員工 (實務上並不常用, 但,可用在訂單主檔與明細檔一次新增成功)
    public void insert2 (OrddetailsVO orddetailsVO , java.sql.Connection con);

}
