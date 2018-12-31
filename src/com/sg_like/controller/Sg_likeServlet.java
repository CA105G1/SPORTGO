package com.sg_like.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.sg_like.model.Sg_likeService;

public class Sg_likeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sg_likeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		PrintWriter pw = res.getWriter();
		
		if("insert".equals(action)) {
			Map<String, String > errorMsg = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsg", errorMsg);
			
			String sg_no = req.getParameter("sg_no");
			String mem_no = req.getParameter("mem_no");
			
			Sg_likeService svc = new Sg_likeService();
			svc.insertSg_like(sg_no, mem_no);
			//為了不出現錯誤而回傳JSON物件
			JSONObject obj = new JSONObject();
			try {
				obj.put("answer", "成功加入收藏!");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pw.write(obj.toString());
		}
		
		
		if("delete".equals(action)) {
			Map<String, String > errorMsg = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsg", errorMsg);
			
			String sg_no = req.getParameter("sg_no");
			String mem_no = req.getParameter("mem_no");
			
			Sg_likeService svc = new Sg_likeService();
			svc.deleteSg_like(sg_no, mem_no);
			
			//為了不出現錯誤而回傳JSON物件
			JSONObject obj = new JSONObject();
			try {
				obj.put("answer", "取消收藏!");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pw.write(obj.toString());
		}
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
