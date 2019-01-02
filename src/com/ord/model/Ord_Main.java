//package com.ord.model;
//
//import java.util.List;
//
//public class Ord_Main {
//	
//	public static void main (String[] args) {
//		
//		OrdJDBCDAO ordDAO = new OrdJDBCDAO();
//		
//		//新增
//		OrdVO ordVO = new OrdVO();
//		//ordVO.setOrd_no(ord_no); 自動
//		ordVO.setMem_no("M001");
//		//ordVO.setOrd_date(new java.sql.Timestamp); 自動 
//		ordVO.setOrd_deldate(null);
//		ordVO.setOrd_status("待出貨");
//		ordVO.setOrd_backdeldate(null);
//		ordVO.setOrd_amount(1000);
//		ordVO.setOrd_backamount(10);
//		System.out.println("成功新增" + ordDAO.insert(ordVO));
////		
////		//修改
////		OrdVO ordVO1 = new OrdVO();
////		ordVO1.setOrd_no("20181212-000001");  //測試的話日期每天需要修改才能修改
////		ordVO1.setMem_no("M001");
////		//ordVO1.setOrd_date(new java.sql.Date); 自動 下單日期  不動
////		ordVO1.setOrd_deldate(java.sql.Timestamp.valueOf("2019-05-1 18:25:30"));
////		ordVO1.setOrd_status("退貨");
////		ordVO1.setOrd_backdeldate(java.sql.Timestamp.valueOf("2019-05-30 23:11:30"));
////		ordVO1.setOrd_amount(1000);
////		ordVO1.setOrd_backamount(1000);
////		System.out.println("成功修改" + ordDAO.updata(ordVO1));
////		
////		
////		//刪除 
////		System.out.println("成功刪除" + ordDAO.delete("20181212-000001"));//測試的話日期每天需要修改才能
////		
////		//單筆查詢
////		OrdVO ordVO2 = ordDAO.findByPK("20181212-000001");//測試的話日期每天需要修改才能
////		System.out.println(ordVO2.getOrd_no());
////		System.out.println(ordVO2.getMem_no());
////		System.out.println(ordVO2.getOrd_date());
////		System.out.println(ordVO2.getOrd_deldate());
////		System.out.println(ordVO2.getOrd_status());
////		System.out.println(ordVO2.getOrd_backdeldate());
////		System.out.println(ordVO2.getOrd_amount());
////		System.out.println(ordVO2.getOrd_backamount());
//		
//		//全部查詢
//		List<OrdVO> ordVOList = ordDAO.getAll();
//		for(OrdVO ordVO3 : ordVOList ) {
//			System.out.println(ordVO3.getOrd_no());
//			System.out.println(ordVO3.getMem_no());
//			System.out.println(ordVO3.getOrd_date());
//			System.out.println(ordVO3.getOrd_deldate());
//			System.out.println(ordVO3.getOrd_status());
//			System.out.println(ordVO3.getOrd_backdeldate());
//			System.out.println(ordVO3.getOrd_amount());
//			System.out.println(ordVO3.getOrd_backamount());
//			System.out.println("-----------------------------");
//		}
//		
//		
//	}
//
//}
