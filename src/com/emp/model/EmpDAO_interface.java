package com.emp.model;

import java.util.List;

public interface EmpDAO_interface {
	
	public void insert(EmpVO empVO);
    public void update(EmpVO empVO);
    public void delete(Integer emp_no);
    public EmpVO findByPrimaryKey(Integer emp_no);
    public List<EmpVO> getAll();
    public List<EmpVO> getEmpByDeptno(Integer emp_no);
	
}
