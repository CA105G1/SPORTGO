package com.ord.controller;

import java.io.*;
import java.lang.reflect.Array;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import org.json.JSONException;
import org.json.JSONObject;

import com.address.model.AddressService;
import com.memberlist.model.MemberlistService;
import com.ord.model.OrdJDBCDAO;
import com.ord.model.OrdService;
import com.ord.model.OrdVO;
import com.orddetails.model.OrddetailsVO;
import com.pro.controller.ProServlet;
import com.product.model.ProductService;
import com.product.model.ProductVO;
import com.productclass.model.ProductClassService;
import com.productclass.model.ProductClassVO;
import com.shoppingcart.model.ShoppingcartDAO;
import com.shoppingcart.model.ShoppingcartVO;



@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5  * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class OrdServlet extends HttpServlet {
	
	//-------------------------後端路徑---------------------//
	private static final String PATH_LIST_ONE_PRO = "/back-end/pro/listOnePro.jsp";
	private static final String PATH_UPDATE_PRO_INPUT = "/back-end/pro/update_pro_input.jsp";
	private static final String PATH_LIST_ALL_PRO = "/back-end/pro/listAllPro.jsp";
	private static final String PATH_ADDPRO = "/back-end/pro/addPro.jsp";
	//-------------------------前端路徑---------------------//
	private static final String PATH_FRONT_LIST_ALL_PRO = "/front-end/pro/listAllPro_front.jsp";
	private static final String PATH_FRONT_LIST_ONE_PRO = "/front-end/pro/listOnePro_front.jsp";
//	private static final String PATH_SHOPPINGCART_FRONT = "/front-end/pro/ord_front.jsp";
	//------------------------模板路徑(訂單的address要換舊版時需開)----------------------//
	private static final String PATH_SHOPPINGCART_FRONT = "/front-end/pro/alazea-gh-pages/shoppingcart_front.jsp";
	private static final String PATH_ORD_FRONT = "/front-end/pro/alazea-gh-pages/ord_front.jsp";

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}
 
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println("action :" + action);
if ("insert".equals(action)) { //來自shoppingcart_front.jsp的請求
			
			Map<String,String> errorMsgs = new LinkedHashMap<String,String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				HttpSession session = req.getSession();
				//會員編號
				String mem_no = session.getAttribute("mem_no").toString();
		//		if(mem_no == null || mem_no.trim().length() == 0) {
		//			errorMsgs.add("未登入會員");
		//		}
				/***********************1.接收請求參數 - 輸入格式的錯誤處理(信用卡)*************************/
				String card = req.getParameter("card-number");
				
				String expirydate = req.getParameter("expirydate");
				
				String cvc = req.getParameter("cvc");
				
				if("".equals(card)||(card.trim()).length()==0) {
					errorMsgs.put("card","信用卡欄位必填");
				}else {
					card = remove_Multi_Spaces(card);
				}
		
				if("".equals(expirydate) || expirydate == null) {
					errorMsgs.put("expirydate","信用卡日期欄位必填");
				}else {
					expirydate = remove_Multi_Spaces(expirydate);
				}
				if("".equals(cvc)||(cvc.trim()).length()==0) {
					errorMsgs.put("cvc","信用卡驗證碼必填");
				}
				/***********************1.接收請求參數 - 輸入格式的錯誤處理(收貨地址)*************************/
				
				
				String receiver = req.getParameter("address_receiver");
				String phone = req.getParameter("address_phone");
				String country = req.getParameter("countries");
				String city = req.getParameter("city");
				String town = req.getParameter("town");
				String zip = req.getParameter("zipcode");
				String detail = req.getParameter("address_detail");
				
				
				
		//		String receiver = req.getParameter("receiver");
		//		String phone = req.getParameter("phone");
		//		String country = req.getParameter("country");
		//		String city = req.getParameter("city");
		//		String detail = req.getParameter("detail");
		//		String zip = req.getParameter("zip");
				
				if("".equals(receiver)||(receiver.trim()).length()==0) {
					errorMsgs.put("receiver","收件人欄位必填");
				}
				if("".equals(phone)||(phone.trim()).length()==0) {
					errorMsgs.put("phone","電話欄位必填");
				}
				if("".equals(country)||(country.trim()).length()==0) {
					errorMsgs.put("country","國家欄位必填");
				}
				if("".equals(city)||(city.trim()).length()==0) {
					errorMsgs.put("city","城市欄位必填");
				}
				if("".equals(detail)||(detail.trim()).length()==0) {
					errorMsgs.put("detail","地址欄位必填");
				}
				if("".equals(zip)||(zip.trim()).length()==0) {
					errorMsgs.put("zip","郵遞區號欄位必填");
				}
		
				detail = town + detail;//地區與地址相加
				/***********************1.接收請求參數 - 輸入格式的錯誤處理(購物車成訂單)*************************/
				String integerReg = "([0-9]{0,7})";
				String[] pro_no = req.getParameterValues("pro_no");
				
		//		String pro_no = req.getParameter("pro_no");
		//		System.out.println("pro_no" + pro_no);
		//		if(pro_no == null || pro_no.trim().length() == 0) {
		//			errorMsgs.add("未購買商品");
		//		}
				
				//解析網頁送來的圖片
		//		Part part = req.getPart("pro_pic");			
		//		InputStream in = part.getInputStream();	
		//		byte[] pro_pic = ProServlet.Photo(in);
		//		if (pro_pic == null || pro_pic.length == 0) {
		//			errorMsgs.add("請上傳圖片");
		//		}
				
				//拿取網頁資料
		
		
		
				//下單日期(sql自動)
		//		java.sql.Timestamp ord_date = null;
		//		try {
		//			ord_date = java.sql.Timestamp.valueOf(req.getParameter("ord_date").trim());
		//		} catch (NullPointerException e) {
		//			ord_date = new Timestamp(System.currentTimeMillis());
		//			errorMsgs.add("下單日期測試");
		//		}
				
				//出貨日期
				java.sql.Timestamp ord_deldate = null;
		//		try {
		//			ord_deldate = java.sql.Timestamp.valueOf(req.getParameter("ord_deldate").trim());
		//		} catch (NullPointerException e) {
		//			ord_deldate = new Timestamp(System.currentTimeMillis());
		//			errorMsgs.add("出貨日期測試");
		//		}
				//訂單狀態
		//		String ord_status = req.getParameter("ord_status");
				String ord_status = "待出貨";
		//		if (ord_status == null || ord_status.trim().length() == 0) {
		//			errorMsgs.add("狀態請勿空白");
		//		}
		
			    //退貨日期
				java.sql.Timestamp ord_backdeldate = null;
		//		try {
		//			ord_backdeldate = java.sql.Timestamp.valueOf(req.getParameter("ord_backdeldate").trim());
		//		} catch (NullPointerException e) {
		//			ord_backdeldate = new Timestamp(System.currentTimeMillis());
		//			errorMsgs.add("退貨日期測試");
		//		}
				//訂單金額
				Integer ord_amount = 0;
		//		try {
		//			if(!req.getParameter("ord_amount").trim().matches(integerReg)) {
		//				 errorMsgs.add("訂單金額請勿非數字");
		//				 ProductService proSvc  = new ProductService();//須改
		//				 ord_amount = proSvc.getOneProduct(pro_no).getPro_safestock();//須改
		//			 } else {
		//				 ord_amount = new Integer(req.getParameter("ord_amount").trim());
		//			 }
		//		} catch (NumberFormatException e) {
		//			errorMsgs.add("訂單金額請勿空白");
		//		}
				
				//退貨金額
				Integer ord_backamount = 0;
		//		try {
		//			if(!req.getParameter("ord_backamount").trim().matches(integerReg)) {
		//				 errorMsgs.add("退貨金額請勿非數字");
		//				 ProductService proSvc  = new ProductService();//須改
		//				 ord_backamount = proSvc.getOneProduct(pro_no).getPro_safestock();//須改
		//			 } else {
		//				 ord_backamount = new Integer(req.getParameter("ord_backamount").trim());
		//			 }
		//		} catch (NumberFormatException e) {
		//			errorMsgs.add("退貨金額請勿空白");
		//		}
				//數量
		//		String[] pro_count = req.getParameterValues("pro_count"); 
				
				
		
				/***********備註*************/
				/*訂單有一些會是null與0的情況
				 * 前端部分因為有兩個form表單的問題，所以刪除按鈕可能需要用ajax處理
				 */
				String mem_noP = mem_no + "P";
				ProductService proSvc1 = new ProductService();
				List<OrddetailsVO> testList = new ArrayList<OrddetailsVO>(); // 準備置入訂單數量
				OrdJDBCDAO ordDAO = new OrdJDBCDAO();
				/***********購物車與商品庫存判斷**************/
				
				String ord_no = null;
				if(!errorMsgs.isEmpty() || pro_no == null ) {  //判斷有無選擇購物車商品
					if(pro_no == null) {
						errorMsgs.put("empty_product","未選擇商品");
					}
				} else {
				for(int i = 0 ; i < pro_no.length ; i ++) {
					ShoppingcartDAO cartDAO = new ShoppingcartDAO();
					
					Integer cart_pro_count = cartDAO.findByCount(mem_noP, pro_no[i]);
					ProductVO proVO = proSvc1.getProductStock(pro_no[i], cart_pro_count);
					//查詢後商品數量為0時
					if(proVO.getPro_stock().intValue() == 0) {
						/****永續層****/
						//更動(減)商品庫存量並改狀態為已售完
						System.out.println("近來已售完");
						proSvc1.updateStock(pro_no[i], cart_pro_count);
						proSvc1.updateShelve(pro_no[i], "售完");
					} else {
					//查詢後若不為0時，只更動商品庫存量
						/****永續層****/
						System.out.println("更動庫存量");
						proSvc1.updateStock(pro_no[i], cart_pro_count);
					}
				}
				/***************************2.開始新增資料***************************************/
				    
					for(int i = 0 ; i < pro_no.length ; i ++) {  //選擇幾樣商品並加入到list的orddetailsVO
						ShoppingcartDAO cartDAO = new ShoppingcartDAO();
		            	Integer pro_bonus = proSvc1.getOneProduct(pro_no[i]).getPro_bonus();
		            	Integer pro_count = cartDAO.findByCount(mem_noP, pro_no[i]);
		            	ord_amount += pro_bonus*pro_count;
						testList.add(i, new OrddetailsVO(pro_no[i] , pro_bonus,pro_count));
		            }
					ShoppingcartDAO cartDAO = new ShoppingcartDAO();
					cartDAO.deleteAll(mem_noP, pro_no);
					
					/****製作訂單與訂單明細***/
					OrdVO ordVO = new OrdVO();
					//ordVO.setOrd_no(ord_no); jdbc以用sql自動  
					ordVO.setMem_no(mem_no);
		//			ordVO.setOrd_date(ord_date);  jdbc以用sql自動  
					ordVO.setOrd_deldate(ord_deldate); 
					ordVO.setOrd_status(ord_status);
					ordVO.setOrd_backdeldate(ord_backdeldate);
					ordVO.setOrd_amount(ord_amount);
					ordVO.setOrd_backamount(ord_backamount);
					 ord_no = ordDAO.insertWithOrdds(ordVO, testList);
					for(int i = 0 ; i < testList.size() ; i ++) {
						System.out.println(testList.get(i).getPro_no());
					}
				}
				
				
		
				
		
		
		
		
				/*****發生錯誤時，讓購物車保持裡面有商品*****/
				if (!errorMsgs.isEmpty()) {
					System.out.println(errorMsgs);
					ProductService proSvc = new ProductService();
					ShoppingcartDAO cartDAO = new ShoppingcartDAO();
					List<ProductVO> proVOList = new ArrayList<>();
					List<Integer> pro_countList = new ArrayList<>();
					Map<String , String> hAll =  cartDAO.getAll(mem_noP);
					System.out.println(hAll);
					for(String pro_noAll : hAll.keySet()) {
						proVOList.add(proSvc.getOneProduct(pro_noAll));
						System.out.println("訂單數量" +hAll.get(pro_noAll));
		//				pro_countList.add(Integer.parseInt(hAll.get(pro_no)));
					}
					req.setAttribute("proVOList", proVOList);
					req.setAttribute("hAll", hAll);
					RequestDispatcher failureView = req
							.getRequestDispatcher(PATH_SHOPPINGCART_FRONT);
					failureView.forward(req, res);
					return;
				}
				
				
				/****永續層存取(收貨地址,信用卡)****/
				AddressService addressSvc = new AddressService();
				MemberlistService service = new MemberlistService();
				try {
					addressSvc.addNewAddress(mem_no, receiver, phone, country, city, detail, zip);
					service.renewCard(mem_no, card, expirydate);
				} catch (RuntimeException e) {
					System.out.println("新增資料錯誤"+e.getMessage());
					log(e.getMessage());
				}

				
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = PATH_ORD_FRONT;
				req.setAttribute("ord_no", ord_no);
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交ord_front.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				RequestDispatcher failureView = req
						.getRequestDispatcher(PATH_SHOPPINGCART_FRONT);
				failureView.forward(req, res);
				e.printStackTrace();
			}
		}
