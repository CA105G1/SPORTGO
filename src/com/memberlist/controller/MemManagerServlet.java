package com.memberlist.controller;

import java.io.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.memberlist.model.*;
@MultipartConfig(fileSizeThreshold=1024*1024,maxFileSize=5*1024*1024,maxRequestSize=5*5*1024*1024)
public class MemManagerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemManagerServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		MemberlistVO memberlistVO = null;
		String mem_no = null;
		MemberlistService service = new MemberlistService();
		Map<String,String> errorMsgs = new LinkedHashMap<>();
		req.setAttribute("errorMsgs", errorMsgs);
		/****可能登入時間過長出現取不到會員相關資訊,重導回到登入畫面****/
		try {
			memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");	
		} catch (Exception e) {
			errorMsgs.put("loginerror", "請重新登入");
			res.sendRedirect("Login.jsp");
		}
		String action = req.getParameter("action");
		mem_no = memberlistVO.getMem_no();
		
		/****後台管理員只查一筆會員資料****/
		if("getOne_For_Display".equals(action)) {
			MemberlistVO memberlist = service.getOneMem(mem_no);
			req.setAttribute("memberlistVO", memberlist);
			RequestDispatcher listall = req.getRequestDispatcher("/back-end/memberlist/getOneMem.jsp");
			listall.forward(req, res);
			return;
		}
		
		/****前台更新會員資料****/
		if("Member_renew".equals(action)) {
			/****接受請求參數,錯誤驗證****/
			/****修改會員照片****/
			Part part =req.getPart("picture");
			byte[] file =null;
			/****修改會員資料****/
			String nick = req.getParameter("nick");
			String name = req.getParameter("name");
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			String emgc = req.getParameter("emgc");
			String emgcphone = req.getParameter("emgcphone");
			/****修改會員密碼****/
			String password = req.getParameter("password");
			/********選填欄位***********/
			/******接受請求參數,錯誤驗證*******/
			if("".equals(password)||(password.trim()).length()==0) {
				errorMsgs.put("password", "密碼欄位必填");
			}
			if("".equals(email)||(email.trim()).length()==0) {
				errorMsgs.put("email", "電子郵件欄位必填");
			}
			if("".equals(phone)||(phone.trim()).length()==0) {
				errorMsgs.put("phone","電話欄位必填");
			}
			if("".equals(name)||(name.trim()).length()==0) {
				errorMsgs.put("name", "姓名欄位必填");
			}
			if("".equals(nick)||nick==null) {
				memberlistVO.setMem_nick(" ");
			}
			if("".equals(emgc)||emgc==null) {
				memberlistVO.setMem_emgc(" ");
			}
			if("".equals(emgcphone)||emgcphone==null) {
				memberlistVO.setMem_emgcphone(" ");
			}
			if(part.getSubmittedFileName().length()!=0&& part.getContentType()!=null) {
				InputStream in= part.getInputStream();
				file = new byte[in.available()];
				in.read(file);
				in.close();
			/****永續層存取,更新會員照片*****/
				try {
					service.renewPicture(mem_no, file, part.getContentType());
					System.out.println("picture renew successful");
					req.setAttribute("picture", file);
				} catch (RuntimeException re) {
					errorMsgs.put("picture", "輸入的照片有誤");
					re.printStackTrace();
					RequestDispatcher donothing = req.getRequestDispatcher("Member_page.jsp");
					donothing.forward(req, res);
				}
			}
			if(!errorMsgs.isEmpty()) {
				req.setAttribute("mem_name", name);
				req.setAttribute("mem_pswd", password);
				req.setAttribute("mem_email", email);
				req.setAttribute("mem_phone", phone);
				req.setAttribute("mem_nick", nick);
				req.setAttribute("mem_emgc", emgc);
				req.setAttribute("mem_emgcphone", emgcphone);
				req.setAttribute("action", "Member_renew");
				RequestDispatcher error = req.getRequestDispatcher("Member_renew.jsp");
				error.forward(req, res);
			}
			try {
				/*******永續層存取,更新會員資料*******/
				if (!("".equals(nick) && "".equals(emgc) && "".equals(emgcphone)
						&&"".equals(mem_no)&&"".equals(phone)&&"".equals(name))) {
					memberlistVO = service.renewPrivacy(mem_no, name, nick, email, phone, emgc, emgcphone);
					System.out.println("會員資料更新成功");
				}
				if(!("".equals(password)&&"".equals(mem_no))) {
					service.renewPassword(mem_no, password);
					System.out.println("會員密碼更新成功");
				}
			} catch (RuntimeException e) {
				System.out.println("新增資料錯誤"+e.getMessage());
				log(e.getMessage());
			}
			/*****更新完成,準備轉交******/
			if(errorMsgs.isEmpty()) {
				memberlistVO = service.getOneMem(mem_no);
				session.setAttribute("memberlistVO", memberlistVO);
				RequestDispatcher donothing = req.getRequestDispatcher("Member_page.jsp");
				donothing.forward(req, res);
			}
		} 
	
		/****前台更新信用卡資料****/
		if("renew_Card".equals(action)){
			/*****接受請求參數 錯誤驗證******/
		String card	= (String) req.getParameter("card");
		String expiry1 = (String) req.getParameter("expiry1");
		String expiry2 = (String) req.getParameter("expiry2");
		if(card==null||expiry1==null||expiry2==null) {
			res.sendRedirect("Creditcard.jsp");
		}
		if("".equals(card)||(card.trim()).length()==0) {
			errorMsgs.put(card, "卡號欄位必填");
		}
		if(card.length()!=16) {
			errorMsgs.put(card, "卡號長度不符");
		}
		if("".equals(expiry1)||(expiry1.trim()).length()==0){
			errorMsgs.put(expiry1,"到期年份必填");
		}
		if("".equals(expiry2)||(expiry2.trim()).length()==0){
			errorMsgs.put(expiry2,"到期月份必填");
		}
		
		if(!errorMsgs.isEmpty()) {
			req.setAttribute("mem_card", card);
			req.setAttribute("expiry1", expiry1);
			req.setAttribute("expiry2", expiry2);
			RequestDispatcher error = req.getRequestDispatcher("Creditcard.jsp");
			error.forward(req, res);
			return;
		}
		
		/****永續層存取,更新信用卡資料****/
		if(card!=null&&expiry1!=null&&expiry2!=null) {
			String expiry = expiry1+expiry2;
			try {
				service.renewCard(mem_no, card, expiry);
				System.out.println("信用卡新增成功");
			}catch(RuntimeException re) {
				re.printStackTrace(System.err);
				errorMsgs.put("creditcard", "輸入的卡號有誤");
				RequestDispatcher donothing = req.getRequestDispatcher("Creditcard.jsp");
				donothing.forward(req, res);
			}
		}
		/****更新完成準備轉交****/
		if(errorMsgs.isEmpty()) {
			memberlistVO = service.getOneMem(mem_no);
			session.setAttribute("memberlistVO", memberlistVO);
			RequestDispatcher dosomething = req.getRequestDispatcher("Creditcard.jsp");
			dosomething.forward(req, res);
		}
		
		
		}
	
	}
}
