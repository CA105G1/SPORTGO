package com.venue.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.venue.model.VenueService;

@MultipartConfig(fileSizeThreshold=1024*1024,maxFileSize=5*1024*1024,maxRequestSize=5*5*1024*1024)
public class VenueImgServlet extends HttpServlet {
       
    public VenueImgServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String v_no = request.getParameter("v_no");
		VenueService venueService = new VenueService();
		byte[] photo = venueService.getOneVenue(v_no).getV_photo1();
		InputStream inputStream = null;
		ByteArrayOutputStream outputStream = null;
		if(photo==null) {
			inputStream = getServletContext().getResourceAsStream("/img/no-image.PNG");
			outputStream = new ByteArrayOutputStream();	
			byte[] b = new byte[4096];
			int bytesRead;
			while((bytesRead = inputStream.read(b))!=-1) {
				outputStream.write(b, 0, bytesRead);
			}
			/// remember to trans to byte[]
			photo = outputStream.toByteArray();
		}
		response.setContentType("image/*");
		response.setContentLength(photo.length);
		ServletOutputStream servletOutputStream = response.getOutputStream();
		servletOutputStream.write(photo);
		if(outputStream!=null) {
			outputStream.close();
		}
		if(inputStream!=null) {
			inputStream.close();
		}
		servletOutputStream.close();
	}

}
