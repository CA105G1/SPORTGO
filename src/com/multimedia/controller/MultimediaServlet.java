package com.multimedia.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.multimedia.model.MultimediaService;

@WebServlet("/MultimediaServlet")
@MultipartConfig(fileSizeThreshold=1024*1024,maxFileSize=5*1024*1024,maxRequestSize=5*5*1024*1024)
public class MultimediaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MultimediaServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		switch (action) {
		case "insert_media":
			
			break;
		case "upFileClub":
			doActionUpFileClub(request, response);
			break;

		default:
			break;
		}
		
		
		
		
	}
	
	
	private void doActionUpFileClub(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String media_no = request.getParameter("media_no");
		Map<String, String> errorMsgs = new LinkedHashMap<>();
		
		String parameterName = "media_content";
		String pic_extension = "file_extension";
		byte[] news_picture ;
		Part part = request.getPart(parameterName);
		if (!part.getSubmittedFileName().isEmpty() && part.getContentType()!=null) {
			String string = part.getContentType();
			if(!"image".equals(string.substring(0,string.indexOf("/")))||!"video".equals(string.substring(0,string.indexOf("/")))){
				errorMsgs.put(parameterName, "格式錯誤，請重新上傳圖片或影音");
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
					errorMsgs.put(parameterName, "上傳失敗，請重新上傳圖片或影音");
				}
			}
		}else {
			errorMsgs.put(parameterName, "請上傳圖片或影音");
		}
		
		
		
		
	}
}
