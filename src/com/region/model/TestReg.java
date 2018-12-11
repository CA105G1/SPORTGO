package com.region.model;

import java.util.List;

public class TestReg {
	
	public static void main(String[] args) {
		
		RegDAO_interface ri  = new RegJDBCDAO();
//		
//		ri.insert(new RegVO(101,"大安區"));
//		ri.update(new RegVO(102,"?區"));
//		ri.delete(102);
//		
//		
//		RegVO reg = ri.findByPrimaryKey(101);
//		System.out.println(reg.getReg_name());
//		
//		System.out.println("========================");
		
		List<RegVO> regVO = ri.getAll();
		
		for (RegVO x : regVO) {
			System.out.println(x.getReg_no() + " " + x.getReg_name());
		}
		
	}

}
