package com.orddetails.model;

import java.util.List;

import com.ord.model.OrdVO;

public class Orddetails_Main {

	public static void main(String[] args) {
		
		OrddetailsJDBCDAO orddetailsJDBCDAO = new OrddetailsJDBCDAO();
		
//		//新增 需要注意兩個fk 有無資料
//		OrddetailsVO orddetailsVO = new OrddetailsVO();
//		orddetailsVO.setOrd_no("20181212-000003");
//		orddetailsVO.setPro_no("P001");
//		orddetailsVO.setOrd_probonuns(9999);
//		orddetailsVO.setPro_count(50);
//		System.out.println("成功新增" + orddetailsJDBCDAO.insert(orddetailsVO)+ "筆" );

		//修改
//		OrddetailsVO orddetailsVO1 = new OrddetailsVO();
//		orddetailsVO1.setOrd_no("20181212-000001");
//		orddetailsVO1.setPro_no("P001");
//		orddetailsVO1.setOrd_probonuns(77777);
//		orddetailsVO1.setPro_count(20);
//		orddetailsVO1.setOrd_no("20181212-000001");
//		System.out.println("成功修改" + orddetailsJDBCDAO.updata(orddetailsVO1)+ "筆" );

//		//刪除
//		System.out.println("成功刪除" + orddetailsJDBCDAO.delete("20181212-000001") + "筆");
			
//		//單筆查詢
//		OrddetailsVO orddetailsVO2 = orddetailsJDBCDAO.findByPK("20181212-000001");
//	    System.out.println(orddetailsVO2.getOrd_no());
//	    System.out.println(orddetailsVO2.getPro_no());
//	    System.out.println(orddetailsVO2.getOrd_probonuns());
//	    System.out.println(orddetailsVO2.getPro_count());
//	    System.out.println("-----------------------------------------");
	    
//		//全部查詢
//		List<OrddetailsVO> orddetailsVOList = orddetailsJDBCDAO.getAll();
//		for(OrddetailsVO orddetailsVO3 : orddetailsVOList ) {
//		    System.out.println(orddetailsVO3.getOrd_no());
//		    System.out.println(orddetailsVO3.getPro_no());
//		    System.out.println(orddetailsVO3.getOrd_probonuns());
//		    System.out.println(orddetailsVO3.getPro_count());
//			System.out.println("-----------------------------");
//		}	    
	    
	    
	    

	}

}
