package com.evaofmem.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.evaofmem.model.*;
import com.memberlist.model.*;

public class EvaofmemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EvaofmemServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		MemberlistVO memberlistVO = null;
		String mem_no = null;
		EvaofmemService service = new EvaofmemService();
		String action = req.getParameter("action");
		/****可能登入時間過長出現取不到會員相關資訊,重導回到登入畫面****/
		memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
		if(memberlistVO==null) {
			res.sendRedirect("Login.jsp");
			return;
		}
		mem_no = memberlistVO.getMem_no();
		
		if("Evaluate_Sg".equals(action)) {
			String evaluated = (String) req.getAttribute("evaluated_no");
			String sg_no = (String) req.getAttribute("sg_no");
			Integer score = (Integer) req.getAttribute("input-1");
			if(score==null) {
				score = 0;
			}
			try {
				service.addEvaluate(sg_no, mem_no, evaluated, score);
				System.out.println("evalated succeed");
			}catch(RuntimeException re) {
				try {
					service.updateEvaluate(sg_no, mem_no, evaluated, score);
					System.out.println("evaluated update");
				}catch(RuntimeException e) {
					e.printStackTrace();
					System.out.println("evaluated failed");
					req.setAttribute("status", "evaluatederr");
					RequestDispatcher clubgo = req.getRequestDispatcher("MemManager.do?action=Member_Sg");
					clubgo.forward(req, res);
				}
			}
			req.setAttribute("status", "evaluated");
			req.setAttribute("score", score);
			RequestDispatcher clubgo = req.getRequestDispatcher("MemManager.do?action=Member_Sg");
			clubgo.forward(req, res);
		}
		
		if("Sg_score".equals(action)) {
			
		}
		
		if("Mem_score".equals(action)) {
			
		}
		
		if("Evaluate_Sg_again".equals(action)) {
			
		}
		
		
		
		
	}

}
