package com.sg_rep.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.sg_info.model.Sg_infoService;
import com.sg_rep.model.Sg_repService;

public class Sg_repServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sg_repServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		PrintWriter pw = res.getWriter();
		
		if("insert".equals(action)) {
			Map<String, String> errorMsg = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsg", errorMsg);
			
			String sg_no = req.getParameter("sg_no");
			String mem_no = req.getParameter("mem_no");
			String rep_type = req.getParameter("rep_type");
			String rep_cont = req.getParameter("rep_cont");
			
			Sg_repService svc = new Sg_repService();
			svc.insertSg_rep(sg_no, mem_no, rep_type, rep_cont);
			//為了不出現錯誤而回傳JSON物件
			JSONObject obj = new JSONObject();
			try {
				obj.put("answer", "成功檢舉!");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pw.write(obj.toString());
		}
		
		
		if("update".equals(action)) {
			String sg_no = req.getParameter("sg_no");
			String rep_no = req.getParameter("rep_no");
			String rep_status = req.getParameter("rep_status");
			
			Sg_repService svc = new Sg_repService();
			Sg_infoService sg_infosvc = new Sg_infoService();
			
			if("無違規".equals(rep_status)) {
				svc.update(rep_no, rep_status);
				String sg_status = "揪團中";
				sg_infosvc.updateStatus(sg_no, sg_status);
			}
			if("封鎖".equals(rep_status)) {
				svc.update(rep_no, rep_status);
				String sg_status = rep_status;
				sg_infosvc.updateStatus(sg_no, sg_status);
			}
			//使用重導，若使用forward會出現亂碼
			res.sendRedirect(req.getContextPath()+"/back-end/sg_info/sg_infoBackEnd.jsp");
//			RequestDispatcher dispatcher = req.getRequestDispatcher("/back-end/sg_info/sg_infoBackEnd.jsp");
//			dispatcher.forward(req, res);
		}
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
