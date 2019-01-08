package com.news.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.news.model.NewsService;
import com.news.model.NewsVO;
import com.news.model.Util_Check_News_Parameter;
import com.newstype.model.NewstypeService;
import com.newstype.model.NewstypeVO;
import com.sun.corba.se.impl.presentation.rmi.StubFactoryFactoryStaticImpl;
import com.venue.model.Util_Check_Venue_Parameter;
import com.venue.model.VenueService;
import com.venue.model.VenueVO;

public class NewsServlet extends HttpServlet {
	private Timer myTimer;
	public static List<NewsVO> theNewsVOList ;
	public static List<NewstypeVO> theNewstypeVOList ;
	public static final String MAINTAIN_NEWS_INFO_INDEX_BACK_PATH = "/back-end/news/maintain_news_info.jsp"; 
	
	
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
		case "insert_news":
			
			break;
		case "update_news":
			
			break;
		case "listNewsByCompositeQuery":
			doActionListNewsByCompositeQuery(request,response);
			break;
			
		default:
			break;
		}
		
	}
	
	private void doActionListNewsByCompositeQuery(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		//listNewsByCompositeQuery
		List<String> errorMsgs = getErrorMsgsCollection(request);
		try {
			HttpSession session = request.getSession();
			Map<String, String[]> newsMap = (Map<String, String[]>)session.getAttribute("newsMap");
			if(request.getParameter("whichPage")==null) {
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
			errorMsgs.add(e.getMessage());
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
	
	private List<String> getErrorMsgsCollection(HttpServletRequest request){
		List<String> errorMsgs = new LinkedList<>();
		request.setAttribute("errorMsgs", errorMsgs);
		return errorMsgs;
	}
	
	
}
