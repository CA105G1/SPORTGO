package com.club.controller;

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

import com.memberlist.model.MemberlistVO;

public class ClubFilter implements Filter {
	
	ServletContext context =null;

	public ClubFilter() {
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
		MemberlistVO memberlistVO = (MemberlistVO)session.getAttribute("memberlistVO");
		if(memberlistVO==null) {
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath()+"/front-end/memberlist/Login.jsp");
			return;
		}else {
			String mem_no = memberlistVO.getMem_no();
			String club_no = req.getParameter("club_no");
			if(club_no == null) {
				res.sendRedirect(req.getContextPath()+"/front-end/club/club_list.jsp");
			}
			req.setAttribute("mem_no", mem_no);
			req.setAttribute("club_no", club_no);
			
			chain.doFilter(request, response);
		}
	}
}
