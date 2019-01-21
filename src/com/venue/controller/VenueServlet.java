package com.venue.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class VenueServlet extends HttpServlet {

	private final String VENUE_SELECT_SERVLET = "/venue/venueSelect.do";
	private final String VENUE_CREATE_OR_UPATE_SERVLET = "/venue/venueCreateOrUpdate.do";
	private final String VENUE_DELETE_SERVLET = "/venue/venueDelete.do";	
	private final String VENUE_FUNCTION_SERVLET = "/venue/venueFunc.do";

	public VenueServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	// getParameter("action")後決定送到哪個servlet-->
	/* 分別有
	 * =>VenueSelectServlet
	 * =>VenueCreateOrUpdateServlet
	 * =>VenueDeleteServlet
	 * =>VenueFuncServlet
	 * */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		System.out.println("VenueServlet : "+action);
		if(action != null ) {
			switch (action) {
				//select
				//case "get_all_venue":
				case "update_reset":
				case "updateForQueryOneVenue":
				case "show_one_venue_back":
				case "listVenueByCompositeQuery":
				case "listVenueByCompostieQueryForFrontEnd":
					doForwardNextServlet(request, response, VENUE_SELECT_SERVLET);
					break;
				// insert or update
				//case "update_cancel":
				case "update_disply_by_v_no":
				case "insert_one_venue":
				case "update_commit":
					doForwardNextServlet(request, response, VENUE_CREATE_OR_UPATE_SERVLET);
					break;
				case "delete":
					doForwardNextServlet(request, response, VENUE_DELETE_SERVLET);
					break;
				//function
				case "memEvaluateVenueInFrontEnd":
					doForwardNextServlet(request, response, VENUE_FUNCTION_SERVLET);
					break;
				default:
					System.out.println("In this VenueServlet, there aer no "+action+".");
					break;
			}
		}
		return;
	}
	
	private void doForwardNextServlet(HttpServletRequest request, HttpServletResponse response, String localUrlWhere) throws ServletException, IOException{
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(localUrlWhere);
		requestDispatcher.forward(request, response);
	}
	

	
}
