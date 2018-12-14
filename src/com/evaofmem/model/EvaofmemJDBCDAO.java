package com.evaofmem.model;

import java.util.*;
import java.sql.*;

public class EvaofmemJDBCDAO implements EvaofmemDAO_interface {
	
	public EvaofmemJDBCDAO() {
	}

	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@10.37.129.3:1521:xe";
	private String user = "AARON";
	private String password = "123456";
	
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_EVA);
			
			pstmt.setString(1, evaofmem.getSg_no());
			pstmt.setString(2, evaofmem.getEvaluate_no());
			pstmt.setString(3, evaofmem.getEvaluated_no());
			pstmt.setInt(4, evaofmem.getEva_score());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				} 
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
	}

	@Override
	public void update(EvaofmemVO evaofmem) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_EVA);
			pstmt.setInt(1, evaofmem.getEva_score());
			pstmt.setString(2, evaofmem.getSg_no());
			pstmt.setString(3, evaofmem.getEvaluate_no());
			pstmt.setString(4, evaofmem.getEvaluated_no());
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the databse driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		}finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				} 
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
	};
	
	@Override
	public void delete(EvaofmemVO evaofmem) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE_EVA);
			
			pstmt.setString(1, evaofmem.getSg_no());
			pstmt.setString(2, evaofmem.getEvaluate_no());
			pstmt.setString(3, evaofmem.getEvaluated_no());
			
			pstmt.executeUpdate();
		
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured "
														+se.getMessage());
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				} 
			} catch (SQLException se) {
				se.printStackTrace();
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_MY_EVA);
			pstmt.setString(1, evaluated_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				eva = rs.getDouble(1);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		}finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				} 
			} catch (SQLException se) {
				se.printStackTrace();
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_I_EVALUATED);
			pstmt.setString(1, evaluate_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				evaofmem = new EvaofmemVO();
				evaofmem.setSg_no(rs.getString("sg_no"));
				evaofmem.setEvaluate_no(rs.getString("evaluate_no"));
				evaofmem.setEvaluated_no(rs.getString("evaluated_no"));
				evaofmem.setEva_score(rs.getInt("eva_score"));
				list.add(evaofmem);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				} 
			} catch (SQLException se) {
				se.printStackTrace();
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_SG_EVA);
			pstmt.setString(1, sg_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				eva = rs.getDouble(1);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
														+se.getMessage());
		}finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				} 
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return eva;
	}

	

	
	public static void main(String[] args) {
		EvaofmemJDBCDAO evadao = new EvaofmemJDBCDAO();
		EvaofmemVO eva1 =new EvaofmemVO("S003","M002","M003",8);
		EvaofmemVO eva2 =new EvaofmemVO("S003","M002","M004",7);
		EvaofmemVO eva3 =new EvaofmemVO("S003","M002","M005",8);
		EvaofmemVO eva4 =new EvaofmemVO("S004","M002","M004",9);
		EvaofmemVO eva5 =new EvaofmemVO("S003","M005","M004",10);
		EvaofmemVO eva6 =new EvaofmemVO("S003","M002","M004",10);
		EvaofmemVO eva7 =new EvaofmemVO("S004","M002","M004");
		evadao.insert(eva1);
		evadao.insert(eva2);
		evadao.insert(eva3);
		evadao.insert(eva4);
		evadao.insert(eva5);
		System.out.println("Score of M004 is before update : "+evadao.findMyEva("M004"));
		evadao.update(eva6);
		System.out.println("Score of M004 is after update : "+evadao.findMyEva("M004"));
		evadao.delete(eva7);
		System.out.println("evaluation is deleted.");
		List<EvaofmemVO> list = evadao.findIEvad("M002");
		for(EvaofmemVO vo: list) { 
			System.out.println(vo.getSg_no()+":"+",name :"+vo.getEvaluated_no()+", score :"+vo.getEva_score());
		}
		System.out.println("Score of S003 is : "+evadao.findSgEva("S003"));
		
	}

	
	
	
}
