package com.memberlist.controller;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {
	
	ServletContext context =null;

	public LoginFilter() {
    }
    
	public void init(FilterConfig config){
    	context = config.getServletContext();
    }

	public void destroy() {
	context = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		Object mem_no = session.getAttribute("mem_no");
		if(mem_no==null) {
			session.setAttribute("location", req.getRequestURL());
			res.sendRedirect(req.getContextPath()+"/front-end/memberlist/Login.jsp");
			return;
		}else {
			chain.doFilter(request, response);
		}
	}
}
