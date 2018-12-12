package com.sg_mem.model;

import java.util.ArrayList;
import java.util.List;

public class TestSg_memDAO {
	public static void main(String[] args) {
		Sg_memDAO dao = new Sg_memDAO();
		Sg_memVO vo = new Sg_memVO();
		List<Sg_memVO> list = new ArrayList<Sg_memVO>();
		
//		list = dao.getAll();
//		for(Sg_memVO vo: list) {
//			System.out.println(vo.getSg_no());
//			System.out.println(vo.getMem_no());
//			System.out.println(vo.getCh_status());
//			System.out.println("------------------------");
//		}
		
		
		vo = dao.findByPk("S002", "M002");
		System.out.println(vo.getSg_no());
		System.out.println(vo.getMem_no());
		System.out.println(vo.getCh_status());
		System.out.println("------------------------");
		
	}
}
