package com.orddetails.model;

import java.sql.*;
import java.util.*;



public class OrddetailsJDBCDAO implements Orddetails_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "test";
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
			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
	public OrddetailsVO findByPK(String ord_no) {
		OrddetailsVO orddetailsVO = null;
        Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK_ORD);
			ps.setString(1, ord_no);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				orddetailsVO = new OrddetailsVO();
				orddetailsVO.setOrd_no(rs.getString("ORD_NO"));
				orddetailsVO.setPro_no(rs.getString("PRO_NO"));
				orddetailsVO.setOrd_probonuns(rs.getInt("ORD_PROBONUNS"));
				orddetailsVO.setPro_count(rs.getInt("PRO_COUNT"));
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
		return orddetailsVO;
	}

	@Override
	public List<OrddetailsVO> getAll() {
		List<OrddetailsVO> orddetailsVOList = new ArrayList();
        Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
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

}