if ("getAll_display".equals(action)) { //來自shoppingcart_front.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		}

if ("ok_cancel".equals(action)) { //來自shoppingcart_front.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			String ord_no = req.getParameter("ord_no");
			String ord_status = req.getParameter("ord_status");
            
			/*****永續存取*****/
			OrdService ordSvc = new OrdService();
			OrdVO ordVO = ordSvc.updataStatus(ord_no, ord_status);
			/*****轉交需要設定這三行不然JSON會有亂碼*******/
			res.setContentType("text/xml;charset=UTF-8");
			res.setHeader("Cache-Control", "no-cache");
			res.setCharacterEncoding("UTF-8");
			
			PrintWriter out = res.getWriter();
			
//			String return_ord_no = "{\"ord_no\":"+ord_no+"}";
			try {
			JSONObject obj = new JSONObject();
			obj.put("ord_no", ord_no); 
			obj.put("ord_status", ord_status);
//			String job = new JSONObject(return_ord_no).toString();//需要回傳不然ajax會出錯
			out.write(obj.toString());
			out.flush();
			out.close();
			
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
/*
if ("cancel".equals(action)) { //來自shoppingcart_front.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			String ord_no = req.getParameter("ord_no");
			String ord_status = req.getParameter("ord_status");
		System.out.println("刪除訂單");
			OrdService ordSvc = new OrdService();
		
			int i = ordSvc.updataStatus(ord_no, ord_status);
			System.out.println("更新比數" + i);
			
			PrintWriter out = res.getWriter();
			String return_ord_no = "{\"ord_no\":"+ord_no+"}";
			try {

			String job = new JSONObject(return_ord_no).toString();//需要回傳不然ajax會出錯
			out.write(job);
			out.flush();
			out.close();
			
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}*/
	}

    public static byte[] Photo (InputStream in) {  //將inputStream to byte[]
    	   
        byte[] buff = new byte[8000];
        int bytesRead = 0;
        ByteArrayOutputStream bao = new ByteArrayOutputStream();
        try {
			while((bytesRead = in.read(buff)) != -1) {
			   bao.write(buff, 0, bytesRead);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
        byte[] data = bao.toByteArray();
		
    	return data;
    }
	public static String remove_Multi_Spaces(String text) {
		java.util.StringTokenizer st = new java.util.StringTokenizer(text, " ");
        StringBuffer sb = new StringBuffer();
        while(st.hasMoreElements()){
        	String nextString = (String)st.nextElement();
            sb.append(nextString);
        }
		return sb.toString().trim();
	}
}
