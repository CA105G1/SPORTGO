package com.android.sg_mem.model;

import java.util.List;


public class TestSg_memDAO {
	public static void main(String[] args) {
		Sg_memJDBCDAO dao = new Sg_memJDBCDAO();
		
				List<Sg_mem> sgmlist = dao.findBySG("S002");
		
		for (Sg_mem x: sgmlist ) {
			System.out.println(x.getSg_name());
			System.out.println(x.getMem_name());
			System.out.println(x.getCh_status());
			System.out.println("------------------------");
		}
		
	}
}
