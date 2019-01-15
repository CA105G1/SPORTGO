package com.v_evaluation.model;

import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.*;

public class V_evaluationDAO implements V_evaluationDAO_interface{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup(com.util.lang.Util.JNDI_DATABASE_NAME);//---java:comp/env/jdbc/CA105G1DB
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = "INSERT INTO v_evaluation (mem_no,v_no,score) VALUES (?, ?, ?)";
	private static final String GET_ALL_STMT = "SELECT * FROM v_evaluation";
	private static final String GET_ONE = "SELECT * FROM v_evaluation WHERE mem_no = ? AND v_no = ?";
	private static final String UPDATE = "UPDATE v_evaluation set score=? WHERE mem_no = ? AND　v_no = ?";
	private static final String DELETE = "DELETE FROM v_evaluation WHERE mem_no= ? AND v_no= ?";
	private static final String GET_ONE_VENUE_SCORE_LIST_SQL= "Select * from v_evaluation where v_no = ? ";
	
	

	@Override
	public void insert(V_evaluationVO veVO) {
		
		Connection con = null;
		PreparedStatement psmt = null;

		try {

			con = ds.getConnection();
			psmt = con.prepareStatement(INSERT_STMT);
			
			psmt.setString(1, veVO.getMem_no());
			psmt.setString(2, veVO.getV_no());
			psmt.setInt(3, veVO.getScore());
			
			psmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (psmt != null) {
				try {
					psmt.close();
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
	public void update(V_evaluationVO veVO) {
		
		Connection con = null;
		PreparedStatement psmt = null;

		try {

			con = ds.getConnection();
			psmt = con.prepareStatement(UPDATE);
			
			psmt.setInt(1, veVO.getScore());
			psmt.setString(2, veVO.getMem_no());
			psmt.setString(3, veVO.getV_no());
			
			psmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (psmt != null) {
				try {
					psmt.close();
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
	public void delete(String mem_no ,String v_no) {
		
		Connection con = null;
		PreparedStatement psmt = null;

		try {

			con = ds.getConnection();
			psmt = con.prepareStatement(DELETE);
			
			psmt.setString(1, mem_no);
			psmt.setString(2, v_no);
			
			psmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (psmt != null) {
				try {
					psmt.close();
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
	public V_evaluationVO findByPrimaryKey(String mem_no, String v_no) {
		
		V_evaluationVO veVO = null;
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			psmt = con.prepareStatement(GET_ONE);
			
			psmt.setString(1, mem_no);
			psmt.setString(2, v_no);
			
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				veVO = new V_evaluationVO();
				veVO.setMem_no(rs.getString("mem_no"));
				veVO.setV_no(rs.getString("v_no"));
				veVO.setScore(rs.getInt("score"));
			}
			
		} catch (SQLException se) {
			veVO = null;
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (psmt != null) {
				try {
					psmt.close();
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
		
		return veVO;
	}

	@Override
	public List<V_evaluationVO> getAll() {
		
		List<V_evaluationVO> list = new ArrayList<V_evaluationVO>();
		
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			psmt = con.prepareStatement(GET_ALL_STMT);
			rs = psmt.executeQuery();
			list = collectV_evaluationVO(rs);
//			while (rs.next()) {
//				veVO = new V_evaluationVO();
//				veVO.setMem_no(rs.getString("mem_no"));
//				veVO.setV_no(rs.getString("v_no"));
//				veVO.setScore(rs.getInt("score"));
//				list.add(veVO);
//			}
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			
			if (psmt != null) {
				try {
					psmt.close();
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
	
	@Override
	public List<V_evaluationVO> getOneVenueScoreList(String v_no) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		List<V_evaluationVO> list = new ArrayList<>();
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(GET_ONE_VENUE_SCORE_LIST_SQL);
			preparedStatement.setString(1, v_no);
			resultSet = preparedStatement.executeQuery();
			list = collectV_evaluationVO(resultSet);
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			
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
		return list;
	}
	
	private List<V_evaluationVO> collectV_evaluationVO(ResultSet rs) throws SQLException{
		List<V_evaluationVO> list = new ArrayList<>();
		while (rs.next()) {
			V_evaluationVO veVO = new V_evaluationVO();
			veVO.setMem_no(rs.getString("mem_no"));
			veVO.setV_no(rs.getString("v_no"));
			veVO.setScore(rs.getInt("score"));
			list.add(veVO);
		}
		return list;
	}
	
	
	
}


