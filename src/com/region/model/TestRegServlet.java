package com.region.model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.venue.model.VenueDAO_interface;

/**
 * Servlet implementation class VenueT
 */
@WebServlet("/RegS")
public class TestRegServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    response.setContentType("text/plain; charset=UTF-8");
		
		RegDAO_interface ri  = new RegDAO();
	       BufferedReader br = new BufferedReader(new FileReader("src\\DB\\postcode.json"));
			
			StringBuilder sb = new StringBuilder();
			
			String str;
			
			try {
				while ((str = br.readLine()) != null) {
					sb.append(str);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}

			try {
				JSONArray jArray = new JSONArray(sb.toString());
				
				for (int i = 0; i < jArray.length(); i++) {
					
					JSONObject reg = jArray.getJSONObject(i);
					
					JSONArray  dist = reg.getJSONArray("districts");
					
					for (int j = 0; j < dist.length(); j++) {
						
						RegVO ro = new RegVO();
						
						ro.setReg_name(reg.getString("name"));
						ro.setReg_no(dist.getJSONObject(j).getInt("zip"));
						ro.setReg_dist(dist.getJSONObject(j).getString("name"));
						
						ri.insert(ro);
						
					}	
				}
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
