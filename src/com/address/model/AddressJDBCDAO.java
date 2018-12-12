package com.address.model;

import java.util.*;
import java.sql.*;
public class AddressJDBCDAO implements AddressDAO_interface {

	public AddressJDBCDAO() {
	}
	
	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin@10.37.129.3:1521:xe";
	private String user = "AARON";
	private String password = "123456";
	
	private static final String INSERT_ADDR = 
			"INSERT INTO ADDRESS (ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL"
			+ ",ADD_ZIP) VALUES ('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),?,?,?,?,?,?,?)";
	private static final String DELETE_ADDR = 
			"DELETE FROM ADDRESS WHERE ADDR_NO = ? ";
	private static final String FIND_MEM_ADDR =
			"SELECT * FROM ADDRESS WHERE MEM_NO = ?";
	private static final String FIND_ALL_ADDR =
			"SELECT * FROM ADDRESS";
	@Override
	public void insert(AddressVO address) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_ADDR);
			
			pstmt.setString(1, address.getMem_no());
			pstmt.setString(2, address.getReceiver());
			pstmt.setString(3, address.getReceiver_phone());
			pstmt.setString(4, address.getCountry());
			pstmt.setString(5, address.getCity());
			pstmt.setString(6, address.getAddr_detail());
			pstmt.setInt(7, address.getAddr_zip());
			
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
	public void delete(String addr_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE_ADDR);
			
			pstmt.setString(1, addr_no);
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured. "
					+se.getMessage());
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
				if(con != null) {
					con.close();
				}
			}catch (SQLException se) {
				se.printStackTrace();
			}
		}
	}

	@Override
	public List<AddressVO> getByForeignKey(String mem_no) {
		List<AddressVO> list = new ArrayList<>();
		AddressVO address = new AddressVO();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_MEM_ADDR);
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				address.setAddr_no(rs.getString("addr_no"));
				address.setReceiver(rs.getString("receiver"));
				address.setReceiver_phone(rs.getString("receiver_phone"));
				address.setCountry(rs.getString("country"));
				address.setCity(rs.getString("city"));
				address.setAddr_detail(rs.getString("addr_detail"));
				address.setAddr_zip(rs.getInt("addr_zip"));
				list.add(address);
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors ocurred. "
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

	@Override
	public List<AddressVO> getAll() {
		List<AddressVO> list = new ArrayList<>();
		AddressVO address = new AddressVO();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_ALL_ADDR);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				address.setAddr_no(rs.getString("addr_no"));
				address.setMem_no(rs.getString("mem_no"));
				address.setReceiver(rs.getString("receiver"));
				address.setReceiver_phone(rs.getString("receiver_phone"));
				address.setCountry(rs.getString("country"));
				address.setCity(rs.getString("city"));
				address.setAddr_detail(rs.getString("addr_detail"));
				address.setAddr_zip(rs.getInt("addr_zip"));
				list.add(address);
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

}
