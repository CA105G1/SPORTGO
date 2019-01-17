package com.post_info.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.HTTP;

import com.club.model.ClubService;
import com.club.model.ClubVO;
import com.memberlist.model.MemberlistVO;
import com.post_info.model.Post_infoService;
import com.post_info.model.Post_infoVO;
import com.respones.model.ResponesService;
import com.respones.model.ResponesVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class Post_infoServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	public Post_infoServlet(){
		super(); 
	}
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String CLUBPAGE = "/front-end/club/club_page.jsp";
		String CREATEPOST = "/front-end/post_info/create_post.jsp";
		String EDITPOST = "/front-end/post_info/edit_post.jsp";
		
//顯示貼文
if ("getOnePost_display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String post_no = req.getParameter("post_no");
				/***************************2.開始查詢資料*****************************************/
				Post_infoService post_infoSvc = new Post_infoService();
				Post_infoVO post_infoVO = post_infoSvc.getOnePost_info(post_no);
				
				ResponesService respones = new ResponesService();
				List<ResponesVO> responesvolist = respones.getallfrompost(post_no);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("responesvolist", responesvolist);
				req.setAttribute("post_infoVO", post_infoVO); 
				String url = EDITPOST;
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(CLUBPAGE);
				failureView.forward(req, res);
			}
		}
		

//修改貼文	
if ("update".equals(action)) { 
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String requestURL = req.getParameter("requestURL");
			HttpSession session = req.getSession();
			String memberlist_mem_no = (String)session.getAttribute("mem_no");
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String post_no = req.getParameter("post_no");
				
				String club_no = req.getParameter("club_no");
				
				String mem_no = req.getParameter("mem_no");
				
				String post_topic = req.getParameter("post_topic").trim();
				if (post_topic == null || post_topic.trim().length() == 0) {
					errorMsgs.add("貼文主題請勿空白");
				}	
				String post_content = req.getParameter("editor").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}	
				Timestamp post_date = new Timestamp(System.currentTimeMillis());

				Post_infoVO post_infoVO = new Post_infoVO();
				post_infoVO.setPost_no(post_no);
				post_infoVO.setClub_no(club_no);
				post_infoVO.setMem_no(mem_no);
				post_infoVO.setPost_topic(post_topic);
				post_infoVO.setPost_content(post_content);
				post_infoVO.setPost_date(post_date);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("post_infoVO", post_infoVO); 
					RequestDispatcher failureView = req
							.getRequestDispatcher(EDITPOST);
					failureView.forward(req, res);
					return; //程式中斷
				}
				/***************************2.開始新增資料***************************************/
				Post_infoService post_infoSvc = new Post_infoService();
				post_infoVO = post_infoSvc.updatePost_info(post_no, club_no, mem_no, post_topic, post_content, post_date);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("post_infoVO", post_infoVO);
				String url = (CLUBPAGE+"?"+club_no);
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(EDITPOST);
				failureView.forward(req, res);
			}
		}

//新增貼文
if ("insert".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String club_no = req.getParameter("club_no");
				
				String mem_no = req.getParameter("mem_no");
				
				String post_topic = req.getParameter("post_topic").trim();
				if (post_topic == null || post_topic.trim().length() == 0) {
					errorMsgs.add("貼文主題請勿空白");
				}	
				String post_content = req.getParameter("editor").trim();
				if (post_content == null || post_content.trim().length() == 0) {
					errorMsgs.add("貼文內容請勿空白");
				}	
				Timestamp post_date = new Timestamp(System.currentTimeMillis());
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(CREATEPOST+"?"+club_no);
					failureView.forward(req, res);
					return;
				}
				/***************************2.開始新增資料***************************************/
				Post_infoService post_infoSvc = new Post_infoService();
				Post_infoVO post_infoVO = post_infoSvc.addPost_info(club_no, mem_no, post_topic, post_content,post_date);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				req.setAttribute("post_infoVO", post_infoVO);
				String url = (CLUBPAGE+"?"+club_no);
				RequestDispatcher successView = req.getRequestDispatcher(url); 
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(CREATEPOST);
				failureView.forward(req, res);
			}
		}

//刪除貼文
if ("delete".equals(action)) { 
	
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
//		 	ResponesVO responesVO = (ResponesVO)req.getAttribute("responesVO");
//		 	Post_infoVO post_infoVO = (Post_infoVO)req.getAttribute("post_infoVO");
		try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			String post_no = req.getParameter("post_no");
		/***************************2.開始查詢資料*****************************************/
			ResponesService responesSvc=new ResponesService();
			responesSvc.deleteBypost_no(post_no);
			Post_infoService post_infoSvc = new Post_infoService();
			post_infoSvc.deletePost(post_no);
			Post_infoVO post_infoVO=post_infoSvc.getOnePost_info(post_no);
			
		
		/***************************3.查詢完成,準備轉交(Send the Success view)*************/
			req.setAttribute("post_infoVO", post_infoVO); 
			RequestDispatcher successView = req.getRequestDispatcher(CLUBPAGE); 
			successView.forward(req, res);

		/***************************其他可能的錯誤處理*************************************/
		} catch (Exception e) {
			errorMsgs.add("無法取得資料:" + e.getMessage());
			RequestDispatcher failureView = req
					.getRequestDispatcher(CLUBPAGE);
			failureView.forward(req, res);
		}
		}

//查詢貼文
if("postCompositeQuery".equals(action)) {
	List<String> errorMsg = new LinkedList<String>();
	req.setAttribute("errorMsg", errorMsg);
	
	try {
		///////////將查詢資料轉為MAP///////////////////
//		Map<String, String[]> map = req.getParameterMap();
		HttpSession session = req.getSession();
		Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
		if (req.getParameter("whichPage") == null){
		HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
		session.setAttribute("map",map1);
			map = map1;
		} 
		
		///////////開始查詢/////////////////////
		//若抓不到map就代表不是複合查詢
		if(map != null) {
			ClubService svc = new ClubService();
			List<ClubVO> list = svc.getAll(map);
			///////////轉交資料/////////////////////
			req.setAttribute("list", list);
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher(CLUBPAGE);
		dispatcher.forward(req, res);
		
	}catch(Exception e) {
		errorMsg.add(e.getMessage());
		RequestDispatcher dispatcher = req.getRequestDispatcher(CLUBPAGE);
		dispatcher.forward(req, res);
	}
}
		
	}
}

