package com.venue.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VenueCreateOrUpdateServlet extends HttpServlet {

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
		case "updateForQuerry":
			
			break;
		case "update_cancel":
			
			break;
		case "update_reset":
			
			break;
		case "update_commit":
			
			break;

		default:
			
			break;
		}
		
	}

}
