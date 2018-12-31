package com.region.model;

import java.util.*;

public interface RegDAO_interface {
	
	public void insert(RegVO regVO);
	public void update(RegVO regVO);
	public void delete(Integer reg_no);
    public RegVO findByPrimaryKey(Integer reg_no);
	public List<RegVO> getAll();
	
	public RegVO getRegVOFromAddress(String address);
	
	
//	萬用複合查詢(傳入參數型態Map)(回傳 List)
	public List<RegVO> getAll(Map<String, String[]> map); 

}
