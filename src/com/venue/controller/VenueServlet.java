package com.venue.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.venue.model.VenueService;
import com.venue.model.VenueVO;

public class VenueServlet extends HttpServlet {
	
	public VenueServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	private static final String MAINTAIN_VENUE_INFO_INDEX_PATH="/back-end/venue/maintainVenueInfoIndex.jsp";
	private static final String SUCCESS_GET_ONE_SHOW_PATH = "/back-end/venue/listOneVenue.jsp";
	private static final String LIST_ALL_VENUE_PATH = "/back-end/venue/listAllVenue.jsp";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if("get_all_venue".equals(action)) {
			List<String> errorMsgs = new LinkedList<>();
			request.setAttribute("errorMsgs", errorMsgs);
			try {
			//////there is no error check.
			//////
			VenueService service = new VenueService();
			List<VenueVO> list = service.getAll();
			
			//////
			String whichPage = request.getParameter("whichPage");
			
			request.setAttribute("myList", list);
			request.setAttribute("resultAction",action);
			request.setAttribute("whichPage", whichPage);
			RequestDispatcher successView = 
					//request.getRequestDispatcher(SUCCESS_GET_ONE_SHOW_PATH);
					request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
			successView.forward(request, response);
			return;
			
			}catch (Exception e) {
				errorMsgs.add("取得資料失敗: "+e.getMessage());
				RequestDispatcher failureView = 
						request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
				failureView.forward(request, response);
				return;
			}
		}
		
		if("get_one_venue".equals(action)) {
			List<String> errorMsgs = new LinkedList<>();
			request.setAttribute("errorMsgs", errorMsgs);
			try {
				////////
				String v_no = request.getParameter("v_no");
				String v_noReg = "^[V][0-9]{6}$";
				if(v_no == null || v_no.trim().length()==0) {
					errorMsgs.add("請輸入場地編號");
				}else if(!v_no.trim().matches(v_noReg)) {
					errorMsgs.add("正規判斷---場地編號，格式不符，如:V000001");
				}
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = 
							request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
					failureView.forward(request, response);
					return;
				}
				///////
				VenueService service = new VenueService();
				VenueVO venueVO = service.getOneVenue(v_no);
				if(venueVO==null) {
					errorMsgs.add("查無資料");
				}
				if(!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = 
							request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
					failureView.forward(request, response);
					return;
				}
				///////
				request.setAttribute("venueVO", venueVO);
				request.setAttribute("resultAction",action);
				RequestDispatcher successView = 
						//request.getRequestDispatcher(SUCCESS_GET_ONE_SHOW_PATH);
						request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
				successView.forward(request, response);
				return;
			}catch (Exception e) {
				errorMsgs.add("取得資料失敗: "+e.getMessage());
				RequestDispatcher failureView = 
						request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
				failureView.forward(request, response);
				return;
			}
			
			
		}
		
		if("update".equals(action)) {
			System.out.println("action : "+action);
			
			
			
			
			
			
			RequestDispatcher successView = 
					request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
			successView.forward(request, response);
			return;
		}
		
		if("delete".equals(action)) {
			List<String> errorMsgs = new LinkedList<>();
			request.setAttribute("errorMsgs", errorMsgs);
			try {
				String v_no = (String)request.getParameter("v_no");
				VenueService service = new VenueService();
				service.deleteVenue(v_no);
				
				request.setAttribute("resultAction", "success_delete");
				request.setAttribute("showDeleteResult", v_no+"成功刪除。");
				
				
				RequestDispatcher successView = 
						request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
				successView.forward(request, response);
				return;
			}catch (Exception e) {
				errorMsgs.add("刪除資料失敗: "+e.getMessage());
				RequestDispatcher failureView = 
						request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
				failureView.forward(request, response);
				return;
			}
			
			
			
			
		}
	
	}

}
