package com.emp.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmpJDBCDAO implements EmpDAO_interface{

	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	
	private static final String INSERT_SQL = 
			"INSERT INTO emp"
			+ "(emp_no, emp_name, emp_auth, "
			+ "emp_phone, emp_email, emp_account, emp_psw, "
			+ "hiredate, leavedate)"
			+ " VALUES ('E'||LPAD(emp_seq.NEXTVAL,3,'0'),?,?,"
			+ "?,?,?,?,"
			+ "?,?)";

	private static final String UPDATE_SQL = 
			"UPDATE emp SET emp_name=?,emp_auth=?,"
			+ "emp_phone=?, emp_email=?, emp_account=?, emp_psw=?,"
			+ "hiredate=?, leavedate=? WHERE emp_no=?";
	
	private static final String DELETE_BY_PK_SQL = 
			"DELETE FROM emp WHERE emp_no=?";

	private static final String GET_ALL_SQL = 
			"SELECT * FROM emp ORDER BY emp_no ASC";
	
	private static final String FIND_BY_PK_SQL = 
			"SELECT * FROM emp WHERE emp_no=?";
	
	private static final String GET_EMP_BY_NAME_SQL =
			"SELECT * FROM emp WHERE emp_name LIKE UPPER('%'||?||'%')";

	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void insert(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			
			String[] cols = {"emp_no"};
			
			pstmt = con.prepareStatement(INSERT_SQL,cols);
			if(empVO.getEmp_name()!=null)
				empVO.setEmp_name(empVO.getEmp_name().toUpperCase());
			pstmt.setString(1, empVO.getEmp_name());
			pstmt.setString(2, empVO.getEmp_auth());
			pstmt.setString(3, empVO.getEmp_phone());
			pstmt.setString(4, empVO.getEmp_email());
			pstmt.setString(5, empVO.getEmp_account());
			pstmt.setString(6, empVO.getEmp_psw());
			pstmt.setDate(7, empVO.getHiredate());
			pstmt.setDate(8, empVO.getLeavedate());
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功輸入---");
			}else {
				System.out.println("---輸入失敗---");
			}
			
			rs = pstmt.getGeneratedKeys();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			if(rs.next()) {
				do {
					for(int i = 1 ; i <= columnCount ; i++) {
						empVO.setEmp_no(rs.getString(1));
						System.out.println("自增主鍵值 = " + empVO.getEmp_no() +"(剛新增成功的newstype_no)");
					}
				}while (rs.next());
			} else {
				System.out.println("NO KEYS WERE GENERATED.");
			}
			
		} catch (SQLException e0) {
			e0.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);

			pstmt = con.prepareStatement(UPDATE_SQL);
			
			pstmt.setString(1, empVO.getEmp_name());
			pstmt.setString(2, empVO.getEmp_auth());
			pstmt.setString(3, empVO.getEmp_phone());
			pstmt.setString(4, empVO.getEmp_email());
			pstmt.setString(5, empVO.getEmp_account());
			pstmt.setString(6, empVO.getEmp_psw());
			pstmt.setDate(7, empVO.getHiredate());
			pstmt.setDate(8, empVO.getLeavedate());
			pstmt.setString(9, empVO.getEmp_no());
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功更新---");
			}else {
				System.out.println("---更新失敗---");
			}
			
		} catch (SQLException e0) {
			e0.printStackTrace();
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void delete(String emp_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE_BY_PK_SQL);
			pstmt.setString(1, emp_no);
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功刪除---編號 : "+emp_no);
			}else {
				System.out.println("---刪除失敗---編號 : "+emp_no);
			}
			
		}catch (SQLException e0) {
			e0.printStackTrace();
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public EmpVO findByPrimaryKey(String emp_no) {
		EmpVO empVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_PK_SQL);
			pstmt.setString(1, emp_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				empVO = new EmpVO();
				empVO.setEmp_no(emp_no);
				empVO.setEmp_name(rs.getString("EMP_NAME"));
				empVO.setEmp_auth(rs.getString("EMP_AUTH"));
				empVO.setEmp_phone(rs.getString("EMP_PHONE"));
				empVO.setEmp_email(rs.getString("EMP_EMAIL"));
				empVO.setEmp_account(rs.getString("EMP_ACCOUNT"));
				empVO.setEmp_psw(rs.getString("EMP_PSW"));
				empVO.setHiredate(rs.getDate("HIREDATE"));
				empVO.setLeavedate(rs.getDate("LEAVEDATE"));
			}
		}catch (SQLException e0) {
			e0.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return empVO;
	}

	@Override
	public List<EmpVO> getAll() {
		List<EmpVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL_SQL);
			rs = pstmt.executeQuery();
			list = collectEmpVO(rs);
			
		} catch (SQLException e0) {
			e0.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

	@Override
	public List<EmpVO> getEmpByEmpName(String emp_name) {
		List<EmpVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_EMP_BY_NAME_SQL);
			pstmt.setString(1, emp_name);
			rs = pstmt.executeQuery();
			list = collectEmpVO(rs);
		} catch (SQLException e0) {
			e0.printStackTrace();
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	private List<EmpVO> collectEmpVO(ResultSet rs) throws SQLException{
		List<EmpVO> list = new ArrayList<>();
		while(rs.next()) {
			EmpVO empVO = new EmpVO();
			empVO.setEmp_no(rs.getString("EMP_NO"));
			empVO.setEmp_name(rs.getString("EMP_NAME"));
			empVO.setEmp_auth(rs.getString("EMP_AUTH"));
			empVO.setEmp_phone(rs.getString("EMP_PHONE"));
			empVO.setEmp_email(rs.getString("EMP_EMAIL"));
			empVO.setEmp_account(rs.getString("EMP_ACCOUNT"));
			empVO.setEmp_psw(rs.getString("EMP_PSW"));
			empVO.setHiredate(rs.getDate("HIREDATE"));
			empVO.setLeavedate(rs.getDate("LEAVEDATE"));
			list.add(empVO);
		}
		return list;
	}
	
	public static void main(String[] args) {
		EmpJDBCDAO dao = new EmpJDBCDAO();
		EmpVO empVO = new EmpVO();
		empVO.setEmp_name("David");
		empVO.setEmp_auth("一般管理員");
		empVO.setEmp_phone("0987654321");
		empVO.setEmp_email("david@iii.com.tw");
		empVO.setEmp_account("david");
		empVO.setEmp_psw("123456");
		empVO.setHiredate(java.sql.Date.valueOf("2018-12-01"));
		empVO.setLeavedate(null);
		
		dao.insert(empVO);
		System.out.println("Before update"+empVO);
		empVO.setEmp_psw("111");
		dao.update(empVO);
		System.out.println(" After update"+empVO);
		
		//dao.delete("E002");
	
		System.out.println(dao.findByPrimaryKey("E001"));
		
		List<EmpVO> list2 = dao.getEmpByEmpName("a");
		System.out.println("GetEmpByEmpName : "+list2.size());
		for(EmpVO x : list2 ) {
			System.out.println(x);
		}

		List<EmpVO> list = dao.getAll();
		System.out.println("GetAll : "+list.size());
		for(EmpVO x : list ) {
			System.out.println(x);
		}
		
	}

}
