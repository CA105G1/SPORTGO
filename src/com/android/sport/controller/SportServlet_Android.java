package com.android.sport.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.sport.model.SportService;
import com.android.sport.model.SportVO_Android;
import com.google.gson.Gson;

@WebServlet("/SportServlet_android")
public class SportServlet_Android extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SportServlet_Android() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String outStr = "";
		
		String action = req.getParameter("action");
		
		if ("getAll".equals(action)) {
			SportService service = new SportService();
			List<SportVO_Android> spList = service.getAll();
			outStr = new Gson().toJson(spList);
		}
		
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		System.out.println(outStr);
		out.print(outStr);
		out.close();
	}

}
