package com.android.member.controller;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.android.member.model.*;

import java.util.*;

@WebServlet("/Login")
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
		String action = req.getParameter("account");

		MemberDAO_Andorid dao = new MemberDAO_Andorid();
		List<MemberVO_Andorid> listall = dao.getAll();
		for(MemberVO_Andorid acc : listall) {
			if(action.equals(acc.getMem_account())) {
				HttpSession session = req.getSession();
				session.setAttribute("mem_no", acc.getMem_no());
				RequestDispatcher memberview = req.
						getRequestDispatcher("/WebContent/front-end/memberlist/listOneMem.jsp");
				memberview.forward(req,res);
			}
		}
			
	}

}
