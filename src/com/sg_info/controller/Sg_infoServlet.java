//代辦事項
//日期格式轉換

package com.sg_info.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.json.JSONException;

import com.memberlist.model.MemberlistRedisDAO;
import com.sg_info.model.Sg_infoService;
import com.sg_info.model.Sg_infoVO;
@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class Sg_infoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Sg_infoServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		String action = req.getParameter("action");
		
		if("insert".equals(action)) {
			Map<String, String> errorMsg = new LinkedHashMap<String, String>();
			req.setAttribute("errorMsg", errorMsg);
			
			try {
				////////////////////////////錯誤處理////////////////////////////////////
				
				//照片檢查
				byte[] sg_pic = null;
				Part part = req.getPart("sg_pic");
				if (getFileNameFromPart(part) != null) {
					InputStream in = part.getInputStream();
					sg_pic = new byte[in.available()];
					in.read(sg_pic);
				}else {
					InputStream is = getServletContext().getResourceAsStream("/img/no-image.PNG");
					sg_pic = new byte[is.available()];
					is.read(sg_pic);
					is.close();
				}
				
				
				
				//團名檢查
				String sg_name = req.getParameter("sg_name").trim();
				if(sg_name == null || sg_name.trim().length() == 0) {
					errorMsg.put("sg_name","團名不得空白");
				}else if(sg_name.length() > 15) {
					errorMsg.put("sg_name","團名長度不得大於15個字");
				}
				
				//日期檢查
				Timestamp sg_date = null;
				Timestamp apl_end = null;
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
					Date date = sdf.parse(req.getParameter("sg_date").trim());
					sg_date= new Timestamp(date.getTime());
					
					SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
					
					Date date3 = sdf2.parse(req.getParameter("apl_end").trim());
					apl_end= new Timestamp(date3.getTime());
					
				}catch(Exception e) {
					sg_date = new Timestamp(System.currentTimeMillis());
					apl_end = new Timestamp(System.currentTimeMillis());
					errorMsg.put("date","請輸入日期!");
				}
				
				//費用格式檢查
				Integer sg_fee = null;
				String sg_feeStr = req.getParameter("sg_fee");
				if(sg_feeStr == null || sg_feeStr.trim().length() == 0) {
					sg_feeStr = "0";
				}
				try {
					sg_fee = new Integer(sg_feeStr.trim());
				} catch (NumberFormatException e) {
					sg_fee = 0;
					errorMsg.put("sg_fee","報名費請填數字");
				}
				
				//人數上限檢查
				Integer sg_maxno = null;
				try {
					sg_maxno = new Integer(req.getParameter("sg_maxno").trim());
					if(sg_maxno >= 100) {
						errorMsg.put("sg_maxno","人數上限請小於100");
					}
				} catch (NumberFormatException nfe) {
					sg_maxno = 0;
					errorMsg.put("sg_maxno","人數上限請填數字");
				}
					
				//人數下限檢查
				Integer sg_minno = null;
				try {
					sg_minno = new Integer(req.getParameter("sg_minno").trim());
					if(sg_minno >= sg_maxno) {
						errorMsg.put("sg_minno","人數下限請小於人數上限");
					}
				} catch (NumberFormatException e) {
					sg_minno = 0;
					errorMsg.put("sg_minno","人數下限請填數字");
				}
				
				
				
				//運動種類與場館檢查
				String sp_no = req.getParameter("sp_no").trim();
				String loc_start = req.getParameter("loc_start");
				String loc_end = req.getParameter("loc_end");
				String v_no = req.getParameter("v_no").trim();
				//若運動種類不是慢跑也不是自行車，則將路線規劃座標取消，並檢查有無選擇場館
				if("SP006".equals(sp_no) || "SP007".equals(sp_no)) {
					if(loc_start.length() == 0 || loc_end.length() == 0) {
						errorMsg.put("loc","請規劃路線");
					}
					//若是選擇慢跑或自行車則將場館資料清除
					v_no = null;
				}else {
					loc_start =null;
					loc_end = null;
					if(v_no == null || v_no.trim().length() == 0) {
						errorMsg.put("v_no","請選擇場館");
					}
				}
				
				
				
				String mem_no = req.getParameter("mem_no").trim();
				String sg_per = req.getParameter("sg_per").trim();
				String sg_extrainfo = req.getParameter("sg_extrainfo").trim();
				String club_no = req.getParameter("club_no").trim();
				
				
				//準備VO，若有錯誤就原封不動把VO再跟著錯誤送回去
//				Sg_infoVO sg_infoVO = new Sg_infoVO();
//				sg_infoVO.setMem_no(mem_no);
//				sg_infoVO.setSg_name(sg_name);
//				sg_infoVO.setSg_date(sg_date);
//				sg_infoVO.setClub_no(club_no);
//				sg_infoVO.setApl_end(apl_end);
//				sg_infoVO.setSg_pic(sg_pic);
//				sg_infoVO.setSg_fee(sg_fee);
//				sg_infoVO.setSg_per(sg_per);
//				sg_infoVO.setSp_no(sp_no);
//				sg_infoVO.setV_no(v_no);
//				sg_infoVO.setSg_maxno(sg_maxno);
//				sg_infoVO.setSg_minno(sg_minno);
//				sg_infoVO.setSg_extrainfo(sg_extrainfo);
				
				//若有錯誤訊息，將VO跟錯誤訊息回傳
				if(!errorMsg.isEmpty()) {
//					req.setAttribute("Sg_infoVO", sg_infoVO);
					if("限社團".equals(sg_per)) {
						RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/club/Sg_infoCreateForClub.jsp");
						dispatcher.forward(req, res);
					}else {
						RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Sg_info/Sg_infoCreate.jsp");
						failureView.forward(req, res);
					}
					return;
				}
				
				///////////////////開始INSERT資料//////////////////////////
				Sg_infoService svc = new Sg_infoService();
				svc.insertSg_info(mem_no, sg_name, sg_date, club_no, apl_end, sg_fee, sg_pic, 
						null, sg_per, sp_no, v_no, sg_maxno, sg_minno, 0, 0, 
						sg_extrainfo, loc_start, loc_end);
						
//				req.setAttribute("Sg_infoVO", sg_infoVO);
				if("限社團".equals(sg_per)) {
					RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/club/Sg_infoList.jsp");
					dispatcher.forward(req, res);
				}else {
					RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/Sg_info/SgHome.jsp");
					dispatcher.forward(req, res);
				}
				
				
				/////////其他錯誤處理/////////
			}catch(Exception e){
				errorMsg.put("general","修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front-end/Sg_info/Sg_infoCreate.jsp");
				failureView.forward(req, res);
			}
			
			
			
		}
		
		
		
		
		
		if("update".equals(action)) {
			List<String> errorMsg = new LinkedList<String>();
			req.setAttribute("errorMsg", errorMsg);
			
			try {
				////////////////////////////錯誤處理////////////////////////////////////
				String sg_no = req.getParameter("sg_no").trim();
				Sg_infoService svc = new Sg_infoService();
				
				//照片檢查
				byte[] sg_pic = null;
				Part part = req.getPart("sg_pic");
				if (getFileNameFromPart(part) != null) {
					InputStream in = part.getInputStream();
					sg_pic = new byte[in.available()];
					in.read(sg_pic);
				}else {
					Sg_infoVO vo1 = svc.GetByPK(sg_no);
					sg_pic = vo1.getSg_pic();
				}
				
				
				//團名檢查
				String sg_name = req.getParameter("sg_info0").trim();
				if(sg_name == null || sg_name.trim().length() == 0) {
					errorMsg.add("團名不得空白");
				}else if(sg_name.length() > 15) {
					errorMsg.add("團名長度不得大於15個字");
				}
				
				//日期檢查
				Timestamp sg_date = null;
				Timestamp apl_end = null;
				try {
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
					Date date = sdf.parse(req.getParameter("sg_date").trim());
					sg_date= new Timestamp(date.getTime());
					
					SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
					
					Date date3 = sdf2.parse(req.getParameter("apl_end").trim());
					apl_end= new Timestamp(date3.getTime());
					
				}catch(IllegalArgumentException e) {
					sg_date = new Timestamp(System.currentTimeMillis());
					apl_end = new Timestamp(System.currentTimeMillis());
					errorMsg.add("請輸入日期!");
				}
				
				//費用格式檢查
				Integer sg_fee = null;
				try {
					sg_fee = new Integer(req.getParameter("sg_info1").trim());
				} catch (NumberFormatException e) {
					sg_fee = 0;
					errorMsg.add("報名費請填數字");
				}
				
				//運動種類與場館檢查
				String sp_no = req.getParameter("sp_no").trim();
				String loc_start = req.getParameter("loc_start");
				String loc_end = req.getParameter("loc_end");
				String v_no = req.getParameter("v_no").trim();
				//若運動種類不是慢跑也不是自行車，則將路線規劃座標取消，並檢查有無選擇場館
				if("SP006".equals(sp_no) || "SP007".equals(sp_no)) {
					//若是選擇慢跑或自行車則將場館資料清除
					v_no = null;
				}else {
					loc_start =null;
					loc_end = null;
					if(v_no == null || v_no.trim().length() == 0) {
						errorMsg.add("請選擇場館");
					}
				}
				
				//人數上限檢查
				Integer sg_maxno = null;
				try {
					sg_maxno = new Integer(req.getParameter("sg_info2").trim());
				} catch (NumberFormatException nfe) {
					sg_maxno = 0;
					errorMsg.add("人數上限請填數字");
				}
					
				//人數下限檢查
				Integer sg_minno = null;
				try {
					sg_minno = new Integer(req.getParameter("sg_info3").trim());
					if(sg_minno >= sg_maxno) {
						errorMsg.add("人數下限請小於人數上限");
					}
				} catch (NumberFormatException e) {
					sg_minno = 0;
					errorMsg.add("人數下限請填數字");
				}
				
				
				
				
				String mem_no = req.getParameter("mem_no").trim();
				String sg_pic_ext = req.getParameter("sg_pic_ext").trim();
				String sg_per = req.getParameter("sg_per").trim();
				String sg_extrainfo = req.getParameter("sg_info4").trim();
				String club_no = req.getParameter("club_no").trim();
				Integer sg_ttlapl = new Integer(req.getParameter("sg_ttlapl"));
				
				
				
				//準備VO，若有錯誤就原封不動把VO再跟著錯誤送回去
				Sg_infoVO sg_infoVO = new Sg_infoVO();
				sg_infoVO.setSg_no(sg_no);
				sg_infoVO.setMem_no(mem_no);
				sg_infoVO.setSg_name(sg_name);
				sg_infoVO.setSg_date(sg_date);
				sg_infoVO.setClub_no(club_no);
				sg_infoVO.setApl_end(apl_end);
				sg_infoVO.setSg_fee(sg_fee);
				sg_infoVO.setSg_pic(sg_pic);
				sg_infoVO.setSg_pic_ext(sg_pic_ext);
				sg_infoVO.setSg_per(sg_per);
				sg_infoVO.setSp_no(sp_no);
				sg_infoVO.setV_no(v_no);
				sg_infoVO.setSg_maxno(sg_maxno);
				sg_infoVO.setSg_minno(sg_minno);
				sg_infoVO.setSg_ttlapl(sg_ttlapl);
				sg_infoVO.setSg_extrainfo(sg_extrainfo);
				sg_infoVO.setLoc_start(loc_start);
				sg_infoVO.setLoc_end(loc_end);
				
				//若有錯誤訊息，將VO跟錯誤訊息回傳
				if(!errorMsg.isEmpty()) {
					req.setAttribute("Sg_infoVO", sg_infoVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front-end/Sg_info/Sg_infoGetByPkForHead.jsp");
					failureView.forward(req, res);
					return;
				}
				
				///////////////////開始UPDATE資料//////////////////////////
				sg_infoVO = svc.updateSg_info(sg_no, mem_no, sg_name, sg_date, club_no, apl_end, sg_fee, sg_pic, sg_pic_ext, sg_per, sp_no, v_no, sg_maxno, sg_minno, sg_ttlapl, sg_extrainfo, loc_start, loc_end);
				System.out.println("total = " + sg_infoVO.getSg_ttlapl());
				req.setAttribute("Sg_infoVO", sg_infoVO);
				RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/Sg_info/Sg_infoGetByPkForHead.jsp");
				dispatcher.forward(req, res);
				
				/////////其他錯誤處理/////////
			}catch(Exception e){
				e.printStackTrace();
//				e.getStackTrace();
//				errorMsg.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/front-end/Sg_info/Sg_infoGetByPkForHead.jsp");
//				failureView.forward(req, res);
			}
		}
		
		
		
		
		
		
		if("delete".equals(action)) {
			try {
				String sg_no = req.getParameter("sg_no");
				Sg_infoService svc = new Sg_infoService();
				svc.deleteSg_info(sg_no);
				RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/Sg_info/SgHome.jsp");
				dispatcher.forward(req, res);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		
		
		if("getByPK".equals(action)) {
			try {
				String sg_no = req.getParameter("sg_no");
				Sg_infoService svc = new Sg_infoService();
				Sg_infoVO vo = svc.GetByPK(sg_no);
				
				req.setAttribute("Sg_infoVO", vo);
				RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/Sg_info/Sg_infoGetByPkForGeneral.jsp");
				dispatcher.forward(req, res);
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		
		
		
		if("sg_infoCompositeQuery".equals(action)) {
			List<String> errorMsg = new LinkedList<String>();
			req.setAttribute("errorMsg", errorMsg);
			
			try {
				///////////將查詢資料轉為MAP///////////////////
//				Map<String, String[]> map = req.getParameterMap();
				HttpSession session = req.getSession();
				Map<String, String[]> map = (Map<String, String[]>)session.getAttribute("map");
				if (req.getParameter("whichPage") == null){
				HashMap<String, String[]> map1 = new HashMap<String, String[]>(req.getParameterMap());
				session.setAttribute("map",map1);
					map = map1;
				} 
				
				///////////開始查詢/////////////////////
				//若抓不到map就代表不是複合查詢
				if(map != null) {
					Sg_infoService svc = new Sg_infoService();
					List<Sg_infoVO> list = svc.getAllByQuery(map);
					///////////轉交資料/////////////////////
					req.setAttribute("list", list);
				}
				RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/Sg_info/SgHome.jsp");
				dispatcher.forward(req, res);
				
			}catch(Exception e) {
				errorMsg.add(e.getMessage());
				RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/Sg_info/SgHome.jsp");
				dispatcher.forward(req, res);
			}
		}
		
		
		
		if("dismiss".equals(action)) {
			List<String> errorMsg = new LinkedList<String>();
			req.setAttribute("errorMsg", errorMsg);
			
			try {
				String sg_no = req.getParameter("sg_no");
				String sg_status = req.getParameter("sg_status");
				
				Sg_infoService svc = new Sg_infoService();
				svc.updateStatus(sg_no, sg_status);
				
				res.sendRedirect(req.getContextPath()+"/front-end/memberlist/MemManager.do?action=Member_Sg");
//				RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/memberlist/MemManager.do?action=Member_Sg");
//				dispatcher.forward(req, res);
				
			}catch(Exception e) {
				errorMsg.add(e.getMessage());
				RequestDispatcher dispatcher = req.getRequestDispatcher("/front-end/memberlist/MemManager.do?action=Member_Sg");
				dispatcher.forward(req, res);
			}
		}
		
		
		if("shareSg_info".equals(action)) {
			
			String mem_no = req.getParameter("mem_no");
			String sg_no = req.getParameter("sg_no");
			String[] mem2_noArr = req.getParameterValues("mem2_no");
			
			for(String mem2_no : mem2_noArr) {
				MemberlistRedisDAO dao = new MemberlistRedisDAO();
				DateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				String time = df.format(Calendar.getInstance().getTimeInMillis());
			
						String title = "<div>安安你好~ 一起加入揪團17 play吧! <div>"
								+ "<a href='"+req.getContextPath()+"/Sg_info/Sg_info.do?sg_no="+sg_no+"&action=getByPK'>快速傳送門</a>";
						
						String value = "{"
								+ "\"userName\":"+"\""+mem_no+"\""
								+ ",\"type\":"+"\"chat\""
								+ ",\"message\":"+"\""+title+"\""
								+ ",\"to\":"+"\""+mem2_no+"\""
								+ ",\"time\":"+"\""+ time +"\""
								+ "}";
			
						try {
							dao.saveChatMessage(mem_no, mem2_no, value);
						} catch (Exception e) {
							System.out.println("分享出錯了");
							e.printStackTrace();
						}
			}
			res.sendRedirect(req.getContextPath()+"/front-end/memberlist/Friend.do?action=find_My_Friend");
						
		}
		
		
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	
	//得到上傳檔案的名稱
	public String getFileNameFromPart(Part part) {
		String header = part.getHeader("content-disposition");
//		System.out.println("header=" + header); // 測試用
		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
//		System.out.println("filename=" + filename); // 測試用
		if (filename.length() == 0) {
			return null;
		}
		return filename;
	}
}
