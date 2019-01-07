package com.news.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.news.model.NewsService;
import com.news.model.NewsVO;

public class NewsServlet extends HttpServlet {
	private Timer myTimer;
	public static List<NewsVO> theNewsList = new ArrayList<>();
	
	@Override
	public void init() throws ServletException {
		super.init();
		myTimer = new Timer();
		TimerTask task = new TimerTask() {	
			@Override
			public void run() {
				chargeNewsStutas();
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
	
	private void updateTheNewsList() {
		NewsService service = new NewsService();
		theNewsList = service.getReleaseNews(new Timestamp(System.currentTimeMillis()));
		getServletContext().setAttribute("newsVOList", theNewsList);
	}
	
	private void chargeNewsStutas() {
		NewsService service = new NewsService();
		service.chargeNewsStutas();
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
		
		
		
		
		
		
	}

}