package com.sg_info.controller;

import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sg_info.model.Sg_infoService;
import com.sg_info.model.Sg_infoVO;

public class MapLocLoad extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Timer timer;
       
    public MapLocLoad() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void destroy() {
		timer.cancel();
	}

	@Override
	public void init() throws ServletException {
		timer = new Timer();
		Sg_infoService sg_infosvc = new Sg_infoService();
		//報名時間到時判斷人數是否達標，並改變狀態
		TimerTask task = new TimerTask() {
			public void run() {
				List<Sg_infoVO> list = sg_infosvc.getAll();
				for(Sg_infoVO vo : list) {
					if(vo.getApl_end().getTime() < new Date().getTime()) {
						if(vo.getSg_ttlapl() < vo.getSg_minno()) {
							sg_infosvc.updateStatus(vo.getSg_no(), "流團");
						}else if(vo.getSg_ttlapl() > vo.getSg_minno()){
							sg_infosvc.updateStatus(vo.getSg_no(), "成團");
						}
					}
				}
				
			}
		};
		Calendar cal = new GregorianCalendar(2019, Calendar.JANUARY, 5, 0, 0, 0);
		timer.scheduleAtFixedRate(task, cal.getTime(), 24*60*60*1000);
	}
	
	
	
	

}
