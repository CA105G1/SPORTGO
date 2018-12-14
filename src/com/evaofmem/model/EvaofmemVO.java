package com.evaofmem.model;

public class EvaofmemVO implements java.io.Serializable {

	private static final long serialVersionUID = 98L;

	public EvaofmemVO() {
	}
	private String sg_no;
	private String evaluate_no;//mem_no
	private String evaluated_no;//mem_no
	private Integer eva_score;
	//for insert, update
	public EvaofmemVO(String sg_no,String evaluate_no,
			String evaluated_no,Integer eva_score){
		setSg_no(sg_no);
		setEvaluate_no(evaluate_no);
		setEvaluated_no(evaluated_no);
		setEva_score(eva_score);
	}
	//for delete
	public EvaofmemVO(String sg_no,String evaluate_no,
			String evaluated_no){
		setSg_no(sg_no);
		setEvaluate_no(evaluate_no);
		setEvaluated_no(evaluated_no);
	}
	
	public String getSg_no() {
		return sg_no;
	}
	public void setSg_no(String sg_no) {
		this.sg_no = sg_no;
	}
	public String getEvaluate_no() {
		return evaluate_no;
	}
	public void setEvaluate_no(String evaluate_no) {
		this.evaluate_no = evaluate_no;
	}
	public String getEvaluated_no() {
		return evaluated_no;
	}
	public void setEvaluated_no(String evaluated_no) {
		this.evaluated_no = evaluated_no;
	}
	public Integer getEva_score() {
		return eva_score;
	}
	public void setEva_score(Integer eva_score) {
		this.eva_score = eva_score;
	}
	
}
