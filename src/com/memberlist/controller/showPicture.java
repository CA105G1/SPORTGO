package com.memberlist.controller;

import java.io.IOException;
import com.memberlist.model.*;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@MultipartConfig(fileSizeThreshold=1024*1024,maxFileSize=5*1024*1024,maxRequestSize=5*5*1024*1024)
public class showPicture extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public showPicture() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String mem_no  = req.getParameter("mem_no");
		MemberlistService service = new MemberlistService();
		MemberlistVO memberlistVO = service.getOneMem(mem_no);
		byte[] pic =memberlistVO.getMem_pic();
		ServletOutputStream outpic = res.getOutputStream();
		res.setContentLength(pic.length);
		res.setContentType("image/*");
		outpic.write(pic);
		outpic.close();
	}

}
