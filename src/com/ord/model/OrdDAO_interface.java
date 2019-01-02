package com.ord.model;

import java.util.List;

import com.orddetails.model.OrddetailsVO;
import com.product.model.ProductVO;


public interface OrdDAO_interface {
	//新增
	public abstract int insert (OrdVO ordVO);
    //更新
	public abstract int updata (OrdVO ordVO);
	//刪除
	public abstract int delete (String ord_no);
	//單筆查詢
	OrdVO findByPK(String ord_no);
	//全部查詢
	List<OrdVO> getAll();
	
	//同時新增部門與員工 (實務上並不常用, 但,可用在訂單主檔與明細檔一次新增成功)
    public String insertWithOrdds( OrdVO ordVO , List<OrddetailsVO> list);
}
