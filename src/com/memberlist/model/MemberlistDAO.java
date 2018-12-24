package com.memberlist.model;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class MemberlistDAO implements MemberlistDAO_interface{

	public MemberlistDAO() {
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
	
	private static final String INSERT_STMT = 
			"INSERT INTO MEMBERLIST (MEM_NO,MEM_NAME,MEM_ACCOUNT,MEM_PSWD,MEM_EMAIL,MEM_PHONE)"
			+ "VALUES ('M'||LPAD(TO_CHAR(member_seq.NEXTVAL),3,'0'),?,?,?,?,?)";		
	private static final String UPDATE_PRIVACY =
			"UPDATE MEMBERLIST SET MEM_NAME=?,MEM_NICK=?,MEM_EMAIL=?"
			+ ",MEM_PHONE=?,MEM_EMGC=?,MEM_EMGCPHONE=? WHERE MEM_NO=?";
	private static final String UPDATE_STATUS =
			"UPDATE MEMBERLIST SET MEM_STATUS = ? WHERE MEM_NO = ?";
	private static final String UPDATE_PASSWORD = 
			"UPDATE MEMBERLIST SET MEM_PSWD = ? WHERE MEM_NO = ?";
	private static final String UPDATE_PICTURE =
			"UPDATE MEMBERLIST SET MEM_PIC=?, MEM_PICKIND=? WHERE MEM_NO = ?";
	private static final String UPDATE_CRADITCARD = 
			"UPDATE MEMBERLIST SET MEM_CARD = ?, MEM_EXPIRY = ? WHERE MEM_NO = ?";
	private static final String GET_ALL_STMT = 
			"SELECT * FROM Memberlist";
	private static final String GET_ONE_STMT = 
			"SELECT * FROM Memberlist WHERE MEM_NO = ? ";
	private static final String GET_ONE_STMT_FROM_ACCOUNT = 
			"SELECT * FROM Memberlist WHERE MEM_ACCOUNT = ? ";
	
	
		
	
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
	public void updatePrivacy(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PRIVACY);
			System.out.println(memberlist.getMem_emgcphone());
			pstmt.setString(1, memberlist.getMem_name());
			pstmt.setString(2, memberlist.getMem_nick());
			pstmt.setString(3, memberlist.getMem_email());
			pstmt.setString(4, memberlist.getMem_phone());
			pstmt.setString(5, memberlist.getMem_emgc());
			pstmt.setString(6, memberlist.getMem_emgcphone());
			pstmt.setString(7, memberlist.getMem_no());
			
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
	public void updatePassword(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PASSWORD);
			
			pstmt.setString(1, memberlist.getMem_pswd());
			pstmt.setString(2, memberlist.getMem_no());
			
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
	public void updatePicture(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_PICTURE);
			
			pstmt.setBytes(1, memberlist.getMem_pic());
			pstmt.setString(2, memberlist.getMem_pickind());
			pstmt.setString(3, memberlist.getMem_no());
			
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
	public void updateCraditcard(MemberlistVO memberlist) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_CRADITCARD);
			
			pstmt.setString(1, memberlist.getMem_card());
			pstmt.setString(2, memberlist.getMem_expiry());
			pstmt.setString(3, memberlist.getMem_no());
			
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
	public MemberlistVO findByPrimaryKey(String memno) {
		MemberlistVO memberlist = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			pstmt.setString(1, memno);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberlist = new MemberlistVO();
				memberlist.setMem_no(memno);
				memberlist.setMem_name(rs.getString("mem_name"));
				memberlist.setMem_nick(rs.getString("mem_nick"));
				memberlist.setMem_account(rs.getString("mem_account"));
				memberlist.setMem_pswd(rs.getString("mem_pswd"));
				memberlist.setMem_email(rs.getString("mem_email"));
				memberlist.setMem_phone(rs.getString("mem_phone"));
				memberlist.setMem_emgc(rs.getString("mem_emgc"));
				memberlist.setMem_emgcphone(rs.getString("mem_emgcphone"));
				memberlist.setMem_status(rs.getString("mem_status"));
				memberlist.setMem_card(rs.getString("mem_card"));
				memberlist.setMem_expiry(rs.getString("mem_expiry"));
				memberlist.setMem_pic(rs.getBytes("mem_pic"));
				memberlist.setMem_pickind(rs.getString("mem_pickind"));
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
		return  memberlist;
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
				mem = new MemberlistVO();
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
				mem.setMem_pic(rs.getBytes("mem_pic"));
				mem.setMem_pickind(rs.getString("mem_pickind"));
				list.add(mem);
			}
		}catch(SQLException se) {
				throw new RuntimeException("Database errors occured. "
															+se.getMessage());
		}finally {
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
	public String findByAccount(String account) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String mem_no = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT_FROM_ACCOUNT);
			pstmt.setString(1, account);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mem_no = rs.getString("mem_no");
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
		return  mem_no;
	}

	
	
	
	
}
