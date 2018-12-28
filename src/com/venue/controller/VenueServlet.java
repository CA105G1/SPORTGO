package com.venue.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
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
	private static final String UPDATE_FOR_QUERY_PATH = "/back-end/venue/updateVenue.jsp";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		
		if(action!=null) {
			switch (action) {
			case "get_all_venue":
				doActionGetAllVenue(action, request, response);
				break;
			case "get_one_venue":
				doActionGetOneVenue(action, request, response);
				break;
			case "delete":
				doActionDelete(action, request, response);
				break;
			case "updateForQuery":
				doActionUpdateForQuery(action, request, response);
				break;
			case "update_cancel":
				doActionUpdateCancel(action, request, response);
				break;
			case "update_reset":
				doActionUpdateReset(action, request,response);
				break;				
			case "update_commit":
				doActionUpdateCommit(action, request,response);
				break;				
			default:
				System.out.println("In this venueServlet, there are no "+action+".");
			}
		}
		
	}
	
	
	private List<String> getErrorMsgsCollection(HttpServletRequest request){
		List<String> errorMsgs = new LinkedList<>();
		request.setAttribute("errorMsgs", errorMsgs);
		return errorMsgs;
	}
	
	private void doActionGetAllVenue(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
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
				request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
				//request.getRequestDispatcher(SUCCESS_GET_ONE_SHOW_PATH);
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
	
	private void doActionGetOneVenue(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
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
	
	private void doActionDelete(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
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
	
	private void doActionUpdateForQuery(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
		try {
			////// don't need check
			String v_no = request.getParameter("v_no");
			////// 
			VenueService service = new VenueService();
			VenueVO venueVO = service.getOneVenue(v_no);
			
			////
			request.setAttribute("venueVO", venueVO);
			RequestDispatcher successView = 
					request.getRequestDispatcher(UPDATE_FOR_QUERY_PATH);
			successView.forward(request, response);
			return;
		}catch (Exception e) {
			errorMsgs.add("請求更新資料失敗: "+e.getMessage());
			RequestDispatcher failureView = 
					request.getRequestDispatcher(MAINTAIN_VENUE_INFO_INDEX_PATH);
			failureView.forward(request, response);
			return;
		}
	}
	
	private void doActionUpdateCancel(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
		try {
			String v_no = request.getParameter("v_no");
			action = "get_one_venue";
			request.setAttribute("resultAction",action);
			// reback home and show this venue
			String appendUrl = "?action="+action+"&v_no="+v_no;
			RequestDispatcher rebackView = 
					request.getRequestDispatcher(request.getServletPath()+appendUrl);
			rebackView.forward(request, response);
			return;
		}catch (Exception e) {
			errorMsgs.add("取消更新資料失敗: "+e.getMessage());
			RequestDispatcher failureView = 
					request.getRequestDispatcher(UPDATE_FOR_QUERY_PATH);
			failureView.forward(request, response);
			return;
		}
	}
	
	private void doActionUpdateReset(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
		try {
			////don't need check
			String v_no = request.getParameter("v_no");
			action = "updateForQuery";
			//request.setAttribute("resultAction",action);
			// reback home and show this venue
			String appendUrl = "?action="+action+"&v_no="+v_no;
			RequestDispatcher resetView = 
					request.getRequestDispatcher(request.getServletPath()+appendUrl);
			resetView.forward(request, response);
			return;
		}catch (Exception e) {
			errorMsgs.add("重啟更新資料失敗: "+e.getMessage());
			RequestDispatcher failureView = 
					request.getRequestDispatcher(UPDATE_FOR_QUERY_PATH);
			failureView.forward(request, response);
			return;
		}
	}
	
	private void doActionUpdateCommit(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
//		List<String> errorMsgs = getErrorMsgsCollection(request);
//		try {
//			// commit input date is corrected
//			String v_no = request.getParameter("v_no");
//			String v_address = request.getParameter("v_address");
//			String v_phoneno = request.getParameter("v_phoneno");
//			String v_status = request.getParameter("v_status");
//			// take original object by v_no
//			VenueService service = new VenueService();
//			VenueVO venueVO = service.getOneVenue(v_no);
//			/// set what is changed
//			venueVO.setV_address(v_address);
//			venueVO.setV_phoneno(v_phoneno);
//			venueVO.setV_status(v_status);
//			///
//			service.updateVenue(venueVO.getV_no(), venueVO.getV_name(), venueVO.getVt_no(),
//					venueVO.getReg_no(), venueVO.getV_lat(), venueVO.getV_long(), 
//					venueVO.getV_pic(), venueVO.getV_address(), venueVO.getV_phoneno(), 
//					venueVO.getV_status(), venueVO.getV_func());
//			
//			/////
//			action = "get_one_venue";
//			String appendUrl = "?action="+action+"&v_no="+venueVO.getV_no();
//			RequestDispatcher rebackView = 
//					request.getRequestDispatcher(request.getServletPath()+appendUrl);
//			rebackView.forward(request, response);
//			return;
//		}catch (Exception e) {
//			errorMsgs.add("確認更新資料失敗: "+e.getMessage());
//			RequestDispatcher failureView = 
//					request.getRequestDispatcher(UPDATE_FOR_QUERY_PATH);
//			failureView.forward(request, response);
//			return;
//		}
	}
}
