package com.venue.controller;

import java.io.IOException;
import java.util.Enumeration;
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
import com.v_evaluation.model.V_evaluationVO;
import com.venue.model.Util_Check_Venue_Parameter;
import com.venue.model.VenueService;
import com.venue.model.VenueVO;
import com.venuetype.model.VenueTypeService;
import com.venuetype.model.VenueTypeVO;

public class VenueFuncServlet extends HttpServlet {

	private final String DB_ERROR_MSGS = "DataBaseError";
	private final String ERRORMSGS_NO_TAB = "errorMsgs";
	private final String VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT = "/front-end/venue/venue_query_info_by_composite_front.jsp";
	
	
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
			/// 接收參數，因為參數都是系統給暫時不驗證
//			Enumeration<String> enumeration = request.getParameterNames();
//			while(enumeration.hasMoreElements()) {
//				String name = (String)enumeration.nextElement();
//				String values[] = request.getParameterValues(name);
//				if(values!=null) {
//					for(int i = 0 ; i<values.length ; i++ ) {
//						System.out.println(name+"["+i+"] : "+values[i]);
//					}
//				}
//			}
			String v_no = request.getParameter("v_no");
			String mem_no = request.getParameter("mem_no");
			String requestURL = request.getParameter("requestURL");
			String whichPage = request.getParameter("whichPage");
			String score = request.getParameter("score");
//	System.out.println("score : "+score);//////////////////////////////////////////
			/// 永續層 1
			V_evaluationService v_evaluationService = new V_evaluationService();
			V_evaluationVO v_evaluationVO = null;
			if(score!=null) {
				v_evaluationService.insertOrUpdate(mem_no, v_no, new Integer(score));
				v_evaluationVO = new V_evaluationVO();
				v_evaluationVO.setMem_no(mem_no);
				v_evaluationVO.setV_no(v_no);
				v_evaluationVO.setScore(new Integer(score));
			}
			/// 永續層 2--->參考VenueSelectServlet-->"listVenueByCompostieQueryForFrontEnd"
			
			HttpSession session = request.getSession();
			@SuppressWarnings("unchecked")
			Map<String, String[]> venueMap = (Map<String, String[]>)session.getAttribute("venueMap");
			
			VenueService venueService = new VenueService();
			List<VenueVO> list = venueService.getAll(venueMap,true);
			VenueTypeService venueTypeService = new VenueTypeService();
			List<VenueTypeVO> venueTypeVOList = venueTypeService.getAll();
			v_evaluationService = new V_evaluationService();
			Map<String, Double> scoreMap = v_evaluationService.getVenueScoreMapByVenueVO(list);
			
			/// 轉交
			request.setAttribute("v_evaluationVO", v_evaluationVO);
			showVenueListAndForward(list, venueTypeVOList, scoreMap, requestURL, request, response);
			return;
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS,e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT);
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

	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName,String tabNum){
		Map<String, String> errorMsgs = new LinkedHashMap<>();
		request.setAttribute(titleName+tabNum, errorMsgs);
		return errorMsgs;
	}
	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName){
		return getErrorMsgsCollection(request,titleName,"");
	}
	
}
