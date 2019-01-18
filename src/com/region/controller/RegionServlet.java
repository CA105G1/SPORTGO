package com.region.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.region.model.RegService;
import com.region.model.RegVO;

public class RegionServlet extends HttpServlet {
	
	private List<String> reg_nameList =null;
	private Map<String, List<RegVO>> regionMapKeyReg_name = null;   
    
	public RegionServlet() {
        super();
    }

//	@Override
//	public void init() throws ServletException {
//		super.init();
//		RegService regService = new RegService();
//		reg_nameList = regService.getReg_nameList();
//		regionMapKeyReg_name = regService.getRegionMapKeyReg_name();
//		getServletContext().setAttribute("reg_nameList", reg_nameList);
//		getServletContext().setAttribute("regionMapKeyReg_name", regionMapKeyReg_name);
//	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		PrintWriter pw = res.getWriter();
		
		//揪團複合查詢用
		if("getReg_dist".equals(action)) {
			String reg_name = req.getParameter("reg_name");
System.out.println("reg_name="+reg_name);
			
			try {
				//取得縣市的地區名稱
				RegService regSvc = new RegService();
				List<String> reg_distlist = regSvc.getRegVOFormRegName(reg_name);
				StringBuffer sb = new StringBuffer();
				int count = 0;
				for(String reg_dist : reg_distlist) {
					if(count == 0) {
						sb.append(reg_dist);
						count++;						
					}else {
						sb.append(","+reg_dist);
					}
					
				}
System.out.println("sb=" + sb.toString());
				JSONObject obj = new JSONObject();
				obj.put("reg_dist", sb);
				pw.write(obj.toString());
				
				
			}catch(Exception e) {
				e.printStackTrace();
			}
			
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

//	@Override
//	public void destroy() {
//		super.destroy();
//	}

	
	
	

}
