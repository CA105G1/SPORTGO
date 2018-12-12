package com.v_evaluation.model;

import java.util.List;

public class TestVE {
		
	public static void main(String[] args) {
		
		V_evaluationDAO_interface vei  = new V_evaluationJDBCDAO();
		
//		vei.insert(new V_evaluationVO("M005","V000002", 3));
//		vei.insert(new VEVO("M002","V000003", 2));
//		vei.update(new VEVO("M001","V000002", 4));
//		vei.delete("M001", "V000001");
//		
//		
//		V_evaluationVO ve = vei.findByPrimaryKey("M002", "V000002");
//		System.out.println(ve.getScore());
//		
//		System.out.println("========================");
		
		List<V_evaluationVO> veVO = vei.getAll();
		
		for (V_evaluationVO x : veVO) {
			System.out.println(x.getMem_no() + " " + x.getV_no() + " " + x.getScore());
		}
		
	}
}
