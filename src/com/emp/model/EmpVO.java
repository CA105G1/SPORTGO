package com.emp.model;

import java.sql.Date;

public class EmpVO {
	
	private String emp_no;
	private String emp_name;
	private String emp_auth;
	private String emp_phone;
	private String emp_email;
	private String emp_account;
	private String emp_psw;
	private Date hiredate;
	private Date leavedate;
	
	public EmpVO() {	
	}

	public String getEmp_no() {
		return emp_no;
	}

	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}

	public String getEmp_name() {
		return emp_name;
	}

	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}

	public String getEmp_auth() {
		return emp_auth;
	}

	public void setEmp_auth(String emp_auth) {
		this.emp_auth = emp_auth;
	}

	public String getEmp_phone() {
		return emp_phone;
	}

	public void setEmp_phone(String emp_phone) {
		this.emp_phone = emp_phone;
	}

	public String getEmp_email() {
		return emp_email;
	}

	public void setEmp_email(String emp_email) {
		this.emp_email = emp_email;
	}

	public String getEmp_account() {
		return emp_account;
	}

	public void setEmp_account(String emp_account) {
		this.emp_account = emp_account;
	}

	public String getEmp_psw() {
		return emp_psw;
	}

	public void setEmp_psw(String emp_psw) {
		this.emp_psw = emp_psw;
	}

	public Date getHiredate() {
		return hiredate;
	}

	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}

	public Date getLeavedate() {
		return leavedate;
	}

	public void setLeavedate(Date leavedate) {
		this.leavedate = leavedate;
	}
	
	
}
