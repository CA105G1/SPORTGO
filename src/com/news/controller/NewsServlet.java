package com.news.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.news.model.NewsService;
import com.news.model.NewsVO;
import com.news.model.Util_Check_News_Parameter;
import com.newstype.model.NewstypeService;
import com.newstype.model.NewstypeVO;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class NewsServlet extends HttpServlet {
	private Timer myTimer;
	public List<NewsVO> theNewsVOList ;
	public List<NewstypeVO> theNewstypeVOList ;
	public List<NewsVO> theNewsVO_ForProduct_List;
	
	public static final String MAINTAIN_NEWS_INFO_INDEX_BACK_PATH = "/back-end/news/maintain_news_info.jsp"; 
	public static final String QUERY_THIS_SERVLET_ACTIN_AGAIN ="/news/news.do";
	
	private static final String DB_ERROR_MSGS = "DataBaseError";
	private static final String TIMESTAMP_SIMPLE_FORMAT="yyyy-MM-dd HH:mm";
	private static final String NEW_STUTAS_BEFORE_RELEASE = "未發布";
	private static final String NEW_STUTAS_RELEASE = "發布中";
	private static final String NEW_STUTAS_OUT_OF_TIME = "下架";
	private static final String WHITCH_TAB="whichTab";
	private static final String TAB_SELECT="tab1";
	private static final String TAB_CREATE="tab2";
	private static final String TAB_UPDATE="tab3";
	private static final String ERRORMSGS_TITILE = "errorMsgs_";
	
	private final String NEWS_PRODUCTNAME="促銷商品"; // 98
	
	@Override
	public void init() throws ServletException {
		//super.init();
		myTimer = new Timer();
		TimerTask task = new TimerTask() {	
			@Override
			public void run() {
				chargeNewsStutas();
				updateTheNewsTypeList();
				updateTheNewsList();
			}
		};
		
		Calendar today = new GregorianCalendar();
		int year = today.get(Calendar.YEAR);
		int month = today.get(Calendar.MONTH);
		int date = today.get(Calendar.DATE);
		
		Calendar calendar = new GregorianCalendar(year,month,date,0,0,0);
		myTimer.schedule(task, calendar.getTime(), 1*60*60*1000);

	}
	
	@Override
	public void destroy() {
		myTimer.cancel();
	}

	private void chargeNewsStutas() {
		NewsService service = new NewsService();
		service.chargeNewsStutas();
	}
	
	private void updateTheNewsList() {
		NewsService service = new NewsService();
		theNewsVOList = service.getReleaseNews(new Timestamp(System.currentTimeMillis()));
		getServletContext().setAttribute("newsVOList", theNewsVOList);
		
		List<String> listType = new ArrayList<>();
		listType.add(NEWS_PRODUCTNAME);
		
		Map<String, String> map = new HashMap<>();
		for(String keyName : listType) {
			for(NewstypeVO newstypeVO : theNewstypeVOList) {
				if(keyName.equals(newstypeVO.getNewstype_name())) {
					map.put(keyName, newstypeVO.getNewstype_no());
					continue;
				}
			}
		}
		theNewsVO_ForProduct_List = service.getReleaseNewsAndChooseNewsType(new Timestamp(System.currentTimeMillis()), map);
		getServletContext().setAttribute("newsVOProductList", theNewsVO_ForProduct_List);
	}
	
	private void updateTheNewsTypeList() {
		NewstypeService service = new NewstypeService();
		theNewstypeVOList = service.getAll();
		getServletContext().setAttribute("newsTypeVOList", theNewstypeVOList);
	}
	
    public NewsServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		System.out.println("NewsServlet---action : "+action);
		switch (action) {
		case "insert_one_news":
			request.setAttribute(WHITCH_TAB, TAB_CREATE);
			doActionInsertOneNews(request,response);
			break;
		case "getOne_For_Update":
			request.setAttribute(WHITCH_TAB, TAB_UPDATE);
			doActionGetOneForUpdate(request, response);
			break;
		case "update_news_no_stutas":
			// remark:
			// OK---> // request.setAttribute(WHITCH_TAB, TAB_SELECT);
			// Error---> // request.setAttribute(WHITCH_TAB, TAB_UPDATE);
			doActionUpdateOneNewsButNoStutas(request,response);
			break;
		case "update_news_for_reset":
			request.setAttribute(WHITCH_TAB, TAB_UPDATE);
			doActionUpdateNewsForReset(request,response);
			break;
		case "listNewsByCompositeQuery":
			request.setAttribute(WHITCH_TAB, TAB_SELECT);
			doActionListNewsByCompositeQuery(request,response);
			break;
		case "showOneNews":
			request.setAttribute(WHITCH_TAB, TAB_SELECT);
			doActionShowOneNews(request,response);
			break;
		case "delete_this_news":
			request.setAttribute(WHITCH_TAB, TAB_SELECT);
			doActionDeleteThisNews(request, response);
			break;
			// no use
//		case "change_news_stutas":
//			doActionChangeNewsStutasByPK(request, response);
//			break;
		default:
			break;
		}
		
	}
	
	private void doActionInsertOneNews(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//insert_one_news
		Map<String, String> errorMsgs = getErrorMsgsCollection(request,ERRORMSGS_TITILE, TAB_CREATE);
		NewsVO newsVO = null;
		try {
			newsVO = new NewsVO();  // 用來收集newsVO物件，確定OK就set
			/// 接收參數及驗證---內含有圖片---必須有
			
			String newstype_no = request.getParameter("newstype_no");
			if("".equals(newstype_no)) {
				errorMsgs.put("newstype_no", "請選擇訊息總類");
			}else {
				newsVO.setNewstype_no(newstype_no);
			}
			
			String news_script = request.getParameter("news_script").trim();
			if("".equals(news_script)) {
				errorMsgs.put("news_script", "請輸入訊息文字");
			}else {
				newsVO.setNews_script(news_script);
			}
			//單一圖片檢查
			byte[] news_picture = null;
			String pic_extension = null;
			Map<String, byte[]> map = checkAndGetParameterAboutPicture(request, errorMsgs,"news_picture");
			Set<String> set =map.keySet();
			for(String string : set) {
				pic_extension = string;
			}
			news_picture = map.get(pic_extension);
			newsVO.setPic_extension(pic_extension);
			newsVO.setNews_picture(news_picture);
//			Part part = request.getPart("news_picture");
//			if (!part.getSubmittedFileName().isEmpty() && part.getContentType()!=null) {
//				String string = part.getContentType();
//				if(!"image".equals(string.substring(0,string.indexOf("/")))){
//					errorMsgs.put("news_picture", "格式錯誤，請重新上傳圖片");
//				}else {
//					try {
//						pic_extension = string.substring(string.lastIndexOf("/")+1, string.length());
//						InputStream inputStream = part.getInputStream();
//						ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
//						byte[] b = new byte[4096];
//						int bytesRead;
//						while((bytesRead = inputStream.read(b))!=-1) {
//							byteArrayOutputStream.write(b, 0, bytesRead);
//						}
//						news_picture = byteArrayOutputStream.toByteArray();
//						byteArrayOutputStream.close();
//						inputStream.close();
//						newsVO.setNews_picture(news_picture);
//						newsVO.setPic_extension(pic_extension);
//					}catch (IOException e) {
//						errorMsgs.put("news_picture", "上傳失敗，請重新上傳圖片");
//					}
//				}
//			}else {
//				errorMsgs.put("news_picture", "請上傳圖片");
//			}
			
			//日期檢查
			Timestamp news_release_date = checkAndGetParameterAboutTimeStamp(request, errorMsgs, "news_release_date");
			newsVO.setNews_release_date(news_release_date);
//			try {
//				if(！"".equals(request.getParameter("news_release_date"))) {
//					SimpleDateFormat sdf = new SimpleDateFormat(TIMESTAMP_SIMPLE_FORMAT);
//					Date date = sdf.parse(request.getParameter("news_release_date").trim());
//					news_release_date = new Timestamp(date.getTime());
//					newsVO.setNews_release_date(news_release_date);
//				}
//			}catch(Exception e) {
//				errorMsgs.put("news_release_date","請輸入日期!");
//			}


			Timestamp news_last_date = checkAndGetParameterAboutTimeStamp(request, errorMsgs, "news_last_date");
			newsVO.setNews_last_date(news_last_date);
			
			//若有錯誤訊息，將VO跟錯誤訊息回傳(用來回復剛剛的設定)
			if(!errorMsgs.isEmpty()) {
				if(!errorMsgs.containsKey("news_picture")) {
					errorMsgs.put("news_picture", "請重新上傳圖片");
				}
				request.setAttribute("newsVO", newsVO);
				RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
				failureView.forward(request, response);
				return;
			}
			//// 判斷訊息狀態，以便存進資料庫
//			news_release_date.getTime()   news_last_date.getTime()  
			//使用方法包裝
			long rightNow = System.currentTimeMillis();
			setNews_stutasByTwoTimestamp(rightNow, news_release_date, news_last_date, newsVO);
//			if( news_release_date==null && news_last_date==null ) {
//				newsVO.setNews_stutas(NEW_STUTAS_BEFORE_RELEASE);
//			}else if(news_release_date==null && news_last_date!=null) {
//				if(news_last_date.getTime() < rightNow) {
//					newsVO.setNews_stutas(NEW_STUTAS_OUT_OF_TIME);
//				}else {
//					newsVO.setNews_stutas(NEW_STUTAS_RELEASE);
//				}
//			}else if(news_release_date!=null && news_last_date==null) {
//				if(news_release_date.getTime() > rightNow) {
//					newsVO.setNews_stutas(NEW_STUTAS_BEFORE_RELEASE);
//				}else {
//					newsVO.setNews_stutas(NEW_STUTAS_RELEASE);
//				}
//			}else if(news_release_date!=null && news_last_date!=null) {
//				if(rightNow < news_release_date.getTime()) {
//					newsVO.setNews_stutas(NEW_STUTAS_BEFORE_RELEASE);
//				}else if(news_last_date.getTime() <rightNow) {
//					newsVO.setNews_stutas(NEW_STUTAS_OUT_OF_TIME);
//				}else {
//					newsVO.setNews_stutas(NEW_STUTAS_RELEASE);
//				}
//			}
			
			/// 永續層工作
			NewsService newsService = new NewsService();
			newsVO = newsService.addNews(newsVO);
			/// ServletContext的物件也要變更
			chargeNewsStutas();
			updateTheNewsTypeList();
			updateTheNewsList();
			/// 轉交對象
			//  轉交前，記得把session的newsMap清空
			request.getSession().removeAttribute("newsMap");
			RequestDispatcher successsView = 
					request.getRequestDispatcher(QUERY_THIS_SERVLET_ACTIN_AGAIN+"?action=showOneNews&news_no="+newsVO.getNews_no());
			successsView.forward(request, response);
			return;
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS,e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			failureView.forward(request, response);
			return;
		}
	}
	
	// 取得及驗證圖片
	private Map<String, byte[]> checkAndGetParameterAboutPicture(HttpServletRequest request, Map<String, String> errorMsgs, String parameterName) throws IOException, ServletException {
		Part part = request.getPart(parameterName);
		Map<String, byte[]> map = new HashMap<>();
		String pic_extension = null;
		byte[] news_picture = null;
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
		map.put(pic_extension, news_picture);
		return map;
	}
	
	// 取得及驗證日期
	private Timestamp checkAndGetParameterAboutTimeStamp(HttpServletRequest request, Map<String, String> errorMsgs, String timeStampName) {
		Timestamp timestamp = null;
		try {
			if(!"".equals(request.getParameter(timeStampName).trim())) {
				SimpleDateFormat sdf = new SimpleDateFormat(TIMESTAMP_SIMPLE_FORMAT);
				Date date = sdf.parse(request.getParameter(timeStampName).trim());
				timestamp = new Timestamp(date.getTime());
			}
		}catch(Exception e) {
			errorMsgs.put(timeStampName,"請重新輸入日期!");
		}
		return timestamp;
	}
	
	// 依時間變更信息狀態
	private void setNews_stutasByTwoTimestamp(long rightNow, Timestamp news_release_date, Timestamp news_last_date, NewsVO newsVO) {
		if( news_release_date==null && news_last_date==null ) {
			newsVO.setNews_stutas(NEW_STUTAS_BEFORE_RELEASE);
		}else if(news_release_date==null && news_last_date!=null) {
			if(news_last_date.getTime() < rightNow) {
				newsVO.setNews_stutas(NEW_STUTAS_OUT_OF_TIME);
			}else {
				newsVO.setNews_stutas(NEW_STUTAS_RELEASE);
			}
		}else if(news_release_date!=null && news_last_date==null) {
			if(news_release_date.getTime() > rightNow) {
				newsVO.setNews_stutas(NEW_STUTAS_BEFORE_RELEASE);
			}else {
				newsVO.setNews_stutas(NEW_STUTAS_RELEASE);
			}
		}else if(news_release_date!=null && news_last_date!=null) {
			if(rightNow < news_release_date.getTime()) {
				newsVO.setNews_stutas(NEW_STUTAS_BEFORE_RELEASE);
			}else if(news_last_date.getTime() <rightNow) {
				newsVO.setNews_stutas(NEW_STUTAS_OUT_OF_TIME);
			}else {
				newsVO.setNews_stutas(NEW_STUTAS_RELEASE);
			}
		}
	}
	
	
	private void doActionGetOneForUpdate(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		//getOne_For_Update
		Map<String, String> errorMsgs = getErrorMsgsCollection(request,ERRORMSGS_TITILE, TAB_SELECT);
		try {
			/// 確認參數
			String news_no = request.getParameter("news_no");
			String requestURL = request.getParameter("requestURL");
			String whichPage = request.getParameter("whichPage");
			/// DAO
			NewsService newsService = new NewsService();
			NewsVO newsVO = newsService.getOneNews(news_no);
			NewstypeService newstypeService = new NewstypeService();
			NewstypeVO newstypeVO = newstypeService.getOneNewsType(newsVO.getNewstype_no());
			
			////
			request.setAttribute("newsVO", newsVO);
			request.setAttribute("newstypeVO", newstypeVO);
			request.setAttribute("requestURL", requestURL);
			request.setAttribute("whichPage", whichPage);
			RequestDispatcher successView = 
					request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			successView.forward(request, response);
			return;
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS, e.getMessage());
			request.setAttribute("requestURL", request.getParameter("requestURL"));
			request.setAttribute("whichPage", request.getParameter("whichPage"));
			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			failureView.forward(request, response);
			return;
		}
		
	}
	
	private void doActionUpdateOneNewsButNoStutas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//update_news_no_stutas
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITILE, TAB_UPDATE);
		NewsVO newsVO = null;
		try {
			newsVO = new NewsVO();
			request.setAttribute("requestURL", request.getParameter("requestURL"));
			request.setAttribute("whichPage", request.getParameter("whichPage"));
			/// 接收參數及驗證 
			String news_no = request.getParameter("news_no"); /// 編號不能改動
			newsVO.setNews_no(news_no);
			String newstype_no = request.getParameter("newstype_no");
			if("".equals(newstype_no)) {
				newsVO.setNewstype_no(newstype_no);
				errorMsgs.put("newstype_no", "請選擇訊息總類");
			}else {
				newsVO.setNewstype_no(newstype_no);
			}
			
			String news_script = request.getParameter("news_script");
			if("".equals(news_script)) {
				errorMsgs.put("news_script", "請輸入訊息文字");
			}else {
				newsVO.setNews_script(news_script);
			}
			
			Timestamp news_release_date = checkAndGetParameterAboutTimeStamp(request, errorMsgs, "news_release_date");
			newsVO.setNews_release_date(news_release_date);
			
			Timestamp news_last_date = checkAndGetParameterAboutTimeStamp(request, errorMsgs, "news_last_date");
			newsVO.setNews_last_date(news_last_date);
			
			long rightNow = System.currentTimeMillis();
			setNews_stutasByTwoTimestamp(rightNow, news_release_date, news_last_date, newsVO);
			
			// 確認是否更動 pic
			String hasChangePicture = request.getParameter("hasChangePicture");
			String pic_extension = null;
			byte[] news_picture = null;
			if(!"false".equals(hasChangePicture)) {
				Map<String, byte[]> map = checkAndGetParameterAboutPicture(request, errorMsgs,"news_picture");
				Set<String> set =map.keySet();
				for(String string : set) {
					pic_extension = string;
				}
				news_picture = map.get(pic_extension);
				newsVO.setPic_extension(pic_extension);
				newsVO.setNews_picture(news_picture);
			}else {
				/// 判斷是否更動圖片，沒有就取出原NewsVO
				NewsVO tempVO;
				if("false".equals(hasChangePicture)) {
					tempVO = new NewsService().getOneNews(newsVO.getNews_no());
					newsVO.setPic_extension(tempVO.getPic_extension());
					newsVO.setNews_picture(tempVO.getNews_picture());
				}
			}

			//若有錯誤訊息，將VO跟錯誤訊息回傳(用來回復剛剛的設定)
			if(!errorMsgs.isEmpty()) {
				request.setAttribute("newsVO", newsVO);
				request.setAttribute(WHITCH_TAB, TAB_UPDATE);
				RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
//				RequestDispatcher failureView = request.getRequestDispatcher(QUERY_THIS_SERVLET_ACTIN_AGAIN+"?action=getOne_For_Update&news_no="+newsVO.getNews_no());
				// 缺點: 無法把error帶出
				failureView.forward(request, response);
				return;
			}
			
			/// 永續層工作
			NewsService newsService = new NewsService();
			newsService.update(newsVO);
			/// ServletContext的物件也要變更
			chargeNewsStutas();
			updateTheNewsTypeList();
			updateTheNewsList();
			
			/// 轉交對象
			
			HttpSession session = request.getSession();
			Map<String, String[]> newsMap = (Map<String, String[]>)session.getAttribute("newsMap");
			if(request.getParameter("whichPage")==null || "".equals(request.getParameter("whichPage"))) {
				HashMap<String, String[]> getMap = new HashMap<String, String[]>(request.getParameterMap());
				session.setAttribute("newsMap", getMap);
				newsMap = getMap;
			}
			List<NewsVO> list = newsService.getAll(newsMap);
			

			request.setAttribute("newsVO_toUpdate", newsVO);
			request.setAttribute(WHITCH_TAB, TAB_SELECT);
//			showNewsListAndForward(list, MAINTAIN_NEWS_INFO_INDEX_BACK_PATH, request, response);
			showNewsListAndForward(list, QUERY_THIS_SERVLET_ACTIN_AGAIN+"?action=listNewsByCompositeQuery", request, response);
//			RequestDispatcher successsView = 
//					request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
//			successsView.forward(request, response);
			return;
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS, e.getMessage());
			request.setAttribute("newsVO", newsVO);
			request.setAttribute(WHITCH_TAB, TAB_UPDATE);
			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
