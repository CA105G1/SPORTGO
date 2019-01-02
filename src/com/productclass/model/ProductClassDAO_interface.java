package com.productclass.model;

import java.util.List;

public interface ProductClassDAO_interface {
	//新增
	public abstract int insert (ProductClassVO productClassVO );
	//修改
	public abstract int update (ProductClassVO productClassVO );
	//刪除
	public abstract int delete (String pro_classid );
	//刪除 多筆刪除
	public abstract int delete (String prom_project_id , String ord_no , String pro_no , String pro_classid);
	//單筆查詢
	ProductClassVO findByPK (String pro_classid);
	//全部查詢
    public abstract List<ProductClassVO> getAll();
}
