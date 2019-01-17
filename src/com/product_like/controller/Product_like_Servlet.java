package com.product_like.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.product_like.model.Product_likeVO;
import com.product_like.model.Product_like_Service;
import com.shoppingcart.model.ShoppingcartDAO;
import com.shoppingcart.model.ShoppingcartVO;

import redis.clients.jedis.Jedis;


//問題是否要加下面著個才可以接到form表單呢
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5  * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class Product_like_Servlet extends HttpServlet{

	
	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("action:"+action);
if ("insert".equals(action)) { //來自listOnePro_front.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
//			try {
			 
			HttpSession session = req.getSession();
			
			String mem_no = session.getAttribute("mem_no").toString();//********需要把listAllPro_front.jsp中的session拿掉接正式版的會員********
			if(mem_no == null || mem_no.trim().length() == 0) {
				errorMsgs.add("未登入會員");
			}
			String pro_no = req.getParameter("pro_no");
			if(pro_no == null || pro_no.trim().length() == 0) {
				errorMsgs.add("未購買商品");
			}

			/***************************3.開始查詢資料***********/
			Product_like_Service prolikeSvc = new Product_like_Service();   //準備再次使用pro_no取得proVO物件
			Product_likeVO product_likeVO = new Product_likeVO();
			product_likeVO.setMem_no(mem_no);
			product_likeVO.setProduct_no(pro_no);
			product_likeVO = prolikeSvc.addProlike(product_likeVO); //資料庫取出的proVO物件,
			req.setAttribute("product_likeVO", product_likeVO);               // 存入req
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			
			PrintWriter out = res.getWriter();
			
			
			String job = new JSONObject().toString();//需要回傳不然ajax會出錯
			out.write(job);
			out.flush();
			out.close();
		}
if ("delete".equals(action)) { //來自listOnePro_front.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		//	try {
			 
			HttpSession session = req.getSession();
			
			String mem_no = session.getAttribute("mem_no").toString();//********需要把listAllPro_front.jsp中的session拿掉接正式版的會員********
			if(mem_no == null || mem_no.trim().length() == 0) {
				errorMsgs.add("未登入會員");
			}
			String pro_no = req.getParameter("pro_no");
			if(pro_no == null || pro_no.trim().length() == 0) {
				errorMsgs.add("未購買商品");
			}
		
			/***************************3.開始查詢資料***********/
			Product_like_Service prolikeSvc = new Product_like_Service();   //準備再次使用pro_no取得proVO物件
			Product_likeVO product_likeVO = new Product_likeVO();
			product_likeVO.setMem_no(mem_no);
			product_likeVO.setProduct_no(pro_no);
			product_likeVO = prolikeSvc.deleteProlike(product_likeVO); //資料庫取出的proVO物件,
			req.setAttribute("product_likeVO", product_likeVO);               // 存入req
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			
			PrintWriter out = res.getWriter();
			
			
			String job = new JSONObject().toString();//需要回傳不然ajax會出錯
			out.write(job);
			out.flush();
			out.close();
		}

	}
}
