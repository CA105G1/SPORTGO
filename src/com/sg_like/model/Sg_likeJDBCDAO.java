package com.sg_like.model;

import java.util.*;
import java.sql.*;

public class Sg_likeJDBCDAO implements Sg_likeDAO_interface{
	
	private String driver  = "oracle.jdbc.driver.OracleDriver";
	private String url     = "jdbc:oracle:thin@10.37.129.3:1521:xe";
	private String user    = "AARON";
	private String password= "123456";  
	
	private static final String PUSH_LIKE = "INSERT INTO SG_LIKE VALUES (?,?)";
	private static final String PUSH_DISLIKE = "DELETE FROM SG_LIKE WHERE MEM_NO = ?";
	private static final String SG_WHO_LIKE = "SELECT MEM_NO FROM SG_LIKE WHERE SG_NO = ?";
	private static final String LIKE_WHICH_SG = "SELECT SG_NO FROM SG_LIKE WHERE MEM_NO = ?";
	
	//constructor
	public Sg_likeJDBCDAO() {
	}
	
	
	//push like button use insert
	//when member push like SG button, insert a new data into SG_LIKE 
	@Override
	public void insert(Sg_likeVO sg_like) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(PUSH_LIKE);
			
			pstmt.setString(1, sg_like.getSg_no());
			pstmt.setString(2, sg_like.getMem_no());
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver."+e.getMessage());
		}catch (SQLException se) {
			throw new RuntimeException("A database error occured. "+se.getMessage());
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
	}
	
	//push dislike button(maybe same as like button) use delete
	//when member push the dislike button, delete the original data from SG_LIKE
	//warning : if member push dislike SG button before push like button, it may have SQLException
	@Override
	public void delete(Sg_likeVO sg_like) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(PUSH_DISLIKE);
			
			pstmt.setString(1, sg_like.getMem_no());
			
			pstmt.executeUpdate();
		} catch(ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database Driver. "
														+ e.getMessage());
		}catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
														+se.getMessage());
		}finally{
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
	}
	
	//get all people who like this SG
	@Override
	public List<Sg_likeVO> Sg_getAll(String sg_no) {
		List<Sg_likeVO> likelist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(SG_WHO_LIKE);
			pstmt.setString(1, sg_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Sg_likeVO sg_like = new Sg_likeVO();
				sg_like.setMem_no(rs.getString(sg_like.getMem_no()));
				likelist.add(sg_like);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
													+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
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
		return likelist;
	}
	//get member likes SG list
	@Override
	public List<Sg_likeVO> Mem_getAll(String mem_no) {
		List<Sg_likeVO> likelist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(LIKE_WHICH_SG);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Sg_likeVO memlike = new Sg_likeVO();
				memlike.setSg_no(rs.getString(memlike.getSg_no()));
				likelist.add(memlike);
			}
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "+se.getMessage());
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
				if(con!=null) {
					con.close();
				}
			}catch(SQLException se) {
				se.printStackTrace(System.err);
			}
		}
		return likelist;
	}

}
