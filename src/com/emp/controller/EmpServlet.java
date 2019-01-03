package com.emp.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.model.EmpService;
import com.emp.model.EmpVO;


public class EmpServlet extends HttpServlet {
       
    public EmpServlet() {
        super();
    }

//    private static final String BACK_END_INDEX_PATH = "/backEndIndex.jsp";
    private static final String BACK_END_INDEX_PATH = "/backEndIndex_fortest.jsp";
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		System.out.println("action : "+action);
		switch (action) {
			case "emp_login":
				doActionEmpLogin(request,response);
				break;
			case "emp_logout":
				doActionEmpLogout(request, response);
				break;
			case "show_registered_view":
				doActionShowRegisteredView(request, response);
				break;
			case "registered_emp":
				doActionRegisteredEmp(request,response);
				break;
			default:
				break;
		}
		return;
	}
	
	private void doActionEmpLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// action is "emp_login"
		List<String> errorMsgs = getErrorMsgsCollection(request);
		try {
			/// 驗證輸入格式
			String accountReg = "[a-zA-Z0-9_]{1,50}";
			String emp_account = request.getParameter("emp_account");
			if(emp_account==null || emp_account.trim().length()==0) {
				errorMsgs.add("請輸入帳號");
			}else if(!emp_account.trim().matches(accountReg)) {
				errorMsgs.add("輸入格式不正確(a-zA-Z0-9_)");
			}
			String passwordReg= "[a-zA-Z0-9_]{1,20}";
			String emp_psw = request.getParameter("emp_psw");
			if(emp_psw==null||emp_account.trim().length()==0) {
				errorMsgs.add("請輸入密碼");
			}else if(!emp_psw.trim().matches(passwordReg)) {
				errorMsgs.add("輸入格式不正確(a-zA-Z0-9_)");
			}
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
				failureView.forward(request, response);
				return;
			}
			//// 永續層存取
			EmpService empService = new EmpService();
			EmpVO empVO = empService.checkEmpAccountByAccount(emp_account, emp_psw);
			if(empVO==null) {
				errorMsgs.add("帳號輸入錯誤!");
				HttpSession session = request.getSession();
				session.setAttribute("empVO", empVO);
			}else if(empVO.getEmp_psw()==null) {
				errorMsgs.add("輸入密碼錯誤!");
			}
			if(!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
				failureView.forward(request, response);
				return;
			}
			/////
			HttpSession session = request.getSession();
			session.setAttribute("empVO", empVO);
			RequestDispatcher successView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			successView.forward(request, response);
			return;
		}catch (Exception e) {
			errorMsgs.add("請再輸入一次---"+"取得資料失敗:"+e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			failureView.forward(request, response);
			return;
		}
		
		
	}
	
	private void doActionEmpLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errorMsgs = getErrorMsgsCollection(request);
		// action is "emp_logout"
		try {
			/// no check
			/// no 永續層存取
			/// session.remove
			HttpSession session = request.getSession();
			session.removeAttribute("empVO");
			RequestDispatcher view = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			view.forward(request, response);
//			return;
		}catch (Exception e) {
			errorMsgs.add("登出失敗:"+e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			failureView.forward(request, response);
			return;
		}
		
		
		
	}
	
	private void doActionShowRegisteredView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
		// action is "show_registered_view"
		try {
			/// 不須確認參數
			/// 確認使用者權限，目前採用簡易欄位處理
			HttpSession session = request.getSession();
			EmpVO empVO = (EmpVO)session.getAttribute("empVO");
			if(empVO==null || !("超級管理員".equals(empVO.getEmp_auth()))) {
				errorMsgs.add("讀取權限不足");
				request.setAttribute("no_auth", "no_auth");
				/// 先設定後台首頁
				RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
				failureView.forward(request, response);
				return;
			}
			/// 跳轉到註冊頁面
			RequestDispatcher sussesView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			sussesView.forward(request, response);
			return;
		} catch (Exception e) {
			errorMsgs.add("讀取權限失敗 : "+e.getMessage());
			/// 先設定後台首頁
			RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			failureView.forward(request, response);
			return;
		}
		
	}
	
	private void doActionRegisteredEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		List<String> errorMsgs = getErrorMsgsCollection(request);
		// the action is "registered_emp";
		try {
			/// 驗證輸入資料
			String emp_name = request.getParameter("emp_name");
			String emp_auth = request.getParameter("emp_auth");//"一般管理員"
			String emp_phone = request.getParameter("emp_phone");
			String emp_email = request.getParameter("emp_email");
			String emp_account = request.getParameter("emp_account");
			String emp_psw = request.getParameter("emp_psw"); /// 注意密碼 設定方式
			java.sql.Date hiredate = null;
			try {
				hiredate = java.sql.Date.valueOf(request.getParameter("hiredate"));
			}catch (IllegalArgumentException e) {
				hiredate= new java.sql.Date(System.currentTimeMillis());
				errorMsgs.add("請輸入日期");
			}
			/// 永續層存取
			EmpService empService = new EmpService();
			EmpVO empVO = empService.addEmp(emp_name, emp_auth, emp_phone, emp_email, emp_account, emp_psw, hiredate);
			
			/// 資料轉交
			
			
			
			
			
		} catch (Exception e) {
			errorMsgs.add("註冊資料庫失敗 : "+e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			failureView.forward(request, response);
			return;
		}
	}
	
	private List<String> getErrorMsgsCollection(HttpServletRequest request){
		List<String> errorMsgs = new LinkedList<>();
		request.setAttribute("errorMsgs", errorMsgs);
		return errorMsgs;
	} 

}
