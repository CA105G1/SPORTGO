package com.region.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.region.model.RegVO;
import com.util.lang.Util;

import java.sql.*;


public class RegJDBCDAO implements RegDAO_interface{
	
	private static final String DRIVER = com.util.lang.Util.DRIVER;
	private static final String URL = com.util.lang.Util.URL;
	private static final String USER = com.util.lang.Util.USER;
	private static final String PASSWORD = com.util.lang.Util.PASSWORD;
	
	static { //預先載入驅動程式
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException ce) {
			throw new RuntimeException("ClassNotFoundException ce :　"+ce.getMessage());
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO region (reg_no,reg_name,reg_dist) VALUES (?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT * FROM region order by reg_no ASC";
		private static final String GET_ONE_STMT = 
			"SELECT * FROM region where reg_no = ?";
		private static final String DELETE = 
			"DELETE FROM region where reg_no = ?";
		private static final String UPDATE = 
			"UPDATE region set reg_name = ? And reg_dist = ? where reg_no = ?";
		
	@Override
	public void insert(RegVO regVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, regVO.getReg_no());
			pstmt.setString(2, regVO.getReg_name());
			pstmt.setString(3, regVO.getReg_dist());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}

	@Override
	public void update(RegVO regVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, regVO.getReg_name());
			pstmt.setString(2, regVO.getReg_dist());
			pstmt.setInt(3, regVO.getReg_no());
			

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(Integer reg_no) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, reg_no);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public RegVO findByPrimaryKey(Integer reg_no) {
		
		RegVO regVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, reg_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// regVo 也稱為 Domain objects
				regVO = new RegVO();
				regVO.setReg_no(rs.getInt("reg_no"));
				regVO.setReg_name(rs.getString("reg_name"));
				regVO.setReg_dist(rs.getString("reg_dist"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return regVO;
		
	}

	@Override
	public List<RegVO> getAll() {
		
		List<RegVO> list = new ArrayList<RegVO>();
		RegVO RegVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			list = collectRegVO(rs);

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	private static final String GET_REGVO_FROM_ADDRESS_SQL = ""
			+ "Select * from region where ? like '%'||reg_name||reg_dist||'%'";
	
	@Override
	public RegVO getRegVOFromAddress(String address) {
		RegVO regVO = null;
		Connection connection = null;
		PreparedStatement preparedStatement  = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_REGVO_FROM_ADDRESS_SQL);
			preparedStatement.setString(1, address);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				regVO = new RegVO();
				regVO.setReg_no(resultSet.getInt("REG_NO"));
				regVO.setReg_name(resultSet.getString("REG_NAME"));
				regVO.setReg_dist(resultSet.getString("REG_DIST"));
			}
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		}finally {
			if (resultSet != null) {
				try {
					resultSet.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (connection != null) {
				try {
					connection.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return regVO;
	}
	
	private List<RegVO> collectRegVO(ResultSet resultSet) throws SQLException{
		List<RegVO> list = new ArrayList<>();
		while(resultSet.next()) {
			RegVO regVO = new RegVO();
			regVO.setReg_no(resultSet.getInt("REG_NO"));
			regVO.setReg_name(resultSet.getString("REG_NAME"));
			regVO.setReg_dist(resultSet.getString("REG_DIST"));
			list.add(regVO);
		}
		return list;
	}
	
	@Override
	public List<RegVO> getAll(Map<String, String[]> map) {
		List<RegVO> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			String finalSQL = "Select * from region "
					+ Util_JDBC_CompositeQuery_Region.get_WhereCondition(map)
					+ " order by reg_no";
			preparedStatement = connection.prepareStatement(finalSQL);
			resultSet = preparedStatement.executeQuery();
			list = collectRegVO(resultSet);
			
		}catch (SQLException e) {
			list = new ArrayList<>();
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}

	public static void main(String[] args) {
		
//		RegJDBCDAO regJDBCDAO = new RegJDBCDAO();
//		RegVO regVO = new RegVO();
//		regVO.setReg_no(999);
//		regVO.setReg_name("Test_name");
//		regVO.setReg_dist("test_dist");
//		regJDBCDAO.insert(regVO);
		
		RegJDBCDAO regJDBCDAO = new RegJDBCDAO();
		List<RegVO> list = regJDBCDAO.getAll();
		for(RegVO regVO : list) {
			System.out.println(regVO.getReg_no());
		}
		
		
	}

}
