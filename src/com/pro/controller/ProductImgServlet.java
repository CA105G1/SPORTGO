package com.pro.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.product.model.ProductService;


public class ProductImgServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
	    req.setCharacterEncoding("UTF-8");
	    String pro_no = req.getParameter("pro_no");
	    ProductService  proSvc = new ProductService();
	    byte[] pic = proSvc.getOneProduct(pro_no).getPro_pic();  //DB沒有圖片時會錯
	
	   ServletOutputStream out = res.getOutputStream();
	   res.setContentLength(pic.length);
	   res.setContentType("image/*");
	   out.write(pic);
	   out.close();
	
	}
}
