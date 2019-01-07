package com.sg_mem.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.sg_info.model.Sg_infoService;
import com.sg_mem.model.Sg_memService;
import com.sg_mem.model.Sg_memVO;

public class Sg_memServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sg_memServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		PrintWriter pw = res.getWriter();
		
		if("insert".equals(action)) {
			Map<String, String> errorMsg = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsg", errorMsg);
			
			String sg_no = req.getParameter("sg_no");
			String mem_no = req.getParameter("mem_no");
			boolean answer;
			boolean isJoin = false;

			Sg_memService svc = new Sg_memService();
			List<Sg_memVO> list = svc.getAllBySg_no(sg_no);
			//判斷是否重複加入
			for(Sg_memVO vo : list) {
				if(vo.getMem_no().equals(mem_no)) {
					isJoin = true;
				}
			}
			if(isJoin) {
				//重複報名則回傳false到前端
				answer=false;
			}else {
				svc.insertSg_mem(sg_no, mem_no);
				//變更sg_info資料表的報名人數
				Sg_infoService sg_infosvc = new Sg_infoService();
				Integer sg_ttlapl = sg_infosvc.GetByPK(sg_no).getSg_ttlapl();
				sg_ttlapl += 1;
				sg_infosvc.updateTtlapl(sg_no, sg_ttlapl);
				//////////////////////
				answer=true;
			}
			
			JSONObject obj = new JSONObject();
			try {
				obj.put("answer", answer);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pw.write(obj.toString());
		}
		
		
		
		if("delete".equals(action)) {
			Map<String, String> errorMsg = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsg", errorMsg);
			
			String sg_no = req.getParameter("sg_no");
			String mem_no = req.getParameter("mem_no");
			
			Sg_memService svc = new Sg_memService();
			svc.deleteSg_mem(sg_no, mem_no);
			
			//變更sg_info資料表的報名人數
			Sg_infoService sg_infosvc = new Sg_infoService();
			Integer sg_ttlapl = sg_infosvc.GetByPK(sg_no).getSg_ttlapl();
			sg_ttlapl -= 1;
			sg_infosvc.updateTtlapl(sg_no, sg_ttlapl);
			//////////////////////
			
			JSONObject obj = new JSONObject();
			try {
				obj.put("answer", "OK!");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pw.write(obj.toString());
		}
		
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
