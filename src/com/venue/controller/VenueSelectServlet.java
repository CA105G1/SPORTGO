package com.venue.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.imageio.spi.RegisterableService;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.region.model.RegService;
import com.region.model.RegVO;
import com.v_evaluation.model.V_evaluationService;
import com.venue.model.Util_Check_Venue_Parameter;
import com.venue.model.VenueService;
import com.venue.model.VenueVO;
import com.venuetype.model.VenueTypeService;
import com.venuetype.model.VenueTypeVO;

import oracle.net.aso.a;

public class VenueSelectServlet extends HttpServlet {

	private final String DB_ERROR_MSGS = "DataBaseError";
	
	private final String ERRORMSGS_NO_TAB = "errorMsgs";
	private final String ERRORMSGS_TITLE = "errorMsgs_";
	
	private final String VENUEVO_FOR_ERROR_NAME_TITLE = "venueVO_";
	private final String VENUEVO_FOR_SHOW_ONE_NAME = "venueVO";
	
	private final String WHITCH_TAB = "whichTab";
	private final String TAB_SELECT = "tab1";
	private final String TAB_CREATE = "tab2";
	private final String TAB_UPDATE = "tab3";
	
	private final String MAINTAIN_VENUE_INFO_BACK ="/back-end/venue/maintain_venue_info_back.jsp";
	private final String VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT = "/front-end/venue/venue_query_info_by_composite_front.jsp";
	private final String VENUE_QUERY_INFO_BY_MAP_FRONT = "/front-end/venue/venue_query_info_by_map_front.jsp";

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
			
	//		case "get_all_venue":
	//			System.out.println("there are no get_all_venue action");
	//			break;
			case "update_reset":
			case "updateForQueryOneVenue":
				request.setAttribute(WHITCH_TAB, TAB_UPDATE);
				doActionGetOneVenueOrForUpdate(request, response, 
										MAINTAIN_VENUE_INFO_BACK,	// goToLoaclUrl_forSuccess
										MAINTAIN_VENUE_INFO_BACK, 	// goToLacalUrl_forError
										TAB_UPDATE, 				// whichTab_forErrorMsgs
										VENUEVO_FOR_ERROR_NAME_TITLE+TAB_UPDATE, // venueVO4RawUpdateOrError
										false); // isFront
				break;
			case "show_one_venue_back":
				request.setAttribute(WHITCH_TAB, TAB_SELECT);
				doActionGetOneVenueOrForUpdate(request, response, 
										MAINTAIN_VENUE_INFO_BACK, 	// goToLoaclUrl_forSuccess
										MAINTAIN_VENUE_INFO_BACK, 	// goToLacalUrl_forError
										TAB_SELECT, 				// whichTab_forErrorMsgs
										VENUEVO_FOR_SHOW_ONE_NAME,	// venueVO4RawUpdateOrError
										false);						// isFront
				break;
			case "listVenueByCompositeQuery":
				request.setAttribute(WHITCH_TAB, TAB_SELECT);
	//			doActionListVenueByCompsiteQuery(request,response);
				doActionListVenueByCompsiteQuery_FrontOrBack(request, response, MAINTAIN_VENUE_INFO_BACK, TAB_SELECT, false);
				break;
			case "listVenueByCompostieQueryForFrontEnd":
	//			doActionListVenueByCompsiteQueryForFrontEnd(request, response);
				doActionListVenueByCompsiteQuery_FrontOrBack(request, response, VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT, TAB_SELECT, true);
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
	
	private void doActionListVenueByCompsiteQuery_FrontOrBack(HttpServletRequest request, HttpServletResponse response, String goToLocalUrl, String whichTab_forErrorMsgs, boolean isFrontEnd) throws ServletException,IOException{
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_NO_TAB);
		try {
			// 1.將輸入Data轉成為MAP
			HttpSession session = request.getSession();
			@SuppressWarnings("unchecked")
			Map<String, String[]> venueMap = (Map<String, String[]>)session.getAttribute("venueMap");
			if(request.getParameter("whichPage")==null || "".equals(request.getParameter("whichPage"))) {
				HashMap<String, String[]> getMap = new HashMap<String, String[]>(request.getParameterMap());
Set<String> set = getMap.keySet();
for(String aStrings : set) {
	System.out.println(aStrings+" = "+getMap.get(aStrings)[0]);
}
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
	
	private void doActionGetOneVenueOrForUpdate(HttpServletRequest request, HttpServletResponse response, 
												String goToLoaclUrl_forSuccess, String goToLacalUrl_forError,
												String whichTab_forErrorMsgs, String venueVO4RawUpdateOrError,
												boolean isFrontEnd) throws ServletException, IOException{
		//show_one_venue_back
		Map<String,String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITLE, whichTab_forErrorMsgs);
		try {
			//////// 確認參數
			String v_no = request.getParameter("v_no");
			
			/////// DAO
			VenueService service = new VenueService();
			VenueVO venueVO = service.getOneVenue(v_no);
			VenueTypeService venueTypeService = new VenueTypeService();
			VenueTypeVO venueTypeVO = venueTypeService.getOneVenueTypeByPK(venueVO.getVt_no());
			RegService regService = new RegService();
			RegVO regVO = regService.getRegVOByPK(venueVO.getReg_no());
			V_evaluationService v_evaluationService = new V_evaluationService();
			Double venue_score = v_evaluationService.getOneVenueScore(venueVO.getV_no());
			
			///////
			request.setAttribute(venueVO4RawUpdateOrError, venueVO);
			request.setAttribute("venueTypeVO", venueTypeVO);
			request.setAttribute("regVO", regVO);
			request.setAttribute("venue_score", venue_score);
			RequestDispatcher successView = request.getRequestDispatcher(goToLoaclUrl_forSuccess);
			successView.forward(request, response);
			return;
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS,"取得資料失敗: "+e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(goToLacalUrl_forError);
			failureView.forward(request, response);
			return;
		}	
	}
	
}
