package com.region.model;

import java.util.List;

public class Twat {
	public static void main(String[] args) {
		
		RegService regService = new RegService();
		List<String> list = regService.getRegVOFormRegName("台北市");
		for(String string : list) {
			System.out.println(string);
		}
		
		
	}
}
