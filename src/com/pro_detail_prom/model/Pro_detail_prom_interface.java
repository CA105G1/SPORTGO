package com.pro_detail_prom.model;

import java.util.List;


public interface Pro_detail_prom_interface {
	
	//新增
	public abstract int insert (Pro_detail_promVO pro_detail_promVO);
	//修改
	public abstract int updata (Pro_detail_promVO pro_detail_promVO);
	//刪除
	public abstract int delete (String prom_project_id);
	
	//單筆查詢
	Pro_detail_promVO findByPK (String prom_project_id);
	//多筆查詢
	public abstract List<Pro_detail_promVO> getAll();
}
