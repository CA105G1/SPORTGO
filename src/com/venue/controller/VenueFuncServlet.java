package com.venue.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VenueFuncServlet extends HttpServlet {

	private static final String DB_ERROR_MSGS = "DataBaseError";
	private static final String ERRORMSGS_NO_TAB = "errorMsgs";
	private static final String VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT = "/front-end/venue/venue_query_info_by_composite_front.jsp";
	
	
	public VenueFuncServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		switch (action) {
		case "memEvaluateVenueInFrontEnd":
			doActionMemEvaluateVenue(request,response);
			break;

		default:
			break;
		}
		return;
	}
	
	private void doActionMemEvaluateVenue(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//memEvaluateVenueInFrontEnd
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_NO_TAB);
		try {
			/// 接收參數
			
			/// 確認參數

			/// 永續層
			
			/// 轉交
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS,e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT);
			failureView.forward(request, response);
			return;
		}
		
		
	}

	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName,String tabNum){
		Map<String, String> errorMsgs = new LinkedHashMap<>();
		request.setAttribute(titleName+tabNum, errorMsgs);
		return errorMsgs;
	}
	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName){
		return getErrorMsgsCollection(request,titleName,"");
	}
	
}
