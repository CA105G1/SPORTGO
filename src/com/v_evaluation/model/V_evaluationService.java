package com.v_evaluation.model;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.venue.model.VenueVO;

public class V_evaluationService {

	private V_evaluationDAO_interface v_evaluationDAO ;
	
	public V_evaluationService() {
		this.v_evaluationDAO= new V_evaluationDAO();		
	}
	
	public void delete(String mem_no, String v_no) {
		this.v_evaluationDAO.delete(mem_no, v_no);
	}
	
	public List<V_evaluationVO> getOneVenueScoreList(String v_no){
		return this.v_evaluationDAO.getOneVenueScoreList(v_no);
	}
	
	// 回傳-1表示該查無資訊
	public double getOneVenueScore(String v_no) {
		List<V_evaluationVO> list = getOneVenueScoreList(v_no);
		if(list==null || list.size() == 0) {
			return -1;
		}
		int sum = 0;
		for(int i = 0 ; i<list.size();i++) {
			sum = sum+list.get(i).getScore();
		}
		
		double answer = ((double)(sum*10)) / (double)(list.size()*1);
		answer = Math.round(answer);
		answer = answer/10;
		return answer;
	}
	
	public Map<String, Double> getVenueScoreMapByVenueVO(List<VenueVO> venueList){
		Map<String, Double> scoreMap = new LinkedHashMap<>();
		for(int i = 0 ; i<venueList.size(); i++) {
			VenueVO venueVO = venueList.get(i);
			scoreMap.put(venueVO.getV_no(), getOneVenueScore(venueVO.getV_no()));
		}
		return scoreMap;
	}
	
	public void insertOrUpdate(String mem_no, String v_no, Integer score) {
		V_evaluationVO v_evaluationVO = this.v_evaluationDAO.findByPrimaryKey(mem_no, v_no);
		if(v_evaluationVO==null) {
			this.insert(mem_no, v_no, score);
		}else {
			this.update(mem_no, v_no, score);
		}
		
	}
	
	public void insert(String mem_no, String v_no, Integer score) {
		V_evaluationVO v_evaluationVO = new V_evaluationVO();
		v_evaluationVO.setMem_no(mem_no);
		v_evaluationVO.setV_no(v_no);
		v_evaluationVO.setScore(score);
		this.v_evaluationDAO.insert(v_evaluationVO);
	}
	
	public void update(String mem_no, String v_no, Integer score) {
		V_evaluationVO v_evaluationVO = new V_evaluationVO();
		v_evaluationVO.setMem_no(mem_no);
		v_evaluationVO.setV_no(v_no);
		v_evaluationVO.setScore(score);
		this.v_evaluationDAO.update(v_evaluationVO);
	}
	
	
	
	
}
