package com.evaofmem.model;

import java.util.List;

public class EvaofmemService {
	
	private EvaofmemDAO_interface dao;
	public EvaofmemService() {
		dao = new EvaofmemDAO();
	}
	
	public void addEvaluate(String sg_no, String evaluate_no,
		String evaluated_no,Double eva_score) {
		EvaofmemVO VO = new EvaofmemVO(sg_no,evaluate_no,evaluated_no,eva_score);
		dao.insert(VO);
	}
	
	public void updateEvaluate(String sg_no, String evaluate_no,
			String evaluated_no,Double eva_score) {
			EvaofmemVO VO = new EvaofmemVO(sg_no,evaluate_no,evaluated_no,eva_score);
			dao.update(VO);
	}

	public void deleteEvaluate(String sg_no, String evaluate_no,
			String evaluated_no,Double eva_score) {
			EvaofmemVO VO = new EvaofmemVO(sg_no,evaluate_no,evaluated_no,eva_score);
			dao.delete(VO);
	}
	
	public Double findMyScore(String mem_no) {
		return dao.findMyEva(mem_no);
	}
	
	public Double findSgScore(String sg_no) {
		return dao.findSgEva(sg_no);
	}
	
	public List<EvaofmemVO> findIEvaluated(String mem_no){
		return dao.findIEvad(mem_no);
	}
}
