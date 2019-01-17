package com.club.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.club_memberlist.model.Club_memberlistService;
import com.club_memberlist.model.Club_memberlistVO;
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
			System.out.println("memberlistVO"+memberlistVO);
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath()+"/front-end/memberlist/Login.jsp");
			return;
		}
		String mem_no = memberlistVO.getMem_no();
		String club_no = (String) session.getAttribute("club_no");
		System.out.println("club "+club_no+mem_no);
//		if(club_no == null) {
//			res.sendRedirect(req.getContextPath()+"/front-end/club/club_list.jsp");
//			return;
//		}
		Club_memberlistService memberlistService = new Club_memberlistService();
		List<Club_memberlistVO> memberlistVOs = memberlistService.getByClub(club_no);
		for(Club_memberlistVO member : memberlistVOs) {
			if(mem_no.equals(member.getMem_no())) {
				chain.doFilter(request, response);
				return;
			}
		}
		String uri = req.getRequestURI();
		System.out.println(req.getRequestURI());
//		res.sendRedirect(uri);
		req.setAttribute("no_member", "no_member");
		RequestDispatcher go = req.getRequestDispatcher("/clubfront.do?actionfront=getOneClub&club_no="+club_no);
		go.forward(req, res);
	}
}
