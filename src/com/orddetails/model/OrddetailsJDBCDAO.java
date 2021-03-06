package com.orddetails.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class OrddetailsJDBCDAO implements Orddetails_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INSERT = "Insert into ORDDETAILS(ORD_NO,PRO_NO,ORD_PROBONUNS,PRO_COUNT) values (?,?,?,?)";
	//修改
	private static final String UPDATE = "UPDATE ORDDETAILS SET ORD_NO = ? ,PRO_NO = ? ,ORD_PROBONUNS = ?,PRO_COUNT = ? WHERE ORD_NO = ?";
	//刪除
	private static final String DELETE = "Delete FROM ORDDETAILS WHERE ORD_NO = ?";
	//單筆查詢
	private static final String SELECT_FINDBYPK_ORD = "SELECT * FROM ORDDETAILS WHERE ORD_NO = ?";
	//全部查詢
	private static final String SELECT_ALL = "SELECT * FROM ORDDETAILS";
	//連線池版
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new javax.naming.InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/CA105G1DB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//JDBC版本
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public int insert(OrddetailsVO orddetailsVO) {
		int count = 0;
        Connection con = null; 
		PreparedStatement ps = null;
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(INSERT);
			
			ps.setString(1, orddetailsVO.getOrd_no());
			ps.setString(2, orddetailsVO.getPro_no());
			ps.setInt(3, orddetailsVO.getOrd_probonuns());
			ps.setInt(4, orddetailsVO.getPro_count());
			
			count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return count;
	}

	@Override
	public int updata(OrddetailsVO orddetailsVO) {
		int count = 0;
        Connection con = null; 
		PreparedStatement ps = null;
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(UPDATE);
			
			ps.setString(1, orddetailsVO.getOrd_no());
			ps.setString(2, orddetailsVO.getPro_no());
			ps.setInt(3, orddetailsVO.getOrd_probonuns());
			ps.setInt(4, orddetailsVO.getPro_count());
			ps.setString(5, orddetailsVO.getOrd_no());
			
			count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return count;
	}

	@Override
	public int delete(String ord_no) {
		int count = 0;
        Connection con = null; 
		PreparedStatement ps = null;
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(DELETE);
			
			ps.setString(1, ord_no);		    
		    count = ps.executeUpdate();
		    
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return count;
	}

	@Override
	public List<OrddetailsVO>  findByPK(String ord_no) {
		OrddetailsVO orddetailsVO = null;
        Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		List<OrddetailsVO> list = new ArrayList();
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK_ORD);
			ps.setString(1, ord_no);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				orddetailsVO = new OrddetailsVO();
				orddetailsVO.setOrd_no(rs.getString("ORD_NO"));
				orddetailsVO.setPro_no(rs.getString("PRO_NO"));
				orddetailsVO.setOrd_probonuns(rs.getInt("ORD_PROBONUNS"));
				orddetailsVO.setPro_count(rs.getInt("PRO_COUNT"));
			    list.add(orddetailsVO);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return list;
	}

	@Override
	public List<OrddetailsVO> getAll() {
		List<OrddetailsVO> orddetailsVOList = new ArrayList();
        Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_ALL);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				OrddetailsVO orddetailsVO = new OrddetailsVO();
				orddetailsVO.setOrd_no(rs.getString("ORD_NO"));
				orddetailsVO.setPro_no(rs.getString("PRO_NO"));
				orddetailsVO.setOrd_probonuns(rs.getInt("ORD_PROBONUNS"));
				orddetailsVO.setPro_count(rs.getInt("PRO_COUNT"));
				orddetailsVOList.add(orddetailsVO);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return orddetailsVOList;
	}
    //同時新增訂單與訂單明細
	@Override
	public void insert2(OrddetailsVO orddetailsVO, Connection con) {
		
		PreparedStatement ps = null;
		
		try {
			
			ps = con.prepareStatement(INSERT);
			ps.setString(1, orddetailsVO.getOrd_no());
			ps.setString(2, orddetailsVO.getPro_no());
			ps.setInt(3, orddetailsVO.getOrd_probonuns());
			ps.setInt(4, orddetailsVO.getPro_count());
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			if (con != null) {
				try {
					// 3●設定於當有exception發生時之catch區塊內
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-emp");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. "
							+ excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. "
					+ e.getMessage());
			// Clean up JDBC resources
		}finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}

		}
		
	}

}
