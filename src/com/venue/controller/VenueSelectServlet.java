package com.venue.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.v_evaluation.model.V_evaluationService;
import com.venue.model.Util_Check_Venue_Parameter;
import com.venue.model.VenueService;
import com.venue.model.VenueVO;
import com.venuetype.model.VenueTypeService;
import com.venuetype.model.VenueTypeVO;

public class VenueSelectServlet extends HttpServlet {

	private static final String DB_ERROR_MSGS = "DataBaseError";
	private static final String ERRORMSGS_NO_TAB = "errorMsgs";
	private static final String VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT = "/front-end/venue/venue_query_info_by_composite_front.jsp";
	private static final String VENUE_QUERY_INFO_BY_COMPOSITE_BACK ="/back-end/venue/maintain_venue_info_back.jsp";
//	private static final String QUERY_ONe_INFO_BY_COMPOSITE_BACK ="/back-end/venue/maintain_venue_info_back.jsp";
	
	public VenueSelectServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("This is VenueSelectServlet");
		String action = request.getParameter("action");
		switch (action) {
		case "get_all_venue":
			System.out.println("there are no get_all_venue action");
			break;
		case "get_one_venue":
			
			break;
		case "listVenueByCompositeQuery":
//			doActionListVenueByCompsiteQuery(request,response);
			doActionListVenueByCompsiteQuery_FrontOrBack(request, response, VENUE_QUERY_INFO_BY_COMPOSITE_BACK, false);
			break;
		case "listVenueByCompostieQueryForFrontEnd":
//			doActionListVenueByCompsiteQueryForFrontEnd(request, response);
			doActionListVenueByCompsiteQuery_FrontOrBack(request, response, VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT, true);
			break;
		default:
			break;
		}
		return;
	}


	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName,String tabNum){
		Map<String, String> errorMsgs = new LinkedHashMap<>();
		request.setAttribute(titleName+tabNum, errorMsgs);
		return errorMsgs;
	}
	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName){
		return getErrorMsgsCollection(request,titleName,"");
	}
	
/*  private void doActionListVenueByCompsiteQuery(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		//listVenueByCompositeQuery
		doActionListVenueByCompsiteQuery_FrontAndBack(request, response, VENUE_QUERY_INFO_BY_COMPOSITE_BACK);
	}
*******************************************************************/
/*	private void doActionListVenueByCompsiteQueryForFrontEnd(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		//listVenueByCompostieQueryForFrontEnd
		doActionListVenueByCompsiteQuery_FrontAndBack(request, response, VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT);
	}
*******************************************************************/
	private void doActionListVenueByCompsiteQuery_FrontOrBack(HttpServletRequest request,HttpServletResponse response,String goToLocalUrl,boolean isFrontEnd) throws ServletException,IOException{
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_NO_TAB);
		try {
			// 1.將輸入Data轉成為MAP
			HttpSession session = request.getSession();
			@SuppressWarnings("unchecked")
			Map<String, String[]> venueMap = (Map<String, String[]>)session.getAttribute("venueMap");
			if(request.getParameter("whichPage")==null) {
				HashMap<String, String[]> getMap = new HashMap<String, String[]>(request.getParameterMap());
				session.setAttribute("venueMap", getMap);
				venueMap = getMap;
			}
			// 1.5 check map
			venueMap = Util_Check_Venue_Parameter.checkVenueMap(venueMap, errorMsgs);
			if(!errorMsgs.isEmpty()) {
				List<VenueVO> list = new ArrayList<>();
				showVenueListAndForward(list, null, null, goToLocalUrl, request, response);
				return;
			}
			//2.
			VenueService venueService = new VenueService();
			List<VenueVO> list = venueService.getAll(venueMap,isFrontEnd);
			VenueTypeService venueTypeService = new VenueTypeService();
			List<VenueTypeVO> venueTypeVOList = venueTypeService.getAll();
			V_evaluationService v_evaluationService = new V_evaluationService();
			Map<String, Double> scoreMap = v_evaluationService.getVenueScoreMapByVenueVO(list);
//			/// note that if scoreMap.getXX=-1 means there are no score
			//3.
			showVenueListAndForward(list, venueTypeVOList, scoreMap, goToLocalUrl, request, response);
			return;
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS,e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(goToLocalUrl);
			failureView.forward(request, response);
			return;
		}
	}
	
	private void showVenueListAndForward(List<VenueVO> list, List<VenueTypeVO> venueTypeVOList, Map<String, Double> scoreMap,String whereUrl,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setAttribute("myList", list);
		request.setAttribute("venueTypeVOList", venueTypeVOList);
		request.setAttribute("scoreMap", scoreMap);
		RequestDispatcher successView = request.getRequestDispatcher(whereUrl);
		successView.forward(request, response);
	}
	
}
