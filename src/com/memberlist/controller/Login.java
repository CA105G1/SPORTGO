package com.memberlist.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
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
		String mem_no = null;
		/*************開始查詢資料**************/
		MemberlistDAO dao = new MemberlistDAO();
		List<MemberlistVO> listall = dao.getAll();
		for(MemberlistVO acc : listall) {
			if(account.equals(acc.getMem_account())) {
				if(password.equals(acc.getMem_pswd())) {
					account = acc.getMem_account();
					mem_no = acc.getMem_no();
				}
			}
		}
		/************查詢完成準備轉交（send the success view）***************/
		HttpSession session = req.getSession();
		session.setAttribute("MemberlistVO", dao.findByPrimaryKey(mem_no));
		String url = "/front-end/memberlist/Member_page.jsp";
		RequestDispatcher memberview = req.getRequestDispatcher(url);
		memberview.forward(req,res);
		
	}

}
