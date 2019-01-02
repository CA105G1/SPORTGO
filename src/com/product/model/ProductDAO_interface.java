package com.product.model;

import java.util.List;
import java.util.Map;



public interface ProductDAO_interface {
	//新增
	public abstract int insert (ProductVO proVO);
    //更新
	public abstract int update (ProductVO proVO);
    //刪除 多筆刪除
	public abstract int delete (String ord_no ,String prom_project_id , String pro_no );
	//刪除
	public abstract int delete (String pro_no );
    //單筆查詢
	ProductVO findByPK (String pro_no);
	//全部查詢    
    public abstract List<ProductVO> getAll();
    //複合查詢
    public abstract List<ProductVO> getAll(Map<String, String[]> map);

}
