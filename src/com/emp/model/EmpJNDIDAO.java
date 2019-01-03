package com.emp.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;
import javax.sql.DataSource;

public class EmpJNDIDAO implements EmpDAO_interface{

	private static DataSource dataSource;
	
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
			javax.naming.Context context = new javax.naming.InitialContext();
			dataSource = (DataSource)context.lookup(com.util.lang.Util.JNDI_DATABASE_NAME);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public EmpVO insert(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			
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
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
		return empVO;
	}

	@Override
	public void update(EmpVO empVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();

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
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(DELETE_BY_PK_SQL);
			pstmt.setString(1, emp_no);
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功刪除---編號 : "+emp_no);
			}else {
				System.out.println("---刪除失敗---編號 : "+emp_no);
			}
			
		}catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
			con = dataSource.getConnection();
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
		}catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(GET_ALL_SQL);
			rs = pstmt.executeQuery();
			list = collectEmpVO(rs);
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(GET_EMP_BY_NAME_SQL);
			pstmt.setString(1, emp_name);
			rs = pstmt.executeQuery();
			list = collectEmpVO(rs);
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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

	private static final String FIND_EMP_BY_ACCOUNT_SQL = ""
			+ "SELECT * FROM emp WHERE emp_account=?";
	
	@Override
	public EmpVO checkEmpAccountByAccount(String emp_account, String input_psw) {
		EmpVO empVO = null;
		Connection connection= null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(FIND_EMP_BY_ACCOUNT_SQL);
			preparedStatement.setString(1, emp_account);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				if(resultSet.getString("EMP_PSW").equals(Util_Password.encodePassword(input_psw))) {
					empVO = new EmpVO();
					empVO.setEmp_no(resultSet.getString("EMP_NO"));
					empVO.setEmp_name(resultSet.getString("EMP_NAME"));
					empVO.setEmp_auth(resultSet.getString("EMP_AUTH"));
					empVO.setEmp_phone(resultSet.getString("EMP_PHONE"));
					empVO.setEmp_email(resultSet.getString("EMP_EMAIL"));
					empVO.setEmp_account(resultSet.getString("EMP_ACCOUNT"));
					empVO.setEmp_psw(resultSet.getString("EMP_PSW"));
					empVO.setHiredate(resultSet.getDate("HIREDATE"));
					empVO.setLeavedate(resultSet.getDate("LEAVEDATE"));
				}else {
					empVO = new EmpVO();
					empVO.setEmp_account(resultSet.getString("EMP_ACCOUNT"));
					empVO.setEmp_auth("");
				}
			}
		} catch (SQLException e) {
			empVO = null;
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return empVO;
	}
	
}
