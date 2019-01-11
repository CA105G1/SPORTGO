package com.android.sg_mem.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.sg_mem.model.Sg_memService_android;
import com.android.sg_mem.model.Sg_memVO_android;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.android.sg_info.model.*;

@WebServlet("/Sg_memServlet_android.do")
public class Sg_memServlet_android extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
       
    public Sg_memServlet_android() {
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		Gson gson = new Gson();
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		System.out.println("input: " + jsonIn);
		Sg_memService_android service = new Sg_memService_android();
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		String action = jsonObject.get("action").getAsString();
		
		if("getMemberSG".equals(action)) {
			//取得會員的揪團名單
			String mem_no = jsonObject.get("mem_no").getAsString();
			writeText(res, gson.toJson(service.getMemberSG(mem_no)));
			
		} else if("getSGMember".equals(action)) {
			//取得揪團的會員名單
			String sg_no = jsonObject.get("sg_no").getAsString();
			writeText(res, gson.toJson(service.getSGMember(sg_no)));
			
		} else if("joinSG".equals(action)) {
			//加入揪團
			Sg_memVO_android vo = new Sg_memVO_android();
			String sg_no = jsonObject.get("sg_no").getAsString();
			vo.setSg_no(jsonObject.get("sg_no").getAsString());
			vo.setMem_no(jsonObject.get("mem_no").getAsString());
			try {
				service.insertSGMember(vo);
				writeText(res, "參加成功！");
				//報名人數+1
				new Sg_infoService_android().updateNumber(sg_no, 1);
				
			} catch (SQLException e) {
				if (e instanceof java.sql.SQLIntegrityConstraintViolationException) {
					writeText(res, "已在揪團名單！");
				}
				else {
					e.printStackTrace();
				}
			}
		} else if("leaveSG".equals(action)) {
			//加入揪團
			String sg_no = jsonObject.get("sg_no").getAsString();
			String mem_no = jsonObject.get("mem_no").getAsString();
			
			service.deleteSGMember(sg_no, mem_no);
			//報名人數-1
			new Sg_infoService_android().updateNumber(sg_no, -1);
			writeText(res, "您已離開揪團");
		} else if("CheckIn".equals(action)) {
			//加入揪團
			String sg_no = jsonObject.get("sg_no").getAsString();
			String mem_no = jsonObject.get("mem_no").getAsString();
			try {
				service.checkIn(sg_no, mem_no);
			} catch (SQLException e) {
				e.printStackTrace();
				writeText(res, "報到失敗");
			}
			writeText(res, "報到成功");
			
		}
	}
	
	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);

	}
}
