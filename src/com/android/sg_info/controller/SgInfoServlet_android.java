package com.android.sg_info.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.sg_info.model.Sg_info;
import com.android.sg_info.model.Sg_infoService_android;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.sg_info.controller.ImageUtil;

@WebServlet("/SgInfoServlet_android.do")
public class SgInfoServlet_android extends HttpServlet {
	
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
	private static final long serialVersionUID = 1L;
       
    public SgInfoServlet_android() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		Sg_infoService_android service = new Sg_infoService_android();
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
		
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
		
		if("getAll".equals(action)) {
			List<Sg_info> sgList = service.getAll();
			writeText(res, gson.toJson(sgList));
			
		} else if ("deleteSG".equals(action)) {
			String sg_no = jsonObject.get("sg_no").getAsString();
			service.cancelSG(sg_no);
			writeText(res, "ok");
			
		} else if ("findBySp".equals(action)) {
			String sp_no = jsonObject.get("sp_no").getAsString();
			List<Sg_info> sgList = service.getBySP(sp_no);
			writeText(res, gson.toJson(sgList));
			
		} else if ("findByMem".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Sg_info> sgList = service.getByMem(mem_no);
			writeText(res, gson.toJson(sgList));
			
		} else if ("findByMaster".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Sg_info> sgList = service.getByMaster(mem_no);
			writeText(res, gson.toJson(sgList));
			
		} else if ("findByLike".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Sg_info> sgList = service.getByLike(mem_no);
			writeText(res, gson.toJson(sgList));
			
		} else if ("findByHistory".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Sg_info> sgList = service.getByHistory(mem_no);
			writeText(res, gson.toJson(sgList));
			
		} else if ("findBySearch".equals(action)) {
			String mem_name = jsonObject.get("mem_name").getAsString();
			String venue = jsonObject.get("venue").getAsString();
			long start = jsonObject.get("start").getAsLong();
			long end = jsonObject.get("end").getAsLong();
			
			List<Sg_info> sgList = service.getBySearch(mem_name, venue, start, end);
			writeText(res, gson.toJson(sgList));
			
		} else if ("getPic".equals(action)) {
			OutputStream os = res.getOutputStream();
			String sg_no = jsonObject.get("pk").getAsString();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			byte[] image = service.getPic(sg_no);
			
			if (image != null) {
				// 縮圖 in server side
				image = ImageUtil.shrink(image, imageSize);
				res.setContentType("image/jpeg");
				res.setContentLength(image.length);
			}
			os.write(image);
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














