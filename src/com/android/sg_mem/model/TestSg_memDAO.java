package com.android.sg_mem.model;

import java.util.List;


public class TestSg_memDAO {
	public static void main(String[] args) {
		Sg_memJDBCDAO_android dao = new Sg_memJDBCDAO_android();
		
				List<SGMember> sgmlist = dao.findBySG("S002");
		
		for (SGMember x: sgmlist ) {
			System.out.println(x.getSg_name());
			System.out.println(x.getMem_name());
			System.out.println(x.getCh_status());
			System.out.println("------------------------");
		}
		
	}
}
