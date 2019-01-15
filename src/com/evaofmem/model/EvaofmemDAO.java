package com.evaofmem.model;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.*;

public class EvaofmemDAO implements EvaofmemDAO_interface {
	
	public EvaofmemDAO() {
	}

	private static DataSource ds = null;
	static {
		Context ctx;
		try {
			ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1DB");
		} catch (NamingException e) {
			e.printStackTrace(System.err);
		}
	}
	private static final String INSERT_EVA = 
			"INSERT INTO EVAOFMEM VALUES (?,?,?,?)";
	private static final String UPDATE_EVA =
			"UPDATE EVAOFMEM SET EVA_SCORE = ? WHERE SG_NO = ?"
			+ " AND EVALUATE_NO = ? AND EVALUATED_NO = ?";
	private static final String DELETE_EVA = 
			"DELETE FROM EVAOFMEM WHERE SG_NO = ? AND "
			+ "EVALUATE_NO = ? AND EVALUATED_NO = ?";
	private static final String FIND_MY_EVA = 
			"SELECT AVG(EVA_SCORE) FROM EVAOFMEM WHERE EVALUATED_NO = ?";
	private static final String FIND_I_EVALUATED =
			"SELECT * FROM EVAOFMEM WHERE EVALUATE_NO=?";
	private static final String FIND_SG_EVA =
			"SELECT AVG(EVA_SCORE) FROM EVAOFMEM WHERE SG_NO = ?";
	
	@Override
	public void insert(EvaofmemVO evaofmem) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_EVA);
			
			pstmt.setString(1, evaofmem.getSg_no());
			pstmt.setString(2, evaofmem.getEvaluate_no());
			pstmt.setString(3, evaofmem.getEvaluated_no());
			pstmt.setDouble(4, evaofmem.getEva_score());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(EvaofmemVO evaofmem) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_EVA);
			pstmt.setDouble(1, evaofmem.getEva_score());
			pstmt.setString(2, evaofmem.getSg_no());
			pstmt.setString(3, evaofmem.getEvaluate_no());
			pstmt.setString(4, evaofmem.getEvaluated_no());
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		}finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	};
	
	@Override
	public void delete(EvaofmemVO evaofmem) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_EVA);
			
			pstmt.setString(1, evaofmem.getSg_no());
			pstmt.setString(2, evaofmem.getEvaluate_no());
			pstmt.setString(3, evaofmem.getEvaluated_no());
			
			pstmt.executeUpdate();
		
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured "
														+se.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	//for member, find only one member evaluation
	@Override
	public Double findMyEva(String evaluated_no) {
		Double eva = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_MY_EVA);
			pstmt.setString(1, evaluated_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				eva = rs.getDouble(1);
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return eva;
	}
	// for member, find who is evaluated by him.
	@Override
	public List<EvaofmemVO> findIEvad(String evaluate_no) {
		List<EvaofmemVO> list = new ArrayList<>();
		EvaofmemVO evaofmem = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_I_EVALUATED);
			pstmt.setString(1, evaluate_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				evaofmem = new EvaofmemVO();
				evaofmem.setSg_no(rs.getString("sg_no"));
				evaofmem.setEvaluate_no(rs.getString("evaluate_no"));
				evaofmem.setEvaluated_no(rs.getString("evaluated_no"));
				evaofmem.setEva_score(rs.getDouble("eva_score"));
				list.add(evaofmem);
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
	//for SG, average all score in this SG, seem like the happiness index
	@Override
	public Double findSgEva(String sg_no) {
		Double eva = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_SG_EVA);
			pstmt.setString(1, sg_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				eva = rs.getDouble(1);
			}
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return eva;
	}
}
