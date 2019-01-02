package com.android.sg_like.model;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.*;

public class Sg_likeDAO_android implements Sg_likeDAO_interface_android{
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}	
	
	private static final String PUSH_LIKE = "INSERT INTO SG_LIKE VALUES (?,?)";
	private static final String PUSH_DISLIKE = "DELETE FROM SG_LIKE WHERE MEM_NO = ? AND SG_NO = ?";
	private static final String SG_WHO_LIKE = "SELECT MEM_NO FROM SG_LIKE WHERE SG_NO = ?";
	private static final String LIKE_WHICH_SG = "SELECT SG_NO FROM SG_LIKE WHERE MEM_NO = ?";
	
	//constructor
	public Sg_likeDAO_android() {
	}
	
	
	//push like button use insert
	//when member push like SG button, insert a new data into SG_LIKE 
	@Override
	public void insert(Sg_likeVO_android sg_like) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(PUSH_LIKE);
			
			pstmt.setString(1, sg_like.getSg_no());
			pstmt.setString(2, sg_like.getMem_no());
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "+se.getMessage());
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
	
	//push dislike button(maybe same as like button) use delete
	//when member push the dislike button, delete the original data from SG_LIKE
	//warning : if member push dislike SG button before push like button, it may have SQLException
	@Override
	public void delete(Sg_likeVO_android sg_like) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(PUSH_DISLIKE);
			
			pstmt.setString(1, sg_like.getMem_no());
			pstmt.setString(2, sg_like.getSg_no());
			
			pstmt.executeUpdate();

		} catch(SQLException se) {
			throw new RuntimeException("A database error occured. "
														+se.getMessage());
		} finally{
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
	public List<Sg_likeVO_android> Sg_getAll(String sg_no) {
		List<Sg_likeVO_android> likelist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SG_WHO_LIKE);
			pstmt.setString(1, sg_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Sg_likeVO_android sg_like = new Sg_likeVO_android();
				sg_like.setMem_no(rs.getString("mem_no"));
				likelist.add(sg_like);
			}
		
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
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
		return likelist;
	}
	
	//get member likes SG list
	@Override
	public List<Sg_likeVO_android> Mem_getAll(String mem_no) {
		List<Sg_likeVO_android> likelist = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(LIKE_WHICH_SG);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Sg_likeVO_android memlike = new Sg_likeVO_android();
				memlike.setSg_no(rs.getString("sg_no"));
				likelist.add(memlike);
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "+se.getMessage());
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
		return likelist;
	}
}
