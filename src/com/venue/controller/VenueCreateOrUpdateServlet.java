package com.venue.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Handler;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.venue.model.VenueService;
import com.venue.model.VenueVO;
//TODO: 地址，電話，緯經度，驗證
public class VenueCreateOrUpdateServlet extends HttpServlet {
	
	private static final String DB_ERROR_MSGS = "DataBaseError";
	
	//private static final String ERRORMSGS_NO_TAB = "errorMsgs";
	private static final String ERRORMSGS_TITLE = "errorMsgs_";
	
	private static final String WHITCH_TAB = "whichTab";
	private static final String TAB_SELECT = "tab1";
	private static final String TAB_CREATE = "tab2";
	private static final String TAB_UPDATE = "tab3";
	
	private static final String VENUEVO_FOR_ERROR_NAME_TITLE = "venueVO_";
	
	private static final String MAINTAIN_VENUE_INFO_BACK = "/back-end/venue/maintain_venue_info_back.jsp";
	private static final String QUERY_SUPER_SERVLET_ACTION_AGAIN = "/venue/venue.do?action=";
	//private static final String VENUE_QUERY_INFO_BY_COMPOSTIE_FRONT = "/front-end/venue/venue_query_info_by_composite_front.jsp";
	//private static final String VENUE_QUERY_INFO_BY_MAP_FRONT = "/front-end/venue/venue_query_info_by_map_front.jsp";

	
	public VenueCreateOrUpdateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		System.out.println("this is VenueCreateOrUpdate");
		String action = request.getParameter("action");
		switch (action) {		
			case "insert_one_venue":
				// remark:
				// OK---> // request.setAttribute(WHITCH_TAB, TAB_SELECT);
				// Error---> // request.setAttribute(WHITCH_TAB, TAB_CREATE);
				doActionInsertOneVenue(request, response, 
						QUERY_SUPER_SERVLET_ACTION_AGAIN +"show_one_venue_back&v_no=", // goToLocalUrl_forSuccess
						TAB_SELECT, // whichTab_forSuccess
						MAINTAIN_VENUE_INFO_BACK,  // goToLocalUrl_forError
						TAB_CREATE, // whichTab_forError
						VENUEVO_FOR_ERROR_NAME_TITLE+TAB_CREATE, // request.setAttribute("?",venueVO);
						false);  // isFrontEnd
				break;
			case "update_cancel":
				
				break;
			case "update_commit":
				// remark:
				// OK---> // request.setAttribute(WHITCH_TAB, TAB_SELECT);
				// Error---> // request.setAttribute(WHITCH_TAB, TAB_UPDATE);
				doActionUpdateOneVenue(request, response, 
						QUERY_SUPER_SERVLET_ACTION_AGAIN+"listVenueByCompositeQuery", // goToLocalUrl_forSuccess
						TAB_SELECT, // whichTab_forSuccess
						MAINTAIN_VENUE_INFO_BACK,  // goToLocalUrl_forError
						TAB_UPDATE, // whichTab_forError
						VENUEVO_FOR_ERROR_NAME_TITLE+TAB_UPDATE, // request.setAttribute("?",venueVO);
						false);  // isFrontEnd
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
	private Map<String, String> getErrorMsgsCollection(HttpServletRequest request, String titleName){
		return getErrorMsgsCollection(request,titleName,"");
	}
	
	private void doActionUpdateOneVenue(HttpServletRequest request, HttpServletResponse response, 
			String goToLocalUrl_forSuccess, String whichTab_forSuccess,
			String goToLocalUrl_forError, String whichTab_forError, String venueVO4Error, 
			boolean isFrontEnd) throws ServletException, IOException{
		//update_commit
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITLE, whichTab_forError);
		//for 比對 舊的與新的
		VenueVO venueVO = null;
		try {
			// first find old venueVO
			VenueService venueService = new VenueService();
			String v_no = request.getParameter("v_no");
			VenueVO oldVenueVO = venueService.getOneVenue(v_no);
			// check parameter right
			venueVO	= checkAllParameterForVenue(request, errorMsgs, oldVenueVO);
		
			if(!errorMsgs.isEmpty()) {
//				if(!errorMsgs.containsKey("v_photo1")) {
//					venueVO.setV_photo1(oldVenueVO.getV_photo1());
//					venueVO.setV_photo1_ext(oldVenueVO.getV_photo1_ext());
//				}
				request.setAttribute(WHITCH_TAB, whichTab_forError);
				request.setAttribute(venueVO4Error, venueVO);
				RequestDispatcher failureView = request.getRequestDispatcher(goToLocalUrl_forError);
				failureView.forward(request, response);
				return;
			}
			//// 資料庫存取
			venueService = new VenueService();
			venueService.updateVenue(venueVO);
			
			//// 轉交出去
			HttpSession session = request.getSession();
			Map<String, String[]> venueMap = (Map<String, String[]>)session.getAttribute("venueMap");
			if(request.getParameter("whichPage")==null||"".equals(request.getParameter("whichPage"))) {
				HashMap<String, String[]> getMap = new HashMap<String, String[]>(request.getParameterMap());
				session.setAttribute("venueMap", getMap);
			}
			List<VenueVO> list = venueService.getAll(venueMap, isFrontEnd);
			
			request.setAttribute("venueVO_toUpdate", venueVO);
			request.setAttribute(WHITCH_TAB, whichTab_forSuccess);
			request.setAttribute("myList", list);
			RequestDispatcher successsView = request.getRequestDispatcher(goToLocalUrl_forSuccess+"&v_no="+venueVO.getV_no());
			successsView.forward(request, response);
			return;
		
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS,"儲存資料失敗: "+e.getMessage());
			request.setAttribute(venueVO4Error, venueVO);
			request.setAttribute(WHITCH_TAB, whichTab_forError);
			RequestDispatcher failureView = request.getRequestDispatcher(goToLocalUrl_forError);
			failureView.forward(request, response);
			return;
		}
	}
	
	private void doActionInsertOneVenue(HttpServletRequest request, HttpServletResponse response, 
			String goToLocalUrl_forSuccess, String whichTab_forSuccess,
			String goToLocalUrl_forError, String whichTab_forError, String venueVO4Error, 
			boolean isFrontEnd) throws ServletException, IOException{
		//insert_one_venue
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITLE, whichTab_forError);
		VenueVO venueVO = null;
		try {
			
			venueVO = checkAllParameterForVenue(request, errorMsgs, venueVO);
			
			
			if(!errorMsgs.isEmpty()) {
				if(!errorMsgs.containsKey("v_photo1")) {
					errorMsgs.put("v_photo1", "請重新上傳圖片");
				}
				request.setAttribute(WHITCH_TAB, whichTab_forError);
				request.setAttribute(venueVO4Error, venueVO); /// 此VO是用來恢復錯誤的VO設定
				RequestDispatcher failureView = request.getRequestDispatcher(goToLocalUrl_forError);
				failureView.forward(request, response);
				return;
			}
			//// 資料庫存取
			VenueService venueService = new VenueService();
			venueService.addVenue(venueVO);
			
			//// 轉交出去
			request.setAttribute(WHITCH_TAB, whichTab_forSuccess);
			RequestDispatcher successsView = request.getRequestDispatcher(goToLocalUrl_forSuccess+venueVO.getV_no());
			successsView.forward(request, response);
			return;
			
		}catch (Exception e) {
			e.printStackTrace();
			request.setAttribute(WHITCH_TAB, whichTab_forError);
			request.setAttribute(venueVO4Error, venueVO);
			errorMsgs.put(DB_ERROR_MSGS,"儲存資料失敗: "+e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(goToLocalUrl_forError);
			failureView.forward(request, response);
			return;
		}
	}
	
	private VenueVO checkAllParameterForVenue(HttpServletRequest request, Map<String, String> errorMsgs, VenueVO oldVenueVO) {
		VenueVO venueVO = null;
		if(oldVenueVO == null) {
			venueVO = new VenueVO();
		}else {
			venueVO = oldVenueVO;
		}
		//// 輸入參數
		String v_name = request.getParameter("v_name");
		if(v_name==null||v_name.trim().length()==0) {
			errorMsgs.put("v_name", "場地名稱請勿留白");
		}else {
			venueVO.setV_name(v_name);
		}
		String vt_no = request.getParameter("vt_no");
		if(vt_no==null || vt_no.trim().length()==0) {
			errorMsgs.put("vt_no", "請選擇場地類型");
		}else {
			venueVO.setVt_no(vt_no);
		}
		
		String v_inout = request.getParameter("v_inout"); // 室內設施、室外設施
		if(v_inout==null || v_inout.trim().length()==0) {
			errorMsgs.put("v_inout", "請選擇室內設施或是室外設施");
		}else {
			venueVO.setV_inout(v_inout);
		}
		
		String reg_no = request.getParameter("reg_no");
		if(reg_no==null || reg_no.trim().length()==0) {
			errorMsgs.put("reg_no", "請選擇地區");
		}else {
			venueVO.setReg_no(new Integer(reg_no));
		}

		String open_state = request.getParameter("open_state"); // 不開放對外使用、免費對外開放使用、付費對外開放使用
		if(open_state==null || open_state.trim().length()==0) {
			errorMsgs.put("open_state", "請選擇開放模式");
		}else {
			venueVO.setOpen_state(open_state);
		}
		
		String v_weburl = request.getParameter("v_weburl");
		v_weburl = checkParameter_IfIsEmpty_TransToNull(v_weburl);
		venueVO.setV_weburl(v_weburl);
		
		String v_parktype = request.getParameter("v_parktype");
		v_parktype = checkParameter_IfIsEmpty_TransToNull(v_parktype);
		venueVO.setV_parktype(v_parktype);
		
		String v_introduction = request.getParameter("v_introduction");
		v_introduction = checkParameter_IfIsEmpty_TransToNull(v_introduction);
		venueVO.setV_introduction(v_introduction);
		
		String v_address = request.getParameter("v_address");
		v_address = checkParameter_IfIsEmpty_TransToNull(v_address);
		venueVO.setV_address(v_address);
		
		String v_phoneno = request.getParameter("v_phoneno");
		v_phoneno = checkParameter_IfIsEmpty_TransToNull(v_phoneno);
		venueVO.setV_phoneno(v_phoneno);
		
//		// TODO: 地址，電話，緯經度，驗證
		
		String v_fitall = request.getParameter("v_fitall"); // Y or N
		v_fitall = checkYorN(v_fitall, errorMsgs, "v_fitall", "請選擇是否適用於全體國民");
		venueVO.setV_fitall(v_fitall);
		
		String v_fitinter = request.getParameter("v_fitinter"); // Y or N
		v_fitinter = checkYorN(v_fitinter, errorMsgs, "v_fitinter", "請選擇是否適用於內部人員");
		venueVO.setV_fitinter(v_fitinter);
		
		String open_time = request.getParameter("open_time");
		open_time = checkParameter_IfIsEmpty_TransToNull(open_time);
		venueVO.setOpen_time(open_time);
		
		String openday_mon = request.getParameter("openday_mon"); // Y or N
		openday_mon = checkYorN(openday_mon, errorMsgs, "openday_weak", "請選擇是否開放");
		venueVO.setOpenday_mon(openday_mon);
		
		String openday_tue = request.getParameter("openday_tue"); // Y or N
		openday_tue = checkYorN(openday_tue, errorMsgs, "openday_weak", "請選擇是否開放");
		venueVO.setOpenday_tue(openday_tue);
		
		String openday_wed = request.getParameter("openday_wed"); // Y or N
		openday_wed = checkYorN(openday_wed, errorMsgs, "openday_weak", "請選擇是否開放");
		venueVO.setOpenday_wed(openday_wed);
		
		String openday_thu = request.getParameter("openday_thu"); // Y or N
		openday_thu = checkYorN(openday_thu, errorMsgs, "openday_weak", "請選擇是否開放");
		venueVO.setOpenday_thu(openday_thu);
		
		String openday_fri = request.getParameter("openday_fri"); // Y or N
		openday_fri = checkYorN(openday_fri, errorMsgs, "openday_weak", "請選擇是否開放");
		venueVO.setOpenday_fri(openday_fri);
		
		String openday_sat = request.getParameter("openday_sat"); // Y or N
		openday_sat = checkYorN(openday_sat, errorMsgs, "openday_weak", "請選擇是否開放");
		venueVO.setOpenday_sat(openday_sat);
		
		String openday_sun = request.getParameter("openday_sun"); // Y or N
		openday_sun = checkYorN(openday_sun, errorMsgs, "openday_weak", "請選擇是否開放");
		venueVO.setOpenday_sun(openday_sun);
		
		String v_display = request.getParameter("v_display"); // 顯示，不顯示
		if(v_display==null || v_display.trim().length()==0) {
			errorMsgs.put("v_display", "請選擇顯示或不顯示");
		}
		venueVO.setV_display(v_display);
		
		String v_lat = request.getParameter("v_lat");
		try {
			if(v_lat==null || v_lat.trim().length()==0) {
				venueVO.setV_lat(new Double("0"));
			}else {
				venueVO.setV_lat(new Double(v_lat));
			}
		}catch (NumberFormatException e) {
			errorMsgs.put("v_lat", "lat:格式不對");
		}
		String v_long = request.getParameter("v_long");
		try {
			if(v_long==null || v_long.trim().length()==0) {
				venueVO.setV_long(new Double("0"));
			}else {
				venueVO.setV_long(new Double(v_long));
			}
		}catch (NumberFormatException e) {
			errorMsgs.put("v_long", "long:格式不對");
		}
		
		byte[] v_photo1 = null;
		String v_photo1_ext = null;
		
		if(oldVenueVO==null) { // 確認是否為新建
			Map<String, byte[]> map = checkAndGetParameterAboutPicture(request, errorMsgs, "v_photo1");
			Set<String> set = map.keySet();
			for(String string : set) {
				v_photo1_ext = string;
			}
			v_photo1 = map.get(v_photo1_ext);
			venueVO.setV_photo1_ext(v_photo1_ext);
			venueVO.setV_photo1(v_photo1);
		}else {
			String hasChangePictiure = request.getParameter("hasChangePictiure");
System.out.println("hasChangePictiure : "+hasChangePictiure);
			if(!"false".equals(hasChangePictiure)) { // 表示有更動Picture
				Map<String, byte[]> map = checkAndGetParameterAboutPicture(request, errorMsgs, "v_photo1");
				Set<String> set = map.keySet();
				for(String  string :set) {
					v_photo1_ext = string;
				}
				v_photo1 = map.get(v_photo1_ext);
				venueVO.setV_photo1(v_photo1);
				venueVO.setV_photo1_ext(v_photo1_ext);
			}else {
				//沒有更動原圖片，就取原先的
				if("false".equals(hasChangePictiure)) {
					venueVO.setV_photo1(oldVenueVO.getV_photo1());
					venueVO.setV_photo1_ext(oldVenueVO.getV_photo1_ext());
				}
			}
		}
		return venueVO;
	}
	
	
	private String checkParameter_IfIsEmpty_TransToNull(String string) {
		if(string!=null && string.trim().length()==0) {
			string = null;
		}
		return string;
	}
	private Map<String, byte[]> checkAndGetParameterAboutPicture(HttpServletRequest request, Map<String, String> errorMsgs, String parameterName) {
		Map<String, byte[]> map = new HashMap<>();
		String pic_extension = null;
		byte[] news_picture = null;
		try {
			Part part = request.getPart(parameterName);
			if (!part.getSubmittedFileName().isEmpty() && part.getContentType()!=null) {
				String string = part.getContentType();
				if(!"image".equals(string.substring(0,string.indexOf("/")))){
					errorMsgs.put(parameterName, "格式錯誤，請重新上傳圖片");
				}else {
					try {
						pic_extension = string.substring(string.lastIndexOf("/")+1, string.length());
						InputStream inputStream = part.getInputStream();
						ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
						byte[] b = new byte[4096];
						int bytesRead;
						while((bytesRead = inputStream.read(b))!=-1) {
							byteArrayOutputStream.write(b, 0, bytesRead);
						}
						news_picture = byteArrayOutputStream.toByteArray();
						byteArrayOutputStream.close();
						inputStream.close();
					}catch (IOException e) {
						errorMsgs.put(parameterName, "上傳失敗，請重新上傳圖片");
					}
				}
			}else {
				errorMsgs.put(parameterName, "請上傳圖片");
			}
		}catch (Exception e) {
			errorMsgs.put(parameterName, "連線問題，請重新上傳圖片");
		}
		map.put(pic_extension, news_picture);
		return map;
	}
	
	private String checkYorN(String reulstString ,Map<String, String> errorMsgs, String culname, String errorMessageString) {
		if("Y".equals(reulstString) || "N".equals(reulstString)) {
			return reulstString;
		}else {
			errorMsgs.put(culname, errorMessageString);
		}
		return null;
	}
	
}
