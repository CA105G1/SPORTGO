package com.sg_msg.model;

import java.util.ArrayList;
import java.util.List;

public class TestSg_msgDAO {
	public static void main(String[] args) {
		Sg_msgDAO dao = new Sg_msgDAO();
		Sg_msgVO vo = new Sg_msgVO();
		List<Sg_msgVO> list = new ArrayList<Sg_msgVO>();
		
		vo.setSg_no("S001");
		vo.setMem_no("M001");
		vo.setMsg_cont("今晚打老虎");
		dao.insert(vo);
		
		Sg_msgVO vo2 = new Sg_msgVO();
		vo2 = dao.findByPk("MSG016");
		System.out.println(vo2.getMsg_no());
		System.out.println(vo2.getSg_no());
		System.out.println(vo2.getMem_no());
		System.out.println(vo2.getMsg_cont());
		System.out.println("---------------------");
		
		Sg_msgVO vo22 = new Sg_msgVO();
		vo22.setMsg_no("MSG016");
		vo22.setSg_no("S002");
		vo22.setMem_no("M002");
		vo22.setMsg_cont("今晚打老虎22222222222222222222");
		dao.update(vo22);
		
		
		list = dao.getAll();
		for(Sg_msgVO vo3 : list) {
			System.out.println(vo3.getMsg_cont());
			System.out.println("---------------------");
		}
		
		
		
		
//		dao.delete("MSG012");
		
	}
}
