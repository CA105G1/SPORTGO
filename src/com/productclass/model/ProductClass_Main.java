package com.productclass.model;

import java.util.List;

public class ProductClass_Main {
	
	public static void main (String[] args) {
		
		ProductClassJDBCDAO productClassDAO = new ProductClassJDBCDAO();
		
//		//新增
//		ProductClassVO productClassVO = new ProductClassVO();
//		productClassVO.setPro_classname("CLOTHING");
//		System.out.println("成功新增" + productClassDAO.insert(productClassVO) + "筆");
//		
//		//修改
//		ProductClassVO productClassVO1 = new ProductClassVO();
//		productClassVO1.setPro_classid("PT001");
//		productClassVO1.setPro_classname("TEST");
//		System.out.println("成功修改" + productClassDAO.update(productClassVO1) + "筆");
//		
//		//刪除 多筆刪除  *(要測試刪除需要動態改日期參數)* 目前只能刪除第一筆
//		System.out.println("成功刪除" + productClassDAO.delete("PR001", "20181216-000001", "P001", "PT001") + "筆");
		//刪除  *(要測試刪除需要動態改日期參數)*
//		System.out.println("成功刪除" + productClassDAO.delete("PT006") + "筆");
		
		//單筆查詢
//		ProductClassVO productClassVO2 = productClassDAO.findByPK("PT001");
//		System.out.println(productClassVO2.getPro_classid() + ",");
//		System.out.println(productClassVO2.getPro_classname() + ",");
//		System.out.println("---------------------------------------");
//		
		//全部查詢
//		List<ProductClassVO> productClassList = productClassDAO.getAll();
//		for (ProductClassVO productClassVO3 : productClassList) {
//			System.out.println(productClassVO3.getPro_classid() + ",");
//			System.out.println(productClassVO3.getPro_classname() + ",");
//			System.out.println("----------------------------------------");
//			
//		}
		
		
	}

}
