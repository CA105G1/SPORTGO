package com.post_like.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class Post_likeJDBCDAO implements Post_likeDAO_interface{
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "CA105G1";
	String passwd = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO club (post_no,mem_no,like_type) VALUES (?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT post_no,mem_no,like_type FROM post_like order by post_no";
		private static final String GET_ONE_STMT = 
			"SELECT post_no,mem_no,like_type FROM club where post_no = ? AND mem_no = ?";
		private static final String DELETE = 
			"DELETE FROM club where post_no = ? AND mem_no = ?";
		private static final String UPDATE = 
			"UPDATE club set post_no=?, mem_no=?, like_type=? where post_no = ? AND mem_no = ?";
		
		
		
		@Override
		public void insert(Post_likeVO post_likeVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, post_likeVO.getPost_no());
				pstmt.setString (2, post_likeVO.getMem_no());
				pstmt.setString(3, post_likeVO.getLike_type());

				
				pstmt.executeUpdate();
				
				
			} catch (ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load database driver. "
						+ e.getMessage());
			}catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
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
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}			
		}
		@Override
		public void update(Post_likeVO post_like) {
			// TODO Auto-generated method stub
			
		}
		@Override
		public void delete(String post_like) {
			// TODO Auto-generated method stub
			
		}
		@Override
		public Post_likeVO findByPrimaryKey(String post_like) {
			// TODO Auto-generated method stub
			return null;
		}
		@Override
		public List<Post_likeVO> getAll() {
			// TODO Auto-generated method stub
			return null;
		}
	
}
