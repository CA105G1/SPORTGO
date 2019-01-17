package com.emp.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.css.ElementCSSInlineStyle;

import com.emp.model.EmpService;
import com.emp.model.EmpVO;
import com.emp.model.Util_Password;


public class EmpServlet extends HttpServlet {
       
    public EmpServlet() {
        super();
    }

    private final String BACK_END_INDEX_PATH = "/backEndIndex.jsp";
    private final String FOR_ADD_EMP_SUCCESS_PATH = "/back-end/emp/maintain_emp_info_back.jsp";
//    private final String BACK_END_INDEX_PATH = "/backEndIndex_fortest.jsp";
    
    private final String DB_ERROR_MSGS = "DataBaseError";
    private final String EMP_AUTH_SUPER = "超級管理員";
    private final String EMP_AUTH_NORMAL = "一般管理員";
    private final String RESULT_ERROR = "result_error";
    
    private final String EMPVO_FOR_NEW_ONE = "empVO_forNewOne";
    private final String EMPVO_FOR_FAIL = "empVO_forRes";
    
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
			case "login_reset":
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
		Map<String, String> errorMsgs = getErrorMsgsCollection(request);
		try {
			/// 驗證輸入格式
			String accountReg = "[a-zA-Z0-9_]{1,50}";
			String emp_account = request.getParameter("emp_account");
			if(emp_account==null || emp_account.trim().length()==0) {
				errorMsgs.put("emp_account","請輸入帳號");
			}else if(!emp_account.trim().matches(accountReg)) {
				errorMsgs.put("emp_account","輸入格式不正確(a-zA-Z0-9_)");
			}
			String passwordReg= "[a-zA-Z0-9_]{1,20}";
			String emp_psw = request.getParameter("emp_psw_test");
			if(emp_psw==null||emp_psw.trim().length()==0) {
				errorMsgs.put("emp_psw","請輸入密碼");
			}else if(!emp_psw.trim().matches(passwordReg)) {
				errorMsgs.put("emp_psw","輸入格式不正確(a-zA-Z0-9_)");
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
				errorMsgs.put("emp_account","帳號輸入錯誤!");
				HttpSession session = request.getSession();
				session.setAttribute("empVO", empVO);
			}else if(empVO.getEmp_psw()==null) {
				errorMsgs.put("emp_psw","輸入密碼錯誤!");
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
			errorMsgs.put(DB_ERROR_MSGS,"請再輸入一次---"+"取得資料失敗:"+e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			failureView.forward(request, response);
			return;
		}
		
		
	}
	
	private void doActionEmpLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		Map<String,String> errorMsgs = getErrorMsgsCollection(request);
		// action is "emp_logout"
//		try {
			/// no check
			/// no 永續層存取
			/// session.remove
			HttpSession session = request.getSession();
			session.removeAttribute("empVO");
			// TODO: 未來要確認是否還有其他也要刪的屬性
			RequestDispatcher view = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			view.forward(request, response);
//			return;
//		}catch (Exception e) {
//			errorMsgs.put("登出失敗:"+e.getMessage());
//			RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
//			failureView.forward(request, response);
//			return;
//		}
	}
	
	private void doActionShowRegisteredView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		Map<String, String> errorMsgs = getErrorMsgsCollection(request);
		// action is "show_registered_view"
		try {
			/// 不須確認參數
			/// 確認使用者權限，目前採用簡易欄位處理
			HttpSession session = request.getSession();
			EmpVO empVO = (EmpVO)session.getAttribute("empVO");
			if(empVO==null || !(EMP_AUTH_SUPER.equals(empVO.getEmp_auth()))) {
				errorMsgs.put(RESULT_ERROR, "讀取權限不足");
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
			errorMsgs.put(DB_ERROR_MSGS,"讀取權限失敗 : "+e.getMessage());
			/// 先設定後台首頁
			RequestDispatcher failureView = request.getRequestDispatcher(BACK_END_INDEX_PATH);
			failureView.forward(request, response);
			return;
		}
		
	}
	
