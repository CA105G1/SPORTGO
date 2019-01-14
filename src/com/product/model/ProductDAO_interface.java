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
    //全部查詢(上架)
    public abstract List<ProductVO> getAllOnShelve();
    //複合查詢
    public abstract List<ProductVO> getAll(Map<String, String[]> map);
    //更新狀態
    public abstract int updateShelve(String pro_no ,String pro_shelve);
    //查詢最後一筆
    public abstract ProductVO getLastVO();
    //訂單購買數量更動商品庫存
    public abstract int updateStock(String pro_no , Integer cart_pro_stock);
    //查詢購物車購買數量時庫存數量
    public abstract ProductVO getSelectStock(String pro_no , Integer cart_pro_stock);
    //更新評價分數
    public abstract int updateAssess(String pro_no, Integer pro_all_assess);
}
