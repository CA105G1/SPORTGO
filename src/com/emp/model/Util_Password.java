package com.emp.model;

public class Util_Password {
	// 編碼
	public static String encodePassword(String password) {
		StringBuffer stringBuffer = new StringBuffer(password);
		return stringBuffer.reverse().toString();
	}
	// 解碼
	public static String decodePassword(String password) {
		StringBuffer stringBuffer = new StringBuffer(password);
		return stringBuffer.reverse().toString();
	}
	
	public static void main(String[] args) {
		String string ="123456";
		System.out.println(Util_Password.encodePassword(string));
		System.out.println(Util_Password.decodePassword(Util_Password.encodePassword(string)));
	}
	
}
