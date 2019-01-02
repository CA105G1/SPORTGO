package com.android.member.model;

import java.sql.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.google.gson.Gson;
import com.google.gson.JsonObject;


public class MemberDAO_android implements MemberDAO_interface_android  {

	public MemberDAO_android(){

	}
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}	
	
	private static final String INSERT_STMT = 
			"INSERT INTO memberlist (MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE)"
			+ "VALUES ('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),?,?,?,?,?)";		
	private static final String UPDATE_PRIVACY =
			"UPDATE memberlist SET MEM_NAME=?,MEM_NICK=?,MEM_EMAIL=?"
			+ ",MEM_PHONE=?,MEM_EMGC=?,MEM_EMGCPHONE=? WHERE MEM_NO=?";
	private static final String UPDATE_STATUS =
			"UPDATE memberlist SET MEM_STATUS = ? WHERE MEM_NO = ?";
	private static final String UPDATE_PASSWORD = 
			"UPDATE memberlist SET MEM_PSWD = ? WHERE MEM_NO = ?";
//	private static final String UPDATE_PICTURE =
//			"UPDATE member SET MEM_PIC, MEM_PICKIND WHERE MEM_NO = ?";
	private static final String UPDATE_CRADITCARD = 
			"UPDATE memberlist SET MEM_CARD = ?, MEM_EXPIRY = ? WHERE MEM_NO = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM memberlist";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM memberlist where MEM_NO = ? ";
	private static final String CHECK_ID_EXIST = 
			"SELECT * FROM memberlist WHERE mem_account = ? AND mem_pswd = ?";
	private static final String GET_PROFILE_PIC =
			"SELECT MEM_PIC FROM MEMBERLIST WHERE MEM_NO = ?";
		
	
	@Override
	public void insert(MemberVO_android member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			pstmt.setString(1, member.getMem_name());
			pstmt.setString(2, member.getMem_account());
			pstmt.setString(3, member.getMem_pswd());
			pstmt.setString(4, member.getMem_email());
			pstmt.setString(5, member.getMem_phone());
			
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
	public void updatePrivacy(MemberVO_android member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PRIVACY);
			System.out.println(member.getMem_emgcphone());
			pstmt.setString(1, member.getMem_name());
			pstmt.setString(2, member.getMem_nick());
			pstmt.setString(3, member.getMem_email());
			pstmt.setString(4, member.getMem_phone());
			pstmt.setString(5, member.getMem_emgc());
			pstmt.setString(6, member.getMem_emgcphone());
			pstmt.setString(7, member.getMem_no());
			
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
	public void updateStatus(String mem_no, String mem_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
			
			pstmt.setString(1, mem_status);
			pstmt.setString(2, mem_no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException se) {
			throw new RuntimeException("Database errors occured" 
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
	public void updatePassword(MemberVO_android member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PASSWORD);
			
			pstmt.setString(1, member.getMem_pswd());
			pstmt.setString(2, member.getMem_no());
			
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


//	@Override
//	public void updatePicture(MemberVO member) {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		try {
//			Class.forName(driver);
//			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
//			pstmt = con.prepareStatement(UPDATE_PICTURE);
//			
//			pstmt.setBytes(1, member.getMem_pic());
//			pstmt.setString(2, member.getMem_pickind());
//			pstmt.setString(3, member.getMem_no());
//			
//			pstmt.executeUpdate();
//		} catch (ClassNotFoundException e) {
//			throw new RuntimeException("Couldn't load the database driver. "
//														+e.getMessage());
//		} catch (SQLException se) {
//			throw new RuntimeException("Database errors occured. "
//														+se.getMessage());
//		} finally {
//			if(pstmt!=null) {
//				try {
//					pstmt.close();
//				} catch (SQLException e) {
//					e.printStackTrace(System.err);
//				}
//			}
//			if(con!=null) {
//				try {
//					con.close();
//				} catch (SQLException e) {
//					e.printStackTrace(System.err);
//				}
//			}
//		}		
//	}

	@Override
	public void updateCraditcard(MemberVO_android member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_CRADITCARD);
			
			pstmt.setString(1, member.getMem_card());
			pstmt.setString(2, member.getMem_expiry());
			pstmt.setString(3, member.getMem_no());
			
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
	public MemberVO_android findByPrimaryKey(String memno) {
		
		MemberVO_android member = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, memno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				member = new MemberVO_android();
				member.setMem_name(rs.getString("mem_name"));
				member.setMem_nick(rs.getString("mem_nick"));
				member.setMem_account(rs.getString("mem_account"));
				member.setMem_pswd(rs.getString("mem_pswd"));
				member.setMem_email(rs.getString("mem_email"));
				member.setMem_phone(rs.getString("mem_phone"));
				member.setMem_emgc(rs.getString("mem_emgc"));
				member.setMem_emgcphone(rs.getString("mem_emgcphone"));
				member.setMem_status(rs.getString("mem_status"));
				member.setMem_card(rs.getString("mem_card"));
				member.setMem_expiry(rs.getString("mem_expiry"));
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
		
		return member;
	}

	@Override
	public List<MemberVO_android> getAll() {
		List<MemberVO_android> list = new ArrayList<MemberVO_android>();
		MemberVO_android mem = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mem = new MemberVO_android();
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
				mem.setMem_card(rs.getString("mem_card"));
				mem.setMem_expiry(rs.getString("mem_expiry"));
				list.add(mem);
			}
		} catch(SQLException se) {
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
		return list;
	}
	
	@Override
	public String isMember(String mem_account, String mem_pswd) {
		
		Connection con = null;
		PreparedStatement ps = null;
		JsonObject jobj = new JsonObject();
		
		try {
			
			con = ds.getConnection();
			ps = con.prepareStatement(CHECK_ID_EXIST);
			ps.setString(1, mem_account);
			ps.setString(2, mem_pswd);
			ResultSet rs = ps.executeQuery();
			
			while (rs.next()) {
				MemberVO_android mem = new MemberVO_android();
				mem = new MemberVO_android();
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
				mem.setMem_card(rs.getString("mem_card"));
				mem.setMem_expiry(rs.getString("mem_expiry"));
				
				String member = new Gson().toJson(mem);
				jobj.addProperty("member", member);
				jobj.addProperty("isMember", true);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			
			try {
				
				if (ps != null) {
					ps.close();
				}
				
				if (con != null) {
					con.close();
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return jobj.toString();
	}

	@Override
	public byte[] getImage(String mem_no) {
		byte[] mem_pic = null;
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			psmt = con.prepareStatement(GET_PROFILE_PIC);
			
			psmt.setString(1, mem_no);
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				mem_pic = rs.getBytes(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if (psmt != null) {
				try {
					psmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		
		return mem_pic;
	}
}
