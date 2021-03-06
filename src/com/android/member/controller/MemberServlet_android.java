package com.android.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.member.model.Member;
import com.android.member.model.MemberService_android;
import com.android.member.model.MemberVO_android;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.sg_info.controller.ImageUtil;

@WebServlet("/MemberServlet_android.do")
public class MemberServlet_android extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";

    public MemberServlet_android() {
        super();
    }

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
		MemberService_android service = new MemberService_android();
		JsonObject jsonObject = gson.fromJson(jsonIn.toString(), JsonObject.class);
		String action = jsonObject.get("action").getAsString();

		//驗證登入並取得登入會員資料
		if ("isMember".equals(action)) {
			String mem_account = jsonObject.get("mem_account").getAsString();
			String mem_pswd = jsonObject.get("mem_pswd").getAsString();
			try {
				Member member = service.isMember(mem_account, mem_pswd);
				writeText(res, member == null ? "" : gson.toJson(member));
			} catch (Exception e) {
				writeText(res, "查無會員");
			}
		} else if ("getMember".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			Member member = service.getMember(mem_no);
			writeText(res, member == null ? "" : gson.toJson(member));
		} else if ("getPic".equals(action)) {
			OutputStream os = res.getOutputStream();
			String mem_no = jsonObject.get("pk").getAsString();
			int imageSize = jsonObject.get("imageSize").getAsInt();
			byte[] image = service.getProfilePic(mem_no);
			
			if(image != null) {
				image = ImageUtil.shrink(image, imageSize);
				res.setContentType("image/jpeg");
				res.setContentLength(image.length);
			}
			os.write(image);
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
