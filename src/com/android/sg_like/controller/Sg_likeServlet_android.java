package com.android.sg_like.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.sg_like.model.Sg_likeService_android;
import com.android.sg_like.model.Sg_likeVO_android;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet("/Sg_likeServlet_android.do")
public class Sg_likeServlet_android extends HttpServlet {
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		Sg_likeService_android service = new Sg_likeService_android();
		Gson gson = new Gson();
		
		BufferedReader br = req.getReader();
		StringBuilder jsonIn = new StringBuilder();
		String line = null;
		while ((line = br.readLine()) != null) {
			jsonIn.append(line);
		}
		
		//Console印出輸入的資料
		System.out.println("input: " + jsonIn);
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		String action = jsonObject.get("action").getAsString();
		
		if ("findBySg".equals(action)) {
			String sg_no = jsonObject.get("sg_no").getAsString();
			List<Sg_likeVO_android> sgList = service.findBySg(sg_no);
			writeText(res, gson.toJson(sgList));
			
		} else if("getMemLike".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Sg_likeVO_android> sgList = service.findByMem(mem_no);
			writeText(res, gson.toJson(sgList));
			
		} else if ("dislike".equals(action)) {
			String sg_no = jsonObject.get("sg_no").getAsString();
			String mem_no = jsonObject.get("mem_no").getAsString();
			Sg_likeVO_android vo = new Sg_likeVO_android(sg_no, mem_no);
			service.dislike(vo);
			writeText(res, "ok");
			
		} else if ("like".equals(action)) {
			String sg_no = jsonObject.get("sg_no").getAsString();
			String mem_no = jsonObject.get("mem_no").getAsString();
			Sg_likeVO_android vo = new Sg_likeVO_android(sg_no, mem_no);
			service.like(vo);
			writeText(res, "ok");
			
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
