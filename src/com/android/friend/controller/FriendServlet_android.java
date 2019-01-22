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
import com.memberlist.model.MemberlistRedisDAO;

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
		
		if("findMyFriend".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Friend> myfriend = service.findMyFriend(mem_no);
			writeText(res, gson.toJson(myfriend));
		}
		
		if("findMyPossibleFriend".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
			List<Friend> mypossiblefriend = service.findMyPossibleFriend(mem_no);
//			List<Friend> whoaddme = service.findWhoAdd(mem_no);
			writeText(res, gson.toJson(mypossiblefriend));
//			writeText(res, gson.toJson(whoaddme));
		}
		
		if("findWhoAdd".equals(action)) {
			String mem_no = jsonObject.get("mem_no").getAsString();
//			List<Friend> mypossiblefriend = service.findMyPossibleFriend(mem_no);
			List<Friend> whoaddme = service.findWhoAdd(mem_no);
//			writeText(res, gson.toJson(mypossiblefriend));
			writeText(res, gson.toJson(whoaddme));
		}
		
		if("addFriend".equals(action)) {
			String mem1_no = jsonObject.get("mem1_no").getAsString();
			String mem2_no = jsonObject.get("mem2_no").getAsString();
			List<Friend> friendlist = service.findMyFriend(mem1_no);
			
			for(Friend list : friendlist) {
				if(list.getMem1_no().equals(mem1_no)) {
					if(list.getMem2_no().equals(mem2_no)) {
						writeText(res, "duplicate");
					}
				}
				else if (list.getMem1_no().equals(mem2_no)) {
					if(list.getMem2_no().equals(mem1_no)) {
						writeText(res, "duplicate");
					}
				}
				else if(list.getMem2_no().equals(mem1_no)) {
					if(list.getMem1_no().equals(mem2_no)) {
						writeText(res, "duplicate");
					}
				}
			}
			
			try {
				service.addFriend(mem1_no, mem2_no);
				writeText(res, "success");
			} catch (RuntimeException re) {
				writeText(res, "fail");
			}
			//成功
		}
		
		if("deleteFriend".equals(action)) {
			String mem1_no = jsonObject.get("mem1_no").getAsString();
			String mem2_no = jsonObject.get("mem2_no").getAsString();
			List<Friend> friendlist = service.getAll();
			
			Boolean isfriend = false;
			
			for(Friend list : friendlist) {
				if (list.getMem1_no().equals(mem1_no)) {
					if (list.getMem2_no().equals(mem2_no)) {
						isfriend = true;
						break;
					}
				} else if (list.getMem1_no().equals(mem2_no)) {
					if (list.getMem2_no().equals(mem1_no)) {
						isfriend = true;
						break;
					}
				}
			}
			
			if (isfriend) {
				
				try {
					service.deleteFriend(mem1_no, mem2_no);
					writeText(res, "success");
				} catch (RuntimeException re) {
					re.printStackTrace(System.err);
					writeText(res, "fail");
				}
			} else {
				writeText(res, "notFriend");
				return;
			}
		}
		
		if("updateFriend".equals(action)) {

			String mem1_no = jsonObject.get("mem1_no").getAsString();
			String mem2_no = jsonObject.get("mem2_no").getAsString();
			List<Friend> friendlist = service.getAll();
			
			Boolean isfriend = false;
			
			for (Friend list : friendlist) {
				if (list.getMem1_no().equals(mem1_no)) {
					if (list.getMem2_no().equals(mem2_no)) {
						isfriend = true;
						break;
					}
				} else if (list.getMem1_no().equals(mem2_no)) {
					if (list.getMem2_no().equals(mem1_no)) {
						isfriend = true;
						break;
					}
				}
			}
			
			if (isfriend) {
				try {
					service.changeStatus(mem1_no, mem2_no, "好友");
					writeText(res, "success");
				} catch(RuntimeException re) {
					re.printStackTrace(System.err);
					writeText(res, "fail");
				}
			} else {
				writeText(res, "notFriend");
			}
			return;
		}
		
		if("checkFriend".equals(action)) {
			String mem1_no = jsonObject.get("mem1_no").getAsString();
			String mem2_no = jsonObject.get("mem2_no").getAsString();
			List<Friend> friendlist = service.getAll();
			
			Boolean isfriend = false;
			for (Friend list : friendlist) {
				if (list.getMem1_no().equals(mem1_no)) {
					if (list.getMem2_no().equals(mem2_no)) {
						isfriend = true;
						break;
					}
				} else if (list.getMem1_no().equals(mem2_no)) {
					if (list.getMem2_no().equals(mem1_no)) {
						isfriend = true;
						break;
					}
				}
			}
			
			if (isfriend) {
					writeText(res, "true");
			} else {
				writeText(res, "false");
			}
		}
		
		if("getHistoryChat".equals(action)) {
			String sender = jsonObject.get("mem_no").getAsString();
			List<String> historyData = new MemberlistRedisDAO().getHistoryMsg(sender);
			writeText(res, historyData.toString());
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
