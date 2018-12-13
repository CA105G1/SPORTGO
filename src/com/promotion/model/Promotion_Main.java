package com.promotion.model;

import java.util.*;

public class Promotion_Main {
	
	public static void main (String[] args) {
		PromotionJDBCDAO promotionDAO = new PromotionJDBCDAO();
		
		//新增
		PromotionVO promotionVO = new PromotionVO();
		promotionVO.setProm_project_name("父親節");
		promotionVO.setProm_project_sdate(java.sql.Timestamp.valueOf("2019-07-30 14:25:00"));
		promotionVO.setProm_project_edate(java.sql.Timestamp.valueOf("2019-08-08 11:50:55"));
		System.out.println("成功新增" + promotionDAO.insert(promotionVO)+ "筆" );
		
//		//修改
//		PromotionVO promotionVO1 = new PromotionVO();
//		promotionVO1.setProm_project_id("PR001");
//		promotionVO1.setProm_project_name("test2");
//		promotionVO1.setProm_project_sdate(java.sql.Timestamp.valueOf("2019-01-01 15:23:33"));
//		promotionVO1.setProm_project_edate(java.sql.Timestamp.valueOf("2019-02-01 18:29:51"));
//		System.out.println("成功修改" + promotionDAO.updata(promotionVO1) + "筆");
//		
//		//刪除
//		System.out.println("成功刪除" + promotionDAO.detele("PR001") + "筆");
//		
//		//單筆查詢
//		PromotionVO promotionVO2 = promotionDAO.findByPK("PR001");
//	    System.out.println(promotionVO2.getProm_project_id());
//	    System.out.println(promotionVO2.getProm_project_name());
//	    System.out.println(promotionVO2.getProm_project_sdate());
//	    System.out.println(promotionVO2.getProm_project_edate());
//	    System.out.println("-----------------------------------------");
//		
//		//多筆查詢
//	    List<PromotionVO> promotionVOList = promotionDAO.getAll();
//	    for (PromotionVO promotionVO3 : promotionVOList) {
//	    	System.out.println(promotionVO3.getProm_project_id());
//	    	System.out.println(promotionVO3.getProm_project_name());
//	    	System.out.println(promotionVO3.getProm_project_sdate());
//	    	System.out.println(promotionVO3.getProm_project_edate());
//	    	System.out.println("------------------------------------");
//	    }
	}
	
	

}
