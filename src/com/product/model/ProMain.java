package com.product.model;

import java.util.List;

public class ProMain {
	
	public static void main (String[]  args) {
		
		ProdouctJDBCDAO proDAO = new ProdouctJDBCDAO();
/*
		//新增
		ProVO pro1 = new ProVO();
        pro1.setPro_classid("PT001");
        pro1.setPro_name("Addies");
        pro1.setPro_pic(null);
        pro1.setPro_pic_ext("PIC_EXT");
        pro1.setPro_format("9.5");
        pro1.setPro_bonus(2000);
        pro1.setPro_stock(20);
        pro1.setPro_safestock(5);
    	pro1.setPro_details("DETAILS");
    	pro1.setPro_shelve("ON");
    	pro1.setPro_all_assess(5);
    	pro1.setPro_all_assessman(10);
        proDAO.insert(pro1);
        System.out.println("成功INSERT");
        
        //修改
        ProVO pro2 = new ProVO();
        
        pro2.setPro_classid("PT001");
        pro2.setPro_name("Addies");
        pro2.setPro_pic(null);
        pro2.setPro_pic_ext("TEST");
        pro2.setPro_format("TEST");
        pro2.setPro_bonus(3000);
        pro2.setPro_stock(50);
        pro2.setPro_safestock(10);
    	pro2.setPro_details("test...................");
    	pro2.setPro_shelve("上架中");
    	pro2.setPro_all_assess(6);
    	pro2.setPro_all_assessman(100);
    	pro2.setPro_no("PR001");
    	proDAO.update(pro2);
    	System.out.println("成功修改");
 */       
		//單筆查詢
    	ProdouctVO pro3 = proDAO.findByPK("P001");
    	System.out.println(pro3.getPro_no() + ",");
    	System.out.println(pro3.getPro_classid() + ",");
    	System.out.println(pro3.getPro_name() + ",");
    	System.out.println(pro3.getPro_pic() + ",");
    	System.out.println(pro3.getPro_pic_ext() + ",");
    	System.out.println(pro3.getPro_format() + ",");
    	System.out.println(pro3.getPro_bonus() + ",");
    	System.out.println(pro3.getPro_stock() + ",");
    	System.out.println(pro3.getPro_safestock() + ",");
    	System.out.println(pro3.getPro_details() + ",");
    	System.out.println(pro3.getPro_shelve() + ",");
    	System.out.println(pro3.getPro_all_assess() + ",");
    	System.out.println(pro3.getPro_all_assessman() + ",");
    	System.out.println("-------------------------------------");
 
    	//多筆查詢
    	List<ProdouctVO> provolist = proDAO.getAll();
    	for (ProdouctVO pro4 : provolist) {
        	System.out.println(pro4.getPro_no() + ",");
        	System.out.println(pro4.getPro_classid() + ",");
        	System.out.println(pro4.getPro_name() + ",");
        	System.out.println(pro4.getPro_pic() + ",");
        	System.out.println(pro4.getPro_pic_ext() + ",");
        	System.out.println(pro4.getPro_format() + ",");
        	System.out.println(pro4.getPro_bonus() + ",");
        	System.out.println(pro4.getPro_stock() + ",");
        	System.out.println(pro4.getPro_safestock() + ",");
        	System.out.println(pro4.getPro_details() + ",");
        	System.out.println(pro4.getPro_shelve() + ",");
        	System.out.println(pro4.getPro_all_assess() + ",");
        	System.out.println(pro4.getPro_all_assessman() + ",");
        	System.out.println("-----------------------------------");
    	}
    	
    	//刪除  (雙子表格)
//    	proDAO.delete("20181211-000001" , "PR001" ,"P001");
    	
    	
	}

}
