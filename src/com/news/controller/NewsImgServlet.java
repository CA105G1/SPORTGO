package com.news.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.news.model.NewsService;
import com.venue.model.VenueService;

@MultipartConfig(fileSizeThreshold=1024*1024,maxFileSize=5*1024*1024,maxRequestSize=5*5*1024*1024)
public class NewsImgServlet extends HttpServlet {
	       
	    public NewsImgServlet() {
	        super();
	    }

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doPost(request, response);
		}

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			request.setCharacterEncoding("UTF-8");
			String news_no = request.getParameter("news_no");
			NewsService newsService = new NewsService();
			byte[] news_picture = newsService.getOneNews(news_no).getNews_picture();
			if(news_picture==null) {
				return;
			}
			response.setContentType("image/*");
			response.setContentLength(news_picture.length);
			ServletOutputStream outputStream = response.getOutputStream();
			outputStream.write(news_picture);
			outputStream.close();
		}
}