//			RequestDispatcher failureView = request.getRequestDispatcher(QUERY_THIS_SERVLET_ACTIN_AGAIN+"?action=getOne_For_Update&news_no="+newsVO.getNews_no());
			failureView.forward(request, response);
			return;
		}
	}
	
	private void doActionUpdateNewsForReset(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// update_news_for_reset
		doActionGetOneForUpdate(request, response);
		return;
	}
	
	
	
/*	/// 有點複雜，暫時不要寫進這功能
	private void doActionChangeNewsStutasByPK(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		//change_news_stutas
//		Map<String, String> errorMsgs = getErrorMsgsCollection(request);
		/// 會有的參數，編號、狀態; 連動可能改變 開始與結束時間
//		try {
			/// 接收參數及驗證
//			String news_no = request.getParameter("news_no"); // --->透過hidden取得
//			String news_stutas = request.getParameter("news_stutas");  // ----> select選單
			/// 永續層工作
//			NewsService newsService = new NewsService();
//			NewsVO newsVO = newsService.getOneNews(news_no);
//			if(NEW_STUTAS_BEFORE_RELEASE.equals(news_stutas)) {
//				newsVO.setNews_release_date(null);
//				newsVO.setNews_last_date(null);
//				newsVO.setNews_stutas(NEW_STUTAS_BEFORE_RELEASE);
//				newsService.update(newsVO);
//			}else if(NEW_STUTAS_RELEASE.equals(news_stutas)) {
//			}else if(NEW_STUTAS_OUT_OF_TIME.equals(news_stutas)) {
//			}
//			newsVO.setNews_stutas(news_stutas);
//			/ 轉交對象		
//		}catch (Exception e) {
//			errorMsgs.put(DB_ERROR_MSGS, e.getMessage());
//			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
//			failureView.forward(request, response);
//			return;
//		}
	}
*/	
	
	private void doActionListNewsByCompositeQuery(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		//listNewsByCompositeQuery
		Map<String,String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITILE, TAB_SELECT);
		try {
			HttpSession session = request.getSession();
			Map<String, String[]> newsMap = (Map<String, String[]>)session.getAttribute("newsMap");
			if(request.getParameter("whichPage")==null || "".equals(request.getParameter("whichPage"))) {
				HashMap<String, String[]> getMap = new HashMap<String, String[]>(request.getParameterMap());
				session.setAttribute("newsMap", getMap);
				newsMap = getMap;
			}
			// 1.5 check map
			newsMap = Util_Check_News_Parameter.checkNewsMap(newsMap, errorMsgs);
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = 
						request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
				failureView.forward(request, response);
			}
			//2.
			NewsService newsService = new NewsService();
			List<NewsVO> list = newsService.getAll(newsMap);
			//3.
			showNewsListAndForward(list, MAINTAIN_NEWS_INFO_INDEX_BACK_PATH, request, response);
			return;
		}catch (Exception e) {
			e.printStackTrace();
			errorMsgs.put(DB_ERROR_MSGS, e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			failureView.forward(request, response);
			return;
		}
		
	}
	
	private void showNewsListAndForward(List<NewsVO> list, String whereUrl,HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		request.setAttribute("myList", list);
		RequestDispatcher successView = request.getRequestDispatcher(whereUrl);
		successView.forward(request, response);
	}
	
	
	private void doActionShowOneNews(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		//showOneNews
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITILE, TAB_SELECT);
		try {
			/// 確認參數
			String news_no = request.getParameter("news_no");
			
			/// DAO
			NewsService newsService = new NewsService();
			NewsVO newsVO = newsService.getOneNews(news_no);
			NewstypeService newstypeService = new NewstypeService();
			NewstypeVO newstypeVO = newstypeService.getOneNewsType(newsVO.getNewstype_no());
			
			////
			request.setAttribute("newsVO", newsVO);
			request.setAttribute("newstypeVO", newstypeVO);
			RequestDispatcher successView = 
					request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			successView.forward(request, response);
			return;
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS, e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			failureView.forward(request, response);
			return;
		}
	}
	
	private void doActionDeleteThisNews(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		// delete_this_news
		Map<String, String> errorMsgs = getErrorMsgsCollection(request, ERRORMSGS_TITILE, TAB_SELECT);
		try {
			/// 確認參數
			String requestURL = request.getParameter("requestURL");
			String news_no = request.getParameter("news_no");
			
			/// DAO
			NewsService newsService = new NewsService();
			NewsVO newsVO = newsService.getOneNews(news_no);
			newsService.delete(news_no);
			////
			request.setAttribute("newsVO", newsVO);
			RequestDispatcher successView = 
//					request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
					request.getRequestDispatcher(requestURL);
			successView.forward(request, response);
			return;
			
		}catch (Exception e) {
			errorMsgs.put(DB_ERROR_MSGS, e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(MAINTAIN_NEWS_INFO_INDEX_BACK_PATH);
			failureView.forward(request, response);
			return;
		}
		
		
	}
	

	
	private Map<String,String> getErrorMsgsCollection(HttpServletRequest request,String titleName, String tabNum){
		Map<String,String> errorMsgs = new LinkedHashMap<>();
		request.setAttribute(titleName+tabNum, errorMsgs);
		return errorMsgs;
	}
	
	
}