	private void doActionRegisteredEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		Map<String,String> errorMsgs = getErrorMsgsCollection(request);
		// the action is "registered_emp";
		String requestUrl = (String) request.getParameter("requestUrl");
		EmpVO empVO = null;
		try {
			/// 驗證輸入資料
			String emp_name = request.getParameter("emp_name");
			if(emp_name==null || emp_name.trim().length()==0) {
				errorMsgs.put("emp_name", "請輸入名稱");
				emp_name = null;
			}
			String emp_auth = request.getParameter("emp_auth");//"一般管理員"
			if("normal_emp".equals(emp_auth)) {
				emp_auth = "一般管理員";
			}else if("supper_emp".equals(emp_auth)) {
				emp_auth = "超級管理員";
			}else if("".equals(emp_auth)){
				errorMsgs.put("emp_auth", "請設定權限");
				emp_auth= null;
			}else {
				errorMsgs.put("emp_auth", "不要猜權限");
				emp_auth= null;
			}
			String emp_phone = request.getParameter("emp_phone");
			String emp_phoneReg1 = "^(\\d{2})[\\s\\-]?(\\d{6,8})";
			String emp_phoneReg2 = "^(\\d{3})[\\s\\-]?(\\d{6,7})";
			if(emp_phone!=null && (!emp_phone.matches(emp_phoneReg1) || !emp_phone.matches(emp_phoneReg2)) ) {
				errorMsgs.put("emp_phone", "電話格式有誤");
				emp_phone = null;
			}else if(emp_phone!=null){
				emp_phone = emp_phone.replace("-", "");
			}
			String emp_email = request.getParameter("emp_email");
			if(emp_email==null||emp_email.trim().length()==0) {
				errorMsgs.put("emp_email", "請填寫E-mail");
				emp_email = null;
			}
			String emp_account = request.getParameter("emp_account");
			String accountReg = "[a-zA-Z0-9_]{1,50}";
			if(emp_account==null||emp_account.trim().length()==0) {
				errorMsgs.put("emp_account", "請輸入帳號");
				emp_account = null;
			}else if(emp_account != null && emp_account.trim().length() > 50){
				errorMsgs.put("emp_acccount", "輸入長度過長");
				emp_account = null;
			}else if(!emp_account.trim().matches(accountReg)) {
				errorMsgs.put("emp_account","輸入格式不正確(a-zA-Z0-9_)");
				emp_account = null;
			}
			String emp_psw = request.getParameter("emp_psw"); /// 注意密碼 設定方式
			String passwordReg= "[a-zA-Z0-9_]{1,20}";
			if(emp_psw==null||emp_psw.trim().length()==0) {
				errorMsgs.put("emp_psw", "請輸入帳號");
				emp_psw = null;
			}else if(emp_psw != null && emp_psw.trim().length() > 50){
				errorMsgs.put("emp_psw", "輸入長度過長");
				emp_psw = null;
			}else if(emp_psw != null && !emp_psw.trim().matches(passwordReg)) {
				errorMsgs.put("emp_psw","輸入格式不正確(a-zA-Z0-9_)");
				emp_psw = null;
			}
			java.sql.Date hiredate = null;
			try {
				hiredate = java.sql.Date.valueOf(request.getParameter("hiredate"));
			}catch (IllegalArgumentException e) {
				hiredate= new java.sql.Date(System.currentTimeMillis());
				errorMsgs.put("hiredate","請輸入日期");
			}
			
			empVO = new EmpVO();
			empVO.setEmp_name(emp_name);
			empVO.setEmp_auth(emp_auth);
			empVO.setEmp_phone(emp_phone);
			empVO.setEmp_email(emp_email);
			empVO.setEmp_account(emp_account);
			if(emp_psw!=null)
				empVO.setEmp_psw(Util_Password.encodePassword(emp_psw));
			empVO.setHiredate(hiredate);
			
			if(!errorMsgs.isEmpty()) {
				request.setAttribute(EMPVO_FOR_FAIL, empVO);
				RequestDispatcher failureView = request.getRequestDispatcher(requestUrl);
				failureView.forward(request, response);
				return;
			}
			
			/// 永續層存取
			EmpService empService = new EmpService();
//			EmpVO empVO = empService.addEmp(emp_name, emp_auth, emp_phone, emp_email, emp_account, emp_psw, hiredate);
			EmpVO empVO2 = empService.addEmp(empVO);
			/// 資料轉交
			request.setAttribute(EMPVO_FOR_NEW_ONE, empVO);
			RequestDispatcher successView = request.getRequestDispatcher("/back-end/emp/maintain_emp_info_back.jsp");
			successView.forward(request, response);
			return;
			
		} catch (Exception e) {
//			e.printStackTrace();
			request.setAttribute(EMPVO_FOR_FAIL, empVO);
			errorMsgs.put(DB_ERROR_MSGS,"註冊資料庫失敗 : "+e.getMessage());
			RequestDispatcher failureView = request.getRequestDispatcher(requestUrl);
			failureView.forward(request, response);
			return;
		}
	}
	
	private Map<String,String> getErrorMsgsCollection(HttpServletRequest request){
		Map<String,String> errorMsgs = new LinkedHashMap<>();
		request.setAttribute("errorMsgs", errorMsgs);
		return errorMsgs;
	} 

}
