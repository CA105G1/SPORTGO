package com.region.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.region.model.RegService;
import com.region.model.RegVO;

public class RegionServlet extends HttpServlet {
	
	private List<String> reg_nameList =null;
	private Map<String, List<RegVO>> regionMapKeyReg_name = null;   
    
	public RegionServlet() {
        super();
    }

	@Override
	public void init() throws ServletException {
		super.init();
		RegService regService = new RegService();
		reg_nameList = regService.getReg_nameList();
		regionMapKeyReg_name = regService.getRegionMapKeyReg_name();
System.out.println(reg_nameList+"ddddddddddddd");
		getServletContext().setAttribute("reg_nameList", reg_nameList);
		getServletContext().setAttribute("regionMapKeyReg_name", regionMapKeyReg_name);
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void destroy() {
		super.destroy();
	}

	
	
	

}
