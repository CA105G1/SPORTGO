package com.memberlist.model;

import javax.naming.*;
import javax.sql.DataSource;

import java.sql.*;
import java.util.*;

public class MemberlistDAO implements MemberlistDAO_interface {

	public MemberlistDAO() {
		// TODO Auto-generated constructor stub
	}

	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/TestDB");
		}catch(NamingException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_STMT = 
			"INSERT INTO MEMBERLIST (MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE)"
			+ "VALUES ('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),?,?,?,?,?)";		
	private static final String UPDATE =
			"UPDATE MEMBERLIST SET MEM_NAME=?,MEM_NICK=?,MEM_ACCOUNT=?,MEM_PSWD=?,MEM_EMAIL=?,"
			+"MEM_PHONE=?,MEM_EMGC=?,MEM_EMCGPHONE=?,MEM_STATUS=?,MEM_CARD=?,MEM_EXPIRY=?,MEM_PIC=?"
			+"MEM_PICKIND=?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM MEMBERLIST";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM MEMBERLIST WHERE MEM_NO = ? ";
	@Override
	public void insert(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, memberlist.getMem_name());
			pstmt.setString(2, memberlist.getMem_account());
			pstmt.setString(3, memberlist.getMem_pswd());
			pstmt.setString(4, memberlist.getMem_email());
			pstmt.setString(5, memberlist.getMem_phone());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException("Database errors occured"
													+e.getMessage());
		}finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				} 
			} catch (SQLException se) {
				se.printStackTrace(System.err);
			}
		}
		
	}
	@Override
	public void update(MemberlistVO memberlist) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public MemberlistVO findByPrimaryKey(String memno) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<MemberlistVO> getAll() {
		List<MemberlistVO> list = new ArrayList<MemberlistVO>();
		MemberlistVO mem = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
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
		}catch(SQLException se) {
				throw new RuntimeException("A database error occured. "
							+se.getMessage());
		}finally {
			if(rs != null) {
				
					try {
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace(System.err);
					}
			}		
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
		
		
		return list;
	
	}
	
	
	
}
