package com.club_memberlist.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
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

import org.json.JSONException;
import org.json.JSONObject;

import com.club_memberlist.model.Club_memberlistService;
import com.club_memberlist.model.Club_memberlistVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class Club_memberlistServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private static final String REVIEWADDCLUB_PATH = "/front-end/club_memberlist/reviewaddclub.jsp";
	private static final String CLUBLIST_PATH = "/front-end/club/club_list.jsp";
	private static final String CLUBPAGE_PATH = "/front-end/club/club_page.jsp";
	
	
	
	public Club_memberlistServlet(){
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
		PrintWriter pw = res.getWriter();
		System.out.println("Club_memberListServlet--- action : "+action);

//變更社團成員權限
if ("setCmem_class".equals(action)) { 
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);

	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String club_no = req.getParameter("club_no");
		String mem_no =  req.getParameter("mem_no");
		String cmem_class =  req.getParameter("cmem_class");
		
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		club_memberlistSvc.updateClass(club_no, mem_no, cmem_class);
		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/

		JSONObject obj = new JSONObject();
		try {
			obj.put("answer", "OK");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pw.write(obj.toString());
	

		/***************************其他可能的錯誤處理*************************************/
	} catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("/front-end/club_memberlist/reviewaddclub.jsp");
		failureView.forward(req, res);
	}
}

//加入社團
if ("addintoclub".equals(action)) { 
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	String location = req.getParameter("location");
	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String club_no = req.getParameter("club_no");
		String mem_no = req.getParameter("mem_no");
		
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistVO club_memberlistVO = new Club_memberlistVO();
		
		club_memberlistVO.setClub_no(club_no);
		club_memberlistVO.setMem_no(mem_no);
		
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		club_memberlistVO = club_memberlistSvc.addintoclub(club_no, mem_no);
		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/

		JSONObject obj = new JSONObject();
		try {
			obj.put("answer", "OK");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pw.write(obj.toString());
		
//		req.setAttribute("Club_memberlistVO", club_memberlistVO);
//		RequestDispatcher successView = req.getRequestDispatcher(URI);   // 修改成功後,轉交回送出修改的來源網頁
//		successView.forward(req, res);
		
	

		/***************************其他可能的錯誤處理*************************************/
	} catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher(location);
		failureView.forward(req, res);
	}
}



//審核社團加入申請
if("isJoinClub".equals(action)) {
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	
	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String result = req.getParameter("result");
		String club_no = req.getParameter("club_no");
		String mem_no = req.getParameter("mem_no");
		String cmem_status = null;
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		if("agree".equals(result)) {
			cmem_status = "正式社員";
			club_memberlistSvc.updateStatus(club_no, mem_no, cmem_status);
		}else if("disagree".equals(result)) {
			club_memberlistSvc.dropoutclub(club_no, mem_no);
		}
		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/
		res.sendRedirect(req.getContextPath()+"/front-end/club_memberlist/reviewaddclub.jsp");
		//使用重導，若使用forward會出現亂碼
//		RequestDispatcher successView = req.getRequestDispatcher("/front-end/club_memberlist/reviewaddclub.jsp");   // 修改成功後,轉交回送出修改的來源網頁
//		successView.forward(req, res);
		
		/***************************其他可能的錯誤處理*************************************/
	}catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("/front-end/club_memberlist/reviewaddclub.jsp");
		failureView.forward(req, res);
	}
}






//退出社團
if ("dropoutclub".equals(action)) { 
	
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	String location = req.getParameter("location");

	try {
		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
		
		String club_no = req.getParameter("club_no");
		String mem_no = req.getParameter("mem_no");
//		Club_memberlistVO club_memberlistVO = new Club_memberlistVO();
//		
//		club_memberlistVO.setClub_no(club_no);
//		club_memberlistVO.setMem_no(mem_no);
		
		/***************************2.開始修改資料*****************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		club_memberlistSvc.dropoutclub(club_no, mem_no);

		
		/***************************3.修改完成,準備轉交(Send the Success view)*************/

		JSONObject obj = new JSONObject();
		try {
			obj.put("answer", "OK");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		pw.write(obj.toString());
	

		/***************************其他可能的錯誤處理*************************************/
	} catch (Exception e) {
		errorMsgs.add("修改資料失敗:"+e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher(location);
		failureView.forward(req, res);
	}
}
//顯示社團成員列表
//if ("cmem_list".equals(action)) { 
//	
//	List<String> errorMsgs = new LinkedList<String>();
//	req.setAttribute("errorMsgs", errorMsgs);
//	String requestURL = req.getParameter("requestURL");
//
//	try {
//		/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//		
//		String club_no = req.getParameter("club_no");
//		String mem_no =  req.getParameter("mem_no");
//		String cmem_class = req.getParameter("cmem_class");
//		
//		
//		Club_memberlistVO club_memberlistVO = new Club_memberlistVO();
//		
//		club_memberlistVO.setClub_no(club_no);
//		club_memberlistVO.setMem_no(mem_no);
//		club_memberlistVO.setCmem_class(cmem_class);
//		
//		/***************************2.開始修改資料*****************************************/
//		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
//		club_memberlistVO = club_memberlistSvc.cmem_list(club_no, mem_no,cmem_class);
//		
//		/***************************3.修改完成,準備轉交(Send the Success view)*************/
//
//		req.setAttribute("Club_memberlistVO", club_memberlistVO);
//		String url = requestURL;
//		RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
//		successView.forward(req, res);
//	
//		/***************************其他可能的錯誤處理*************************************/
//	} catch (Exception e) {
//		errorMsgs.add("修改資料失敗:"+e.getMessage());
//		RequestDispatcher failureView = req
//				.getRequestDispatcher(CLUBPAGE_PATH);
//		failureView.forward(req, res);
//	}
//}


if ("Clubmemberlist_CompositeQuery".equals(action)) { // 來自select_page.jsp的複合查詢請求
	List<String> errorMsgs = new LinkedList<String>();
	// Store this set in the request scope, in case we need to
	// send the ErrorPage view.
	req.setAttribute("errorMsgs", errorMsgs);

	try {
		
		/***************************1.將輸入資料轉為Map**********************************/ 
		//採用Map<String,String[]> getParameterMap()的方法 
		//注意:an immutable java.util.Map 
		Map<String, String[]> map = req.getParameterMap();
		
		/***************************2.開始複合查詢***************************************/
		Club_memberlistService club_memberlistSvc = new Club_memberlistService();
		List<Club_memberlistVO> list  = club_memberlistSvc.getAll(map);
		
		/***************************3.查詢完成,準備轉交(Send the Success view)************/
		req.setAttribute("listClubmemberlist_ByCompositeQuery", list); // 資料庫取出的list物件,存入request
		RequestDispatcher successView = req.getRequestDispatcher("/club_memberlistSvc/ClubmemberlistQuery_Clubmemberlist.jsp"); // 成功轉交listEmps_ByCompositeQuery.jsp
		successView.forward(req, res);
		
		/***************************其他可能的錯誤處理**********************************/
	} catch (Exception e) {
		errorMsgs.add(e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("/select_page.jsp");
		failureView.forward(req, res);
	}
}

		
	}
}

