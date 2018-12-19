package com.memberlist.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.memberlist.model.*;
import java.util.*;


public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doPost(req,res);
	
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		/*************接受請求參數**************/
		String account = req.getParameter("account");
		String password = req.getParameter("password");
		String button = req.getParameter("button");
		HttpSession session = req.getSession();
		MemberlistService service = new MemberlistService();
		String mem_no = null;
		String accountcompare = null;
		Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
		req.setAttribute("errorMsgs", errorMsgs);
		/********確定按鈕是登入還是註冊***********/
		
		/****註冊跳轉****/
		if("register".equals(button)) {
			req.setAttribute("account", account);
			req.setAttribute("password", password);
			String url ="/front-end/memberlist/RegisterMem_page.jsp";
			RequestDispatcher memberregister = req.getRequestDispatcher(url);
			memberregister.forward(req,res);
			return;
		}
		/****三次不存在帳號輸入****/
		/****錯誤驗證 帳號密碼是否有空值****/
		
		if(account==null||(account.trim()).length()==0) {
			res.sendRedirect("RegisterMem_page.jsp");
			return;
		}
		if(!errorMsgs.isEmpty()) {
			RequestDispatcher nopswd = req
					.getRequestDispatcher("Login.jsp");
			nopswd.forward(req, res);
			return;
		}
		/*************開始查詢資料**************/
		if(errorMsgs.isEmpty()){
			List<MemberlistVO> listall =null;
			try{
				listall = service.getAllMem();
			}catch(RuntimeException re) {
				System.out.println(re.getMessage());
				log(re.getMessage());
			}
			for(MemberlistVO acc : listall) {
				if(account.equals(acc.getMem_account())) {
					accountcompare = acc.getMem_account();
					/****密碼驗證****/
					if(password==null||(password.trim()).length()==0) {
						errorMsgs.put("password","密碼欄位不得空白");
					}
					else if(password.equals(acc.getMem_pswd())) {
						mem_no = acc.getMem_no();
						break;
					}
					/****密碼錯誤****/	
					else {
						errorMsgs.put("password","輸入的密碼有誤");
						RequestDispatcher errpswd = req
								.getRequestDispatcher("Login.jsp");
						errpswd.forward(req, res);
						return;
					}
				}
			}
			/****帳號不存在****/
			if(accountcompare==null) {
				errorMsgs.put("account", "帳號不存在,請重新輸入");
			}
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher errpswd = req
						.getRequestDispatcher("Login.jsp");
				errpswd.forward(req, res);
				return;
			}
		}
		
		/************查詢完成準備轉交（send the success view）***************/
		if(!mem_no.isEmpty()) {
			try{
				session.setAttribute("MemberlistVO", service.getOneMem(mem_no));
			}catch(RuntimeException re) {
				System.out.println(re.getMessage());
				log(re.getMessage());
			}
			String url = "/front-end/memberlist/Member_page.jsp";
			RequestDispatcher memberview = req.getRequestDispatcher(url);
			memberview.forward(req,res);
		}
	}
}
