package com.address.model;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.*;
public class AddressDAO implements AddressDAO_interface {

	public AddressDAO() {
	}
	private static DataSource ds = null;
	static {
		
			Context ctx;
			try {
				ctx = new InitialContext();
				ds = (DataSource)ctx.lookup("java:comp/env/jdbc/CA105G1DB");
			} catch (NamingException e) {
				e.printStackTrace();
			}
	}
	
	private static final String INSERT_ADDR = 
			"INSERT INTO ADDRESS (ADDR_NO,MEM_NO,RECEIVER,RECEIVER_PHONE,COUNTRY,CITY,ADDR_DETAIL"
			+ ",ADDR_ZIP) VALUES ('A'||LPAD(TO_CHAR(address_seq.NEXTVAL),3,'0'),?,?,?,?,?,?,?)";
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
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_ADDR);
			System.out.println(address.getAddr_zip());
			pstmt.setString(1, address.getMem_no());
			pstmt.setString(2, address.getReceiver());
			pstmt.setString(3, address.getReceiver_phone());
			pstmt.setString(4, address.getCountry());
			pstmt.setString(5, address.getCity());
			pstmt.setString(6, address.getAddr_detail());
			pstmt.setInt(7, address.getAddr_zip());
			
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
	public void delete(String addr_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE_ADDR);
			
			pstmt.setString(1, addr_no);
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
	//find the member address
	@Override
	public List<AddressVO> getByForeignKey(String mem_no) {
		List<AddressVO> list = new ArrayList<>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_MEM_ADDR);
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AddressVO address = new AddressVO();
				address.setAddr_no(rs.getString("addr_no"));
				address.setReceiver(rs.getString("receiver"));
				address.setReceiver_phone(rs.getString("receiver_phone"));
				address.setCountry(rs.getString("country"));
				address.setCity(rs.getString("city"));
				address.setAddr_detail(rs.getString("addr_detail"));
				address.setAddr_zip(rs.getInt("addr_zip"));
				list.add(address);
			}
			
		} catch (SQLException se) {
			throw new RuntimeException("Database errors ocurred. "
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
	//find all addresses safe in database
	@Override
	public List<AddressVO> getAll() {
		List<AddressVO> listall = new ArrayList<>();
		AddressVO address = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_ALL_ADDR);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				address = new AddressVO();
				address.setAddr_no(rs.getString("addr_no"));
				address.setMem_no(rs.getString("mem_no"));
				address.setReceiver(rs.getString("receiver"));
				address.setReceiver_phone(rs.getString("receiver_phone"));
				address.setCountry(rs.getString("country"));
				address.setCity(rs.getString("city"));
				address.setAddr_detail(rs.getString("addr_detail"));
				address.setAddr_zip(rs.getInt("addr_zip"));
				listall.add(address);
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
		return listall;
	}
}
