package com.friend.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.memberlist.model.*;
import com.friend.model.*;

public class FriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public FriendServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		FriendService service = new FriendService();
		MemberlistVO memberlistVO = null;
		String action = req.getParameter("action");
//		String mem_no = (String) req.getAttribute("mem_no");
		
		if("find_My_Friend".equals(action)) {
			memberlistVO = (MemberlistVO) session.getAttribute("memberlistVO");
			if(memberlistVO==null) {
				res.sendRedirect("Login.jsp");
				return;
			}
			String mem_no = memberlistVO.getMem_no();
			List<FriendVO> myfriend = service.findMyFriend(mem_no);
			req.setAttribute("friendlist", myfriend);
			RequestDispatcher listgo = req.getRequestDispatcher("friend.jsp");
			listgo.forward(req, res);
		}
	}

}
