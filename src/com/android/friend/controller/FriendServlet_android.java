package com.android.friend.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.android.friend.model.FriendService_android;
import com.android.friend.model.Friend;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

@WebServlet("/FriendServlet_android.do")
public class FriendServlet_android extends HttpServlet {
	
	private final static String CONTENT_TYPE = "text/html; charset=UTF-8";
	private static final long serialVersionUID = 1L;
	
    public FriendServlet_android() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		FriendService_android service = new FriendService_android();
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
		
		/****好友列表****/
		if("findMyFriend".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Friend> myfriend = service.findMyFriend(mem_no);
//			List<Friend> whoaddme = service.findWhoAdd(mem_no);
			writeText(res, gson.toJson(myfriend));
//			writeText(res, gson.toJson(whoaddme));
		}
		
		if("findMyPossibleFriend".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Friend> mypossiblefriend = service.findMyPossibleFriend(mem_no);
//			List<Friend> whoaddme = service.findWhoAdd(mem_no);
			writeText(res, gson.toJson(mypossiblefriend));
//			writeText(res, gson.toJson(whoaddme));
		}
		
		/****加入好友****/
		if("addFriend".equals(action)) {
			String mem1_no = jsonObject.get("mem_no").getAsString();
			String mem2_no = jsonObject.get("mem_no").getAsString();
			List<Friend> friendlist = service.findMyFriend(mem1_no);
			
			/****驗證是否已是好友*****/
			for(Friend list : friendlist) {
				if(list.getMem1_no().equals(mem1_no)) {
					if(list.getMem2_no().equals(mem2_no)) {
						// 重複
					}
				}
				else if (list.getMem1_no().equals(mem2_no)) {
					if(list.getMem2_no().equals(mem1_no)) {
						// 重複
					}
				}
				else if(list.getMem2_no().equals(mem1_no)) {
					if(list.getMem1_no().equals(mem2_no)) {
						// 重複
					}
				}
			}
			
			try {
				service.addFriend(mem1_no, mem2_no);
				req.setAttribute("status", "succeed");
			} catch (RuntimeException re) {
				//錯誤
			}
			//成功
		}
		
		/****刪除好友****/
		if("delete_Friend".equals(action)) {
			String mem1_no = jsonObject.get("mem_no").getAsString();
			String mem2_no = jsonObject.get("mem_no").getAsString();
			System.out.println(mem1_no+","+mem2_no);
			List<Friend> friendlist = service.getAll();
			
			Boolean isfriend=false;
			
			for(Friend list : friendlist) {
				if(list.getMem1_no().equals(mem1_no)) {
					if(list.getMem2_no().equals(mem2_no)) {
						isfriend=true;
						break;
					}
				} else if(list.getMem1_no().equals(mem2_no)) {
					if(list.getMem2_no().equals(mem1_no)) {
						isfriend=true;
						break;
					}
				}
			}
			
			if(isfriend) {
				
				try {
					service.deleteFriend(mem1_no, mem2_no);
					System.out.println("刪除好友成功");
				} catch (RuntimeException re) {
					re.printStackTrace(System.err);
					System.out.println("資料庫刪除不成功");
				}
			} else {
				System.out.println("無法刪除");
				return;
			}
		}
		
		/****更新好友狀態****/
		if("update_Friend".equals(action)) {

			String mem1_no = jsonObject.get("mem_no").getAsString();
			String mem2_no = jsonObject.get("mem_no").getAsString();
			System.out.println(mem1_no+","+mem2_no);
			List<Friend> friendlist = service.getAll();
			
			Boolean isfriend = false;
			
			for (Friend list : friendlist) {
				if(list.getMem1_no().equals(mem1_no)) {
					if(list.getMem2_no().equals(mem2_no)) {
						isfriend=true;
						break;
					}
				} else if(list.getMem1_no().equals(mem2_no)) {
					if(list.getMem2_no().equals(mem1_no)) {
						isfriend=true;
						break;
					}
				}
			}
			
			if(isfriend) {
				try{
					service.changeStatus(mem1_no, mem2_no, "好友");
					System.out.println("更新好友成功");
				}catch(RuntimeException re) {
					re.printStackTrace(System.err);
					System.out.println("資料庫刪除不成功");
				}
			}else {
				System.out.println("無法更新好友");
			}
			return;
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
