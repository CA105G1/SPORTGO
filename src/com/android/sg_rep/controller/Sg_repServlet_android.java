package com.android.sg_rep.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.sg_rep.model.*;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet("/Sg_repServlet_android.do")
public class Sg_repServlet_android extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		//將從手機傳來的Json轉成Gson
		Gson gson = new Gson();
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		
		System.out.println("input: " + jsonIn);
		Sg_repService_android service = new Sg_repService_android();
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		String action = jsonObject.get("action").getAsString();

		//加入檢舉
		if ("reportSG".equals(action)) {
			String sg_no = jsonObject.get("sg_no").getAsString();
			String mem_no = jsonObject.get("mem_no").getAsString();
			String rep_type = jsonObject.get("rep_type").getAsString();
			String rep_cont = jsonObject.get("rep_cont").getAsString();
			Sg_repVO_android vo = new Sg_repVO_android(sg_no, mem_no, rep_type, rep_cont);
			try {
				service.insert(vo);
			} catch (SQLException e) {
				writeText(res, "failed");
				e.printStackTrace();
			}
			writeText(res, "OK");
		} else if ("getMemRep".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Sg_rep> list = service.findByMem(mem_no);
			writeText(res, gson.toJson(list));
		}
	}
	
	//傳回請求端、並在console輸出結果
	private void writeText(HttpServletResponse res, String outText) throws IOException {
		res.setContentType(CONTENT_TYPE);
		PrintWriter out = res.getWriter();
		out.print(outText);
		out.close();
		System.out.println("outText: " + outText);

	}

}
