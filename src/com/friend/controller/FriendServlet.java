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
		res.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		FriendService service = new FriendService();
		MemberlistVO memberlistVO = null;
		String action = req.getParameter("action");
//		String mem_no = (String) req.getAttribute("mem_no");
		
		/****好友列表****/
		if("find_My_Friend".equals(action)) {
			memberlistVO = (MemberlistVO) session.getAttribute("memberlistVO");
			if(memberlistVO==null) {
				res.sendRedirect("Login.jsp");
				return;
			}
			String mem_no = memberlistVO.getMem_no();
			List<FriendVO> myfriend = service.findMyFriend(mem_no);
			List<FriendVO> mypossiblefriend = service.findMyPossibleFriend(mem_no);
			List<FriendVO> whoaddme = service.findWhoAdd(mem_no);
			req.setAttribute("friendlist", myfriend);
			req.setAttribute("possiblefriend", mypossiblefriend);
			req.setAttribute("whoaddme", whoaddme);
			memberlistVO = null;
			RequestDispatcher listgo = req.getRequestDispatcher("friend.jsp");
			listgo.forward(req, res);
		}
		
		/****加入好友****/
		if("add_Friend".equals(action)) {
			/****接受請求參數 錯誤驗證****/
			memberlistVO = (MemberlistVO) session.getAttribute("memberlistVO");
			if(memberlistVO==null) {
				res.sendRedirect("Login.jsp");
				return;
			}
			MemberlistRedisDAO dao = new MemberlistRedisDAO();
			String mem1_no = memberlistVO.getMem_no();
			String mem2_no = (String) req.getParameter("mem2_no");
			List<FriendVO> friendlist = service.findMyFriend(mem1_no);
			if(mem1_no==null || mem2_no==null) {
				req.setAttribute("status", "false");
				RequestDispatcher go = req.getRequestDispatcher("public_Member_page.jsp?mem_no="+mem2_no);
				go.forward(req, res);
				return;
			}
			/****驗證是否已是好友*****/
			for(FriendVO list : friendlist) {
				if(list.getMem1_no().equals(mem1_no)) {
					if(list.getMem2_no().equals(mem2_no)) {
						req.setAttribute("status", "duplicate");
						RequestDispatcher go = req.getRequestDispatcher("public_Member_page.jsp?mem_no="+mem2_no);
						go.forward(req, res);
						return;
					}
				}
				else if(list.getMem1_no().equals(mem2_no)) {
					if(list.getMem2_no().equals(mem1_no)) {
						req.setAttribute("status", "duplicate");
						RequestDispatcher go = req.getRequestDispatcher("public_Member_page.jsp?mem_no="+mem2_no);
						go.forward(req, res);
						return;
					}
				}
				else if(list.getMem2_no().equals(mem1_no)) {
					if(list.getMem1_no().equals(mem2_no)) {
						req.setAttribute("status", "duplicate");
						RequestDispatcher go = req.getRequestDispatcher("public_Member_page.jsp?mem_no="+mem2_no);
						go.forward(req, res);
						return;
					}
				}
				else if(list.getMem2_no().equals(mem2_no)) {
					if(list.getMem1_no().equals(mem1_no)) {
						req.setAttribute("status", "duplicate");
						RequestDispatcher go = req.getRequestDispatcher("public_Member_page.jsp?mem_no="+mem2_no);
						go.forward(req, res);
						return;
					}
				}
			}
			/****永續層存取 新增好友****/
			try {
				service.addFriend(mem1_no, mem2_no);
				req.setAttribute("status", "succeed");
				/****新增進Redis****/
				MemberlistService memberService = new MemberlistService();
				MemberlistVO member = memberService.getOneMem(mem1_no);
				String mem_name = member.getMem_name();
				if(dao.isOpen()&& mem_name!=null && mem2_no !=null) {
					dao.appendRedis(mem2_no,"notification","捧油加加",mem_name+" 想加你好友唷");
					System.out.println("insert into Redis succeed.");
				}
			} catch (RuntimeException re) {
				re.printStackTrace(System.err);
				req.setAttribute("status", "false");
				RequestDispatcher go = req.getRequestDispatcher("public_Member_page.jsp?mem_no="+mem2_no);
				go.forward(req, res);
				return;
			}
			if(memberlistVO!=null)
				memberlistVO = null;
			if(dao!=null)
				dao = null;
			req.setAttribute("status", "succeed");
			RequestDispatcher go = req.getRequestDispatcher("public_Member_page.jsp?mem_no="+mem2_no);
			go.forward(req, res);
			return;
		}
		
		/****刪除好友****/
		if("delete_Friend".equals(action)) {
			/****接受請求參數 錯誤驗證****/
			memberlistVO = (MemberlistVO) session.getAttribute("memberlistVO");
			if(memberlistVO==null) {
				res.sendRedirect("Login.jsp");
				return;
			}
			String mem1_no = memberlistVO.getMem_no();
			String mem2_no = (String) req.getParameter("mem2_no");
			System.out.println(mem1_no+","+mem2_no);
			List<FriendVO> friendlist = service.getAll();
			if(mem1_no==null || mem2_no==null) {
				req.setAttribute("status", "false");
				RequestDispatcher go = req.getRequestDispatcher("Friend.do?action=find_My_Friend");
				go.forward(req, res);
				System.out.println("找不到號碼");
				return;
			}
			Boolean isfriend=false;
			for(FriendVO list : friendlist) {
				if(list.getMem1_no().equals(mem1_no)) {
					if(list.getMem2_no().equals(mem2_no)) {
						isfriend=true;
						break;
					}
				}
				else if(list.getMem1_no().equals(mem2_no)) {
					if(list.getMem2_no().equals(mem1_no)) {
						isfriend=true;
						break;
					}
				}
			}
			if(isfriend) {
				try {
					service.deleteFriend(mem1_no, mem2_no);
					System.out.println("刪除好友成功");
				} catch (RuntimeException re) {
					re.printStackTrace(System.err);
					System.out.println("資料庫刪除不成功");
				}
			}else {
				req.setAttribute("status", "false");
				RequestDispatcher go = req.getRequestDispatcher("Friend.do?action=find_My_Friend");
				go.forward(req, res);
				System.out.println("無法刪除");
				return;
			}
			if(memberlistVO!=null)
				memberlistVO = null;
			req.setAttribute("status", "succeed");
			RequestDispatcher go = req.getRequestDispatcher("Friend.do?action=find_My_Friend");
			go.forward(req, res);
			return;
		}
		
		/****更新好友狀態****/
		if("update_Friend".equals(action)) {
			/****接受請求參數 錯誤驗證****/
			memberlistVO = (MemberlistVO) session.getAttribute("memberlistVO");
			if(memberlistVO==null) {
				res.sendRedirect("Login.jsp");
				return;
			}
			MemberlistRedisDAO dao = new MemberlistRedisDAO();
			String mem1_no = memberlistVO.getMem_no();
			String mem2_no = (String) req.getParameter("mem2_no");
			System.out.println(mem1_no+","+mem2_no);
			List<FriendVO> friendlist = service.getAll();
			if(mem1_no==null || mem2_no==null) {
				req.setAttribute("status", "false");
				RequestDispatcher go = req.getRequestDispatcher("Friend.do?action=find_My_Friend");
				go.forward(req, res);
				System.out.println("找不到號碼");
				return;
			}
			Boolean isfriend=false;
			for(FriendVO list : friendlist) {
				if(list.getMem1_no().equals(mem1_no)) {
					if(list.getMem2_no().equals(mem2_no)) {
						isfriend=true;
						break;
					}
				}
				else if(list.getMem1_no().equals(mem2_no)) {
					if(list.getMem2_no().equals(mem1_no)) {
						isfriend=true;
						break;
					}
				}
			}
			if(isfriend) {
				try{
					service.changeStatus(mem1_no, mem2_no, "好友");
					System.out.println("更新好友成功");
					/****更新Redis****/
					MemberlistService memberService = new MemberlistService();
					MemberlistVO member = memberService.getOneMem(mem2_no);
					String mem_name = member.getMem_name();
					System.out.println(mem2_no+","+mem_name);
					String name = null;
					if(dao.isOpen())
						name = dao.getValue(mem1_no);
					if(name.equals(mem_name)) {
						dao.deleteRedis(mem1_no, mem_name);
						System.out.println("delete data from Redis succeed.");
					}
				}catch(RuntimeException je) {
					je.printStackTrace(System.err);
					System.out.println("資料庫刪除不成功");
				}
			}else {
				System.out.println("無法更新好友");
			}
			if(memberlistVO!=null)
				memberlistVO = null;
			if(dao!= null)
				dao = null;
			req.setAttribute("status", "succeed");
			RequestDispatcher go = req.getRequestDispatcher("Friend.do?action=find_My_Friend");
			go.forward(req, res);
			return;
		}
	}

}
