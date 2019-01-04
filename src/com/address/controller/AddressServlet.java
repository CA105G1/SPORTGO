package com.address.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.address.model.*;
import com.memberlist.model.*;

public class AddressServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddressServlet() {
        super();
    }
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		HttpSession session = req.getSession();
		MemberlistVO memberlistVO = null;
		String mem_no = null;
		AddressService service = null;
		Map<String,String> errorMsgs = new LinkedHashMap<>();
		req.setAttribute("errorMsgs", errorMsgs);
		
		memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
		
		if(memberlistVO==null) {
			res.sendRedirect("/front-end/memberlist/Login.jsp");
			return;
		}
		String action = req.getParameter("action");
		mem_no = memberlistVO.getMem_no();
		/****新增地址****/
		if("add_address".equals(action)) {
			/*****接受請求參數 錯誤驗證****/
			service = new AddressService();
			String receiver = req.getParameter("receiver");
			String phone = req.getParameter("phone");
			String country = req.getParameter("country");
			String city = req.getParameter("city");
			String detail = req.getParameter("detail");
			String zip = req.getParameter("zip");
			
			if("".equals(receiver)||(receiver.trim()).length()==0) {
				errorMsgs.put("receiver", "收件人欄位必填");
			}
			if("".equals(phone)||(phone.trim()).length()==0) {
				errorMsgs.put("phone", "電話欄位必填");
			}
			if("".equals(country)||(country.trim()).length()==0) {
				errorMsgs.put("country", "國家欄位必填");
			}
			if("".equals(city)||(city.trim()).length()==0) {
				errorMsgs.put("city", "城市欄位必填");
			}
			if("".equals(detail)||(detail.trim()).length()==0) {
				errorMsgs.put("detail", "地址欄位必填");
			}
			if("".equals(zip)||(zip.trim()).length()==0) {
				errorMsgs.put("zip", "郵遞區號欄位必填");
			}
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher notnull = req.getRequestDispatcher("address.jsp");
				notnull.forward(req, res);
				return;
			}
			/****永續層存取****/
			try {
				service.addNewAddress(mem_no, receiver, phone, country, city, detail, zip);
				System.out.println("新增地址成功");
			} catch (RuntimeException e) {
				System.out.println("新增資料錯誤"+e.getMessage());
				log(e.getMessage());
			}
			/*****準備轉交****/
			if(errorMsgs.isEmpty()) {
				memberlistVO = null;
				mem_no = null;
				RequestDispatcher dosomething = req.getRequestDispatcher("address.jsp");
				dosomething.forward(req, res);
			}
		}
		/****尋找會員地址****/
		if("Member_address".equals(action)) {
			List<AddressVO> addresslist = null;
			service = new AddressService();
			System.out.println(mem_no);
			/****永續層存取****/
			try {
				addresslist = service.findMyAddress(mem_no);
			}catch(RuntimeException re){
				System.out.println("找不到地址");
				re.printStackTrace(System.err);
			}
			/*****準備轉交****/
			req.setAttribute("addresslist", addresslist);
			memberlistVO = null;
			mem_no = null;
			RequestDispatcher listgo = req.getRequestDispatcher("address.jsp");
			listgo.forward(req, res);
		}
		/****刪除地址****/
		if("delete_address".equals(action)) {
			List<AddressVO> addresslist = null;
			service = new AddressService();
			/*****接受請求參數 錯誤驗證****/
			String addr_no = req.getParameter("addr_no");
			/****永續層存取****/
			try {
				addresslist = service.findMyAddress(mem_no);
			}catch(RuntimeException re){
				System.out.println("找不到地址");
				re.printStackTrace(System.err);
			}
			for(AddressVO list : addresslist) {
				String no = list.getAddr_no();
				if(no.equals(addr_no)) {
					try {
						service.deleteAddress(addr_no);
						System.out.println("刪除地址成功");
						break;
					} catch (RuntimeException re) {
						System.out.println("刪除地址失敗");
						re.printStackTrace(System.err);
					}
				}
			}
			/*****準備轉交****/
			memberlistVO = null;
			mem_no = null;
			RequestDispatcher listgo = req.getRequestDispatcher("address.jsp");
			listgo.forward(req, res);
		}
		
	}

}
