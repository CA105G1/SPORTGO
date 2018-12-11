package com.product_like.model;

import java.util.*;
import java.sql.*;

public class Product_likeJDBCDAO implements Product_likeDAO_interface{

	public Product_likeJDBCDAO() {}
	
	private static final String PUSH_LIKE = "INSERT INTO PRODUCT_LIKE VALUES(?,?)";
	private static final String PUSH_DISLIKE = "DELETE FROM PRODUCT_LIKE WHERE MEM_NO = ?";
	private static final String PRODUCT_WHO_LIKE = "SELECT MEM_NO FROM PRODUCT_LIKE WHERE PRODUCT_NO = ?";
	private static final String MEM_LIKE_WHICH_PRODUCT = "SELECT PRODUCT FROM PRODUCT WHERE MEM_NO = ?";
	
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin@10.37.129.3:1521:xe";
	private String user = "AARON";
	private String password = "123456";
	
	//member push like button then insert a new data into Product_like table
	@Override
	public void insert(Product_likeVO product_like) {
		 Connection con = null;
		 PreparedStatement pstmt = null;
		 
		 try {
			 Class.forName(driver);
			 con = DriverManager.getConnection(url, user, password);
			 pstmt = con.prepareStatement(PUSH_LIKE);
			 
			 pstmt.setString(1, product_like.getProduct_no());
			 pstmt.setString(2, product_like.getMem_no());
			 
			 pstmt.executeUpdate();
			 
		 }catch(ClassNotFoundException e) {
			 throw new RuntimeException("Couldn't load database driver. "
					 									+e.getMessage());
		 }catch(SQLException se) {
			 throw new RuntimeException("Database errors occured. "
					 									+se.getMessage());
		 }	 
		
	}

	//member push dislike button then delete the data from Product_like table
	//warning : if member didn't push like button first, it would occur SQLException
	@Override
	public void delete(String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(PUSH_DISLIKE);
			
			pstmt.setString(1, mem_no);
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
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
	}

	//Get who like this product
	@Override
	public List<Product_likeVO> Product_getAll(String product_no) {
		List<Product_likeVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(PRODUCT_WHO_LIKE);
			pstmt.setString(1, product_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Product_likeVO productlike = new Product_likeVO();
				productlike.setMem_no(rs.getString(productlike.getMem_no()));
				list.add(productlike);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver"
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "+ se.getMessage());
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

	//Get this member like which products
	@Override
	public List<Product_likeVO> Mem_getAll(String mem_no) {
		List<Product_likeVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(MEM_LIKE_WHICH_PRODUCT);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Product_likeVO productlike = new Product_likeVO();
				productlike.setProduct_no(rs.getString(productlike.getProduct_no()));
				list.add(productlike);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		}catch (SQLException se) {
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
		return list;
	}

}
