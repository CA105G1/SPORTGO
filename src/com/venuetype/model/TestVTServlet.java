package com.venuetype.model;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.venue.model.VenueDAO_interface;

/**
 * Servlet implementation class VenueT
 */
@WebServlet("/VenueT")
public class TestVTServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    response.setContentType("text/plain; charset=UTF-8");
//		
//		VenueTypeDAO_interface vi  = new VenueTypeDAO();
//		VenueTypeVO vo = vi.findByPrimaryKey("VT002");
//		
//		
		response.getWriter().append("HELLO");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
