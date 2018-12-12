package com.memberlist.model;

import java.sql.*;
import java.util.*;

public class MemberlistJDBCDAO implements MemberlistDAO_interface  {

	public MemberlistJDBCDAO(){

	}
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@10.37.129.3:1521:XE";
	String user = "AARON";
	String password = "123456";
	
	private static final String INSERT_STMT = 
			"INSERT INTO MEMBERLIST (MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE)"
			+ "VALUES ('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),?,?,?,?,?)";		
	private static final String UPDATE =
			"UPDATE MEMBERLIST SET MEM_NAME=?,MEM_NICK=?,MEM_ACCOUNT=?,MEM_PSWD=?,MEM_EMAIL=?,"
			+"MEM_PHONE=?,MEM_EMGC=?,MEM_EMCGPHONE=?,MEM_CARD=?,MEM_EXPIRY=?,MEM_PIC=?"
			+"MEM_PICKIND=?";
	private static final String UPDATE_STATUS =
			"UPDATE MEMBERLIST MEM_STATUS = ? WHERE MEM_NO = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM Memberlist";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM Memberlist where MEM_NO = ? ";
	
	
		
	
	@Override
	public void insert(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, memberlist.getMem_name());
			pstmt.setString(2, memberlist.getMem_account());
			pstmt.setString(3, memberlist.getMem_pswd());
			pstmt.setString(4, memberlist.getMem_email());
			pstmt.setString(5, memberlist.getMem_phone());
			
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
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void update(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, memberlist.getMem_name());
			pstmt.setString(2, memberlist.getMem_nick());
			pstmt.setString(3, memberlist.getMem_account());
			pstmt.setString(4, memberlist.getMem_pswd());
			pstmt.setString(5, memberlist.getMem_email());
			pstmt.setString(6, memberlist.getMem_phone());
			pstmt.setString(7, memberlist.getMem_emgc());
			pstmt.setString(8, memberlist.getMem_emgcphone());
			pstmt.setInt(9, memberlist.getMem_card());
			pstmt.setDate(10, memberlist.getMem_expiry());
			pstmt.setBytes(11, memberlist.getMem_pic());
			pstmt.setString(12, memberlist.getMem_pickind());
			
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
	public void updateStatus(String mem_no, String mem_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, mem_status);
			pstmt.setString(2, mem_no);
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured" 
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
	public List<MemberlistVO> findByPrimaryKey(String memno) {
		List<MemberlistVO> list = new ArrayList<>();
		MemberlistVO memberlist = new MemberlistVO();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, memno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberlist.setMem_name(rs.getString("mem_name"));
				memberlist.setMem_nick(rs.getString("mem_nick"));
				memberlist.setMem_account(rs.getString("mem_account"));
				memberlist.setMem_pswd(rs.getString("mem_pswd"));
				memberlist.setMem_email(rs.getString("mem_email"));
				memberlist.setMem_phone(rs.getString("mem_phone"));
				memberlist.setMem_emgc(rs.getString("mem_emgc"));
				memberlist.setMem_emgcphone(rs.getString("mem_emgcphone"));
				memberlist.setMem_status(rs.getString("mem_status"));
				memberlist.setMem_card(rs.getInt("mem_card"));
				memberlist.setMem_expiry(rs.getDate("mem_expiry"));
				memberlist.setMem_pic(rs.getBytes("mem_pic"));
				memberlist.setMem_pickind(rs.getString("mem_pickind"));
				list.add(memberlist);
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
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return  list;
	}

	@Override
	public List<MemberlistVO> getAll() {
		List<MemberlistVO> list = new ArrayList<MemberlistVO>();
		MemberlistVO mem = new MemberlistVO();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				mem.setMem_no(rs.getString("mem_no"));
				mem.setMem_name(rs.getString("mem_name"));
				mem.setMem_nick(rs.getString("mem_nick"));
				mem.setMem_account(rs.getString("mem_account"));
				mem.setMem_pswd(rs.getString("mem_pswd"));
				mem.setMem_email(rs.getString("mem_email"));
				mem.setMem_phone(rs.getString("mem_phone"));
				mem.setMem_emgc(rs.getString("mem_emgc"));
				mem.setMem_emgcphone(rs.getString("mem_emgcphone"));
				mem.setMem_status(rs.getString("mem_status"));
				mem.setMem_card(rs.getInt("mem_card"));
				mem.setMem_expiry(rs.getDate("mem_expiry"));
				mem.setMem_pic(rs.getBytes("mem_pic"));
				mem.setMem_pickind(rs.getString("mem_pickind"));
				list.add(mem);
			}
		}catch(ClassNotFoundException e) {
				throw new RuntimeException("Couldn't load the database driver. "
															+e.getMessage());
			}catch(SQLException se) {
				throw new RuntimeException("Database errors occured. "
															+se.getMessage());
		}finally {
			if(rs!=null) {
				try {
					rs.close();
				}catch(SQLException s) {
					s.printStackTrace(System.err);
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch (SQLException seq) {
					seq.printStackTrace(System.err);
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch(Exception e) {
					e.printStackTrace(System.err);
				}
			}	
		}
		return list;
	}

}
