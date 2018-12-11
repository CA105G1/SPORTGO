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
	private static final String GET_ALL = 
			"SELECT * FROM Memberlist";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM Memberlist where MEM_NO = ? ";
		
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	@Override
	public void insert(MemberlistVO memberlist) {
		
	}

	@Override
	public void update(MemberlistVO memberlist) {
		
	}

	@Override
	public MemberlistVO findByPrimaryKey(String memno) {
		return null;
	}

	@Override
	public List<MemberlistVO> getAll() {
		List<MemberlistVO> list = new ArrayList<MemberlistVO>();
		MemberlistVO mem = new MemberlistVO();
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(GET_ALL);
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
				System.out.println(e.getMessage());
			}catch(SQLException se) {
				System.out.println(se.getMessage());
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
