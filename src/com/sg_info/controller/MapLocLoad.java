package com.sg_info.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sg_info.model.Sg_infoService;
import com.sg_info.model.Sg_infoVO;
import com.venue.model.VenueService;
import com.venue.model.VenueVO;

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
		getServletContext().removeAttribute("mapLoc");
	}

	@Override
	public void init() throws ServletException {
		timer = new Timer();
		Map<String, String> mapLoc = new HashMap<String, String>();
		getServletContext().setAttribute("mapLoc", mapLoc);
		Sg_infoService sg_infosvc = new Sg_infoService();
		VenueService venuesvc = new VenueService();
		
		TimerTask task = new TimerTask() {
			public void run() {
				List<Sg_infoVO> list = sg_infosvc.getAll();
				for(Sg_infoVO vo : list) {
					if(vo.getV_no() != null) {
						VenueVO venuevo =venuesvc.getOneVenue(vo.getV_no());
						Double v_lat = venuevo.getV_lat();
						Double v_long = venuevo.getV_long();
						mapLoc.put(vo.getSg_no(), "{\"lat\":"+v_lat+",\"lng\":"+v_long+"}");
//System.out.println("{\"lat\":"+v_lat+",\"lng\":"+v_long+"}");
					}
				}
				
			}
		};
		
		timer.scheduleAtFixedRate(task, new Date(), 3*60*1000);
	}
	
	

}
