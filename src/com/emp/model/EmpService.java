package com.emp.model;

import java.sql.Date;
import java.util.List;

public class EmpService {
	
	private EmpDAO_interface empDAO = null;
	
	public EmpService() {
		this.empDAO = new EmpDAO();
	}

	public EmpVO addEmp(EmpVO empVO) {
		return empDAO.insert(empVO);
	}
	public EmpVO addEmp(String emp_name, String emp_auth,
		String emp_phone, String emp_email, String emp_account, String emp_psw,
		Date hiredate) {
		EmpVO empVO = new EmpVO();
		empVO.setEmp_name(emp_name);
		empVO.setEmp_auth(emp_auth);
		empVO.setEmp_phone(emp_phone);
		empVO.setEmp_email(emp_email);
		empVO.setEmp_account(emp_account);
		empVO.setEmp_psw(emp_psw);
		empVO.setHiredate(hiredate);
		return empDAO.insert(empVO);
	}
	
	public void updateEmp(EmpVO empVO) {
		empDAO.update(empVO);
	}
	public void updateEmp(String emp_no, String emp_name, String emp_auth,
			String emp_phone, String emp_email, String emp_account, String emp_psw,
			Date hiredate, Date leavedate) {
		EmpVO empVO = new EmpVO();
		empVO.setEmp_no(emp_no);
		empVO.setEmp_name(emp_name);
		empVO.setEmp_auth(emp_auth);
		empVO.setEmp_phone(emp_phone);
		empVO.setEmp_email(emp_email);
		empVO.setEmp_account(emp_account);
		empVO.setEmp_psw(emp_psw);
		empVO.setHiredate(hiredate);
		empVO.setLeavedate(leavedate);
		empDAO.update(empVO);		
	}
	
    public EmpVO getOneEmpByEmpNo(String emp_no) {
    	return empDAO.findByPrimaryKey(emp_no);
    }
    public List<EmpVO> getAll(){
    	return empDAO.getAll();
    }
    public List<EmpVO> getEmpByEmpName(String emp_name){
    	return empDAO.getEmpByEmpName(emp_name);
    }
	public EmpVO checkEmpAccountByAccount(String emp_account, String input_psw) {
		return empDAO.checkEmpAccountByAccount(emp_account, input_psw);
	}
	
}
