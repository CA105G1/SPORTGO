package com.product.model;

import java.util.List;

public interface ProdouctDAO_interface {
	    void insert (ProdouctVO proVO);
	    public abstract void update (ProdouctVO proVO);
	    public abstract void delete (String ord_no ,String prom_project_id , String pro_no );
	    ProdouctVO findByPK (String pro_no);
	    
	    public abstract List<ProdouctVO> getAll();

}
