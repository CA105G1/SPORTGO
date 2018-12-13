package com.promotion.model;

import java.util.List;

public interface PromotionDAO_interface {
	//新增
	public abstract int insert (PromotionVO promotionVO);
	//修改
	public abstract int updata (PromotionVO promotionVO);
	//刪除
	public abstract int detele (String prom_project_id);
	//單筆查詢
	public abstract PromotionVO findByPK (String prom_project_id);
	//全部查詢
	public abstract List<PromotionVO> getAll();

}
