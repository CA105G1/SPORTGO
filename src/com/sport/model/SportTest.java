package com.sport.model;

import java.util.List;

public class SportTest {

	public static void main(String[] args) {
		SportDAO dao = new SportDAO();
		List<SportVO> list = dao.getAll();
		
		for(SportVO vo : list) {
			System.out.println(vo.getSp_no());
			System.out.println(vo.getSp_name());
		}
		
		
	}

}
