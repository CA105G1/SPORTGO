package com.ord.model;

import java.util.List;

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
	
}
