package com.memberlist.controller;

import java.io.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.memberlist.model.*;

public class RegisterMem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RegisterMem() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		MemberlistService service = new MemberlistService();
		MemberlistVO newmem = null;
		List<MemberlistVO> memall = new ArrayList<>();
		Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		req.setAttribute("errorMsgs", errorMsgs);
		String name = req.getParameter("name");
		String account = req.getParameter("account");
		String password = req.getParameter("password");
		String email = req.getParameter("email");
		String phone = req.getParameter("phone");
		
		String nick = req.getParameter("nick");
		String emgc = req.getParameter("emgc");
		String emgcphone = req.getParameter("emgcphone");
		String memno = null;
		String button = req.getParameter("button");
		/*****按鈕驗證*******/
		if("cancel".equals(button)) {
			res.sendRedirect("Login.jsp");
			return;
		}
		/*******必填欄位驗證*********/
		if("".equals(account)||(account.trim()).length()==0) {
			errorMsgs.put("account", "帳號欄位必填");
		}
		/*******驗證帳號是否重複********/
		memall = service.getAllMem();
		for(MemberlistVO check : memall) {
			if(account.equals(check.getMem_account())) {
				errorMsgs.put("account", "此帳號已被使用");
			}
		}
		/*******必填欄位驗證*********/
		if("".equals(name)||(name.trim()).length()==0) {
			errorMsgs.put("name", "姓名欄位必填");
		}
		if("".equals(password)||(password.trim()).length()==0) {
			errorMsgs.put("password", "密碼欄位必填");
		}
		if("".equals(email)||(email.trim()).length()==0) {
			errorMsgs.put("email", "電子郵件欄位必填");
		}
		if("".equals(phone)||(phone.trim()).length()==0) {
			errorMsgs.put("phone","電話欄位必填");
		}
		if(!errorMsgs.isEmpty()) {
			RequestDispatcher notnull = req.getRequestDispatcher("RegisterMem_page.jsp");
			notnull.forward(req, res);
			return;
		}
		/********開始新增資料**********/
		try {
			newmem = service.addmemberlist(name, account, password, email, phone);
			memno = newmem.getMem_no();
			/********選填欄位***********/
			if("".equals(nick)||nick==null) {
				newmem.setMem_nick(" ");
			}
			if("".equals(emgc)||emgc==null) {
				newmem.setMem_emgc(" ");
			}
			if("".equals(emgcphone)||emgcphone==null) {
				newmem.setMem_emgcphone(" ");
			}
			if (!("".equals(nick) && "".equals(emgc) && "".equals(emgcphone))) {
				newmem = service.renewPrivacy(memno, name, nick, email, phone, emgc, emgcphone);
			} 
		} catch (RuntimeException e) {
			System.out.println("新增資料錯誤"+e.getMessage());
			log(e.getMessage());
		}
		
		/************查詢完成準備轉交（send the success view）***************/
		HttpSession session = req.getSession();
		session.setAttribute("MemberlistVO", newmem);
		String url = "Member_page.jsp";
		RequestDispatcher memberview = req.getRequestDispatcher(url);
		memberview.forward(req,res);	
	} 
}
