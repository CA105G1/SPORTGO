package com.sport.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sport.model.SportDAO;
import com.sport.model.SportVO;

@WebServlet("/TestServlet")
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public TestServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("Big5");
        res.setContentType("text/html; charset=Big5");
        PrintWriter out = res.getWriter();

		String sp_no = req.getParameter("sp_no");
		
		SportDAO dao = new SportDAO();
		SportVO vo = new SportVO();
		
		vo = dao.findByPk(sp_no);
		out.println("<HTML>");
        out.println("<HEAD><TITLE>Hello, " + sp_no + "</TITLE></HEAD>");
        out.println("<BODY>");
        out.println("Hello, 你好: " + vo.getSp_name());
        out.println("</BODY></HTML>");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
