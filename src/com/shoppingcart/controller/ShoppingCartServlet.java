package com.shoppingcart.controller;

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

import org.json.JSONObject;

import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.shoppingcart.model.ShoppingcartDAO;
import com.shoppingcart.model.ShoppingcartVO;

import redis.clients.jedis.Jedis;


//問題是否要加下面著個才可以接到form表單呢
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5  * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class ShoppingCartServlet extends HttpServlet{
	
	private static final String PATH_LISTONEPRO_FRONT = "/front-end/pro/listOnePro_front.jsp";
	private static final String PATH_SHOPPINGCART = "/front-end/pro/shoppingcart_front.jsp";
	
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
			Integer pro_count = new Integer(req.getParameter("pro_count"));//未驗證
			
			
			System.out.println("mem_no :" + mem_no);
			System.out.println("pro_no :" + pro_no);
			
			ShoppingcartVO cartVO = new ShoppingcartVO();
			cartVO.setMem_no(mem_no);
			cartVO.setPro_no(pro_no);
			cartVO.setPro_count(pro_count);
			
			
			//購物車中的商品必須在頁面上持續且商業邏輯化顯示  (存於redis中則是...? er模型的表格嗎
			//以及存在redis會有覆蓋的問題
			
			/***************************2.開始新增資料***************************************/
			ShoppingcartDAO carDAO = new ShoppingcartDAO();
			carDAO.insert(cartVO);
			
			
			/***************************3.開始查詢資料***********/
			ProductService proSvc = new ProductService();   //準備再次使用pro_no取得proVO物件
			ProductVO proVO = proSvc.getOneProduct(pro_no); //資料庫取出的proVO物件,
			req.setAttribute("proVO", proVO);               // 存入req
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			String job = new JSONObject().toString();//需要回傳不然ajax會出錯
			out.write(job);
			out.flush();
			out.close();
			/***************************4.新增完成,準備轉交(Send the Success view)***********/
//			String url = PATH_LISTONEPRO_FRONT;
//			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交lisOnePro_front.jsp
//			successView.forward(req, res);	
			
			// Send the use back to the form, if there were errors
//			if (!errorMsgs.isEmpty()) {
//				System.out.println(errorMsgs);
////				req.setAttribute("proVO", proVO); // 含有輸入格式錯誤的proVO物件,也存入req
//				RequestDispatcher failureView = req
//						.getRequestDispatcher(PATH_ADDPRO);
//				failureView.forward(req, res);
//				return;
//			}
//			} catch (Exception e) {
//				RequestDispatcher failureView = req
//						.getRequestDispatcher(PATH_LISTONEPRO_FRONT);
//				failureView.forward(req, res);
//			}
			
		}
		if ("getAll_For_Display".equals(action)) { //來自listOnePro_front.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = req.getSession();
			
			String mem_no = session.getAttribute("mem_no").toString();//********需要把listAllPro_front.jsp中的session拿掉接正式版的會員********
			if(mem_no == null || mem_no.trim().length() == 0) {
				errorMsgs.add("未登入會員");
			}			
			
			ProductService proSvc = new ProductService();
			ShoppingcartDAO cartDAO = new ShoppingcartDAO();
			List<ProductVO> proVOList = new ArrayList<>();
			List<Integer> pro_countList = new ArrayList<>();
			Map<String , String> hAll =  cartDAO.getAll(mem_no);
			for(String pro_no : hAll.keySet()) {
				proVOList.add(proSvc.getOneProduct(pro_no));
//				pro_countList.add(Integer.parseInt(hAll.get(pro_no)));
			}
			
//		
			
			/***************************4.準備轉交(Send the Success view)***********/
			req.setAttribute("proVOList", proVOList);
			req.setAttribute("hAll", hAll);
			String url = PATH_SHOPPINGCART;
			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交lisOnePro_front.jsp
			successView.forward(req, res);	
		}
		if("delete".equals(action)) {
			System.out.println("有近來");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			HttpSession session = req.getSession();
			
			String mem_no = session.getAttribute("mem_no").toString();//********需要把listAllPro_front.jsp中的session拿掉接正式版的會員********
			if(mem_no == null || mem_no.trim().length() == 0) {
				errorMsgs.add("未登入會員");
			}
			String pro_no = req.getParameter("pro_no");
			if(pro_no == null || pro_no.trim().length() == 0) {
				errorMsgs.add("未選取商品");
			}
			ShoppingcartDAO cartDAO = new ShoppingcartDAO();
			cartDAO.delete(mem_no, pro_no);
			
			ProductService proSvc = new ProductService();
			List<ProductVO> proVOList = new ArrayList<>();
			List<Integer> pro_countList = new ArrayList<>();
			Map<String , String> hAll =  cartDAO.getAll(mem_no);
			for(String pro_no1 : hAll.keySet()) {
				proVOList.add(proSvc.getOneProduct(pro_no1));
			}
			
			
			/***************************4.準備轉交(Send the Success view)***********/
			res.setContentType("text/plain");
			res.setCharacterEncoding("UTF-8");
			PrintWriter out = res.getWriter();
			String job = new JSONObject().toString();//需要回傳不然ajax會出錯
			out.write(job);
			out.flush();
			out.close();
//			req.setAttribute("proVOList", proVOList);
//			req.setAttribute("hAll", hAll);
//			String url = PATH_SHOPPINGCART;
//			RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交lisOnePro_front.jsp
//			successView.forward(req, res);	
		
			
		}

	}
}
