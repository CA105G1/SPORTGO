package com.venue.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.news.model.NewsService;
import com.news.model.NewsVO;
import com.venue.model.VenueService;
import com.venue.model.VenueVO;
import com.venuetype.model.VenueTypeService;
import com.venuetype.model.VenueTypeVO;

public class VenueDeleteServlet extends HttpServlet {

	public static final String MAINTAIN_NEWS_INFO_INDEX_BACK_PATH = "/back-end/venue/maintain_venue_info_back.jsp"; 
	
	private static final String DB_ERROR_MSGS = "DataBaseError";
	
	private static final String WHITCH_TAB="whichTab";
	private static final String TAB_SELECT="tab1";
	
	private static final String ERRORMSGS_TITILE = "errorMsgs_";
	
    public VenueDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("this is VenueDeleteServlet");
		String action = request.getParameter("action");
		switch (action) {
		case "delete":
			request.setAttribute(WHITCH_TAB, TAB_SELECT);
			doActionDelete(request,response);
			break;

		default:
			break;
		}
	}
	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName,String tabNum){
		Map<String, String> errorMsgs = new LinkedHashMap<>();
		request.setAttribute(titleName+tabNum, errorMsgs);
		return errorMsgs;
	}
//	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName){
//		return getErrorMsgsCollection(request,titleName,"");
//	}
	
	private void doActionDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// delete
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITILE, TAB_SELECT);
		try {
			/// 確認參數
			String requestURL = request.getParameter("requestURL");
			String v_no = request.getParameter("v_no");
			
			/// DAO
			VenueService vneueService = new VenueService();
			VenueVO venueVO = vneueService.getOneVenue(v_no);
			VenueTypeService venueTypeService = new VenueTypeService();
			VenueTypeVO venueTypeVO = venueTypeService.getOneVenueTypeByPK(venueVO.getVt_no());
			vneueService.deleteVenue(v_no);
			////
			request.setAttribute("venueVO", venueVO);
			request.setAttribute("venueTypeVO", venueTypeVO);
			RequestDispatcher successView =	request.getRequestDispatcher(requestURL);
			successView.forward(request, response);
			return;
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS, e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			failureView.forward(request, response);
			return;
		}
		
		
		
	}
}
