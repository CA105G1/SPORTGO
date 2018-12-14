package com.evaofmem.model;

import java.util.*;

public interface EvaofmemDAO_interface {

	public void insert(EvaofmemVO evaofmem);
	public void update(EvaofmemVO evaofmem);
	public void delete(EvaofmemVO evaofmem);
	public Double findMyEva(String evaluated_no);
	public List<EvaofmemVO> findIEvad(String evaluate_no);
	public Double findSgEva(String sg_no);
}
