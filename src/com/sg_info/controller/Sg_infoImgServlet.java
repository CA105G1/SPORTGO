package com.sg_info.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sg_info.model.Sg_infoService;

public class Sg_infoImgServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sg_infoImgServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String sg_no = req.getParameter("sg_no");
//		System.out.println("SGNO = " + sg_no);
		Sg_infoService svc = new Sg_infoService();
		byte[] pic = svc.GetByPK(sg_no).getSg_pic();
		
		res.setContentType("image/*");
		res.setContentLength(pic.length);
		ServletOutputStream out = res.getOutputStream();
		out.write(pic);
		out.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
