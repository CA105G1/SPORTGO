package com.ord.model;

import java.sql.*;
import java.util.*;

public class OrdJDBCDAO implements OrdDAO_interface{
	
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver"; 
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "test";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INERT_INTO = "Insert into ORD (ORD_NO,MEM_NO,ORD_DATE,ORD_DELDATE,ORD_STATUS,ORD_BACKDELDATE,ORD_AMOUNT,ORD_BACKAMOUNT) values (to_char(sysdate,'yyyymmdd')||'-'||LPAD(to_char(ORD_SEQ.NEXTVAL),6, '0'),?,CURRENT_TIMESTAMP,?,?,?,?,?)";
    //修改
	private static final String UPDATA = "UPDATE ORD SET  ORD_DELDATE = ?, ORD_STATUS = ?, ORD_BACKDELDATE = ?, ORD_AMOUNT = ?, ORD_BACKAMOUNT =?   WHERE ORD_NO = ? ";
	//刪除
	private static final String DELETE = "DELETE FROM ORD WHERE ORD_NO = ?";
	//單次查詢
	private static final String SELECT = "SELECT * FROM ORD WHERE ORD_NO = ?";
	//全部查詢
	private static final String SELECT_ALL = "SELECT * FROM ORD";
	
    static {
    	try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
    //新增
	@Override
	public int insert(OrdVO ordVO) {
		int count = 0;
		Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(INERT_INTO);
			ps.setString(1, ordVO.getMem_no());
			ps.setTimestamp (2,ordVO.getOrd_deldate());
			ps.setString (3,ordVO.getOrd_status());
			ps.setTimestamp (4,ordVO.getOrd_backdeldate());
			ps.setInt(5,ordVO.getOrd_amount());
			ps.setInt(6,ordVO.getOrd_backamount());
			
			
			count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(ps != null) {
				try {
					ps.close();
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
		return count;
	}
    //修改
	@Override
	public int updata(OrdVO ordVO) {
        int count = 0 ;
        Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareCall(UPDATA);
			ps.setTimestamp(1, ordVO.getOrd_deldate());
			ps.setString(2, ordVO.getOrd_status());
			ps.setTimestamp(3, ordVO.getOrd_backdeldate());
			ps.setInt(4, ordVO.getOrd_amount());
			ps.setInt(5, ordVO.getOrd_backamount());
			ps.setString(6, ordVO.getOrd_no());
			count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(ps != null) {
				try {
					ps.close();
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
		return count;
	}
    //刪除
	@Override
	public int delete(String ord_no) {
		int count = 0 ;
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
			if(ps != null) {
				try {
					ps.close();
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
		return count ;
	}
    //單筆查詢
	@Override
	public OrdVO findByPK(String ord_no) {
		OrdVO ordVO = null;
		Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT);
			ps.setString(1, ord_no);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ORD_NO"));
				ordVO.setMem_no(rs.getString("MEM_NO"));
				ordVO.setOrd_date(rs.getTimestamp("ORD_DATE"));
				ordVO.setOrd_deldate(rs.getTimestamp("ORD_DELDATE"));
				ordVO.setOrd_status(rs.getString("ORD_STATUS"));
				ordVO.setOrd_backdeldate(rs.getTimestamp("ORD_BACKDELDATE"));
				ordVO.setOrd_amount(rs.getInt("ORD_AMOUNT"));
				ordVO.setOrd_backamount(rs.getInt("ORD_BACKAMOUNT"));
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(ps != null) {
				try {
					ps.close();
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
		return ordVO;
	}
    //全部查詢
	@Override
	public List<OrdVO> getAll() {
		List<OrdVO> ordVOList = new ArrayList();
		Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_ALL);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				OrdVO ordVO = new OrdVO();
				ordVO.setOrd_no(rs.getString("ORD_NO"));
				ordVO.setMem_no(rs.getString("MEM_NO"));
				ordVO.setOrd_date(rs.getTimestamp("ORD_DATE"));
				ordVO.setOrd_deldate(rs.getTimestamp("ORD_DELDATE"));
				ordVO.setOrd_status(rs.getString("ORD_STATUS"));
				ordVO.setOrd_backdeldate(rs.getTimestamp("ORD_BACKDELDATE"));
				ordVO.setOrd_amount(rs.getInt("ORD_AMOUNT"));
				ordVO.setOrd_backamount(rs.getInt("ORD_BACKAMOUNT"));
				ordVOList.add(ordVO);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(ps != null) {
				try {
					ps.close();
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
		return ordVOList;
	}
    
    
    
}
