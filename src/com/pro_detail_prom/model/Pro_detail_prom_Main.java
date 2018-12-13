package com.pro_detail_prom.model;

import java.util.List;


public class Pro_detail_prom_Main {
	
	public static void main(String[] args) {
		
		Pro_detail_promJDBCDAO pro_detail_promJDBCDAO = new Pro_detail_promJDBCDAO();
		
//		//新增 需要注意兩個fk 有無資料
//		Pro_detail_promVO pro_detail_promVO = new Pro_detail_promVO();
//		pro_detail_promVO.setProm_project_id("PR003");
//		pro_detail_promVO.setPro_no("P002");
//		pro_detail_promVO.setPro_sale(1000);
//		System.out.println("成功新增" + pro_detail_promJDBCDAO.insert(pro_detail_promVO)+ "筆" );
		
//		//修改
//		Pro_detail_promVO pro_detail_promVO1 = new Pro_detail_promVO();
//		pro_detail_promVO1.setProm_project_id("PR001");
//		pro_detail_promVO1.setPro_no("P001");
//		pro_detail_promVO1.setPro_sale(8000);
//		pro_detail_promVO1.setProm_project_id("PR001");
//		System.out.println("成功修改" + pro_detail_promJDBCDAO.updata(pro_detail_promVO1)+ "筆" );
		
//		//刪除
//		System.out.println("成功刪除" + pro_detail_promJDBCDAO.delete("PR001") + "筆");
		
//		//單筆查詢
//		Pro_detail_promVO pro_detail_promVO2 = pro_detail_promJDBCDAO.findByPK("PR001");
//	    System.out.println(pro_detail_promVO2.getProm_project_id());
//	    System.out.println(pro_detail_promVO2.getPro_no());
//	    System.out.println(pro_detail_promVO2.getPro_sale());
//	    System.out.println("-----------------------------------------");
	    
        //多筆查詢
	    List<Pro_detail_promVO> promotionVOList = pro_detail_promJDBCDAO.getAll();
	    for (Pro_detail_promVO  pro_detail_promVO3: promotionVOList) {
	    	System.out.println(pro_detail_promVO3.getProm_project_id());
	    	System.out.println(pro_detail_promVO3.getPro_no());
	    	System.out.println(pro_detail_promVO3.getPro_sale());
	    	System.out.println("------------------------------------");
	    }
		
	}

}
