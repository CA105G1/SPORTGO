package com.memberlist.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Logout() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		session.removeAttribute("memberlistVO");
//		session.invalidate();
		try{
			String location = (String) session.getAttribute("location");
			if(location!=null) {
				session.removeAttribute("location");
				res.sendRedirect(location);
				return;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		res.sendRedirect(req.getContextPath()+"/index.jsp");
//		System.out.println(session.getAttribute("memberlistVO"));
	}

}
