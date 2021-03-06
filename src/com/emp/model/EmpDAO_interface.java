package com.emp.model;

import java.util.List;

public interface EmpDAO_interface {
	
	public EmpVO insert(EmpVO empVO);
    public void update(EmpVO empVO);
    public void delete(String emp_no);
    public EmpVO findByPrimaryKey(String emp_no);
    public List<EmpVO> getAll();
    public List<EmpVO> getEmpByEmpName(String emp_name);
	public EmpVO checkEmpAccountByAccount(String emp_account, String input_psw);
}
