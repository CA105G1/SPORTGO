package com.android.friend.model;

import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.*;

public class FriendDAO_android implements FriendDAO_interface{

	public FriendDAO_android() {
	}
	private static DataSource ds = null;
	static {
		Context ctx;
		try {
			ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1DB");
		} catch (NamingException e) {
			e.printStackTrace(System.err);
		}
	}
	
	private static final String INSERT = 
			"INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES (?,?)";
	private static final String DELETE = 
			"DELETE FROM FRIEND WHERE (MEM1_NO=? AND MEM2_NO=?) or (MEM1_NO=? AND MEM2_NO=?)";
	private static final String FIND_FRIEND = 
			"SELECT * FROM FRIEND WHERE (MEM1_NO = ? OR MEM2_NO = ?) AND FRIEND_STATUS = '好友' ";
	private static final String FIND_POSSIBLE_FRIEND = 
			"SELECT * FROM FRIEND WHERE MEM1_NO = ? AND FRIEND_STATUS = '申請中'";
	private static final String FIND_WHO_ADD_ME = 
			"SELECT * FROM FRIEND WHERE MEM2_NO = ? AND FRIEND_STATUS = '申請中'";
	private static final String FIND_ALL = 
			"SELECT * FROM FRIEND ";
	private static final String UPDATE_STATUS = 
			"UPDATE FRIEND SET friend_status=? WHERE (mem1_no=? AND mem2_no=?) or (mem1_no=? AND mem2_no=?)";
	private static final String UPDATE_RELATIONSHIP = 
			"UPDATE FRIEND SET friend_status=? WHERE (mem1_no=? AND mem2_no=?) or (mem1_no=? AND mem2_no=?)";
	
	@Override
	public void insert(String mem1_no, String mem2_no) {
		Connection con = null;
		PreparedStatement pstmt =null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			pstmt.setString(1, mem1_no);
			pstmt.setString(2, mem2_no);
			
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
	public void delete(String mem1_no, String mem2_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, mem1_no);
			pstmt.setString(2, mem2_no);
			pstmt.setString(3, mem2_no);
			pstmt.setString(4, mem1_no);
			
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
	public List<Friend> findMyFriend(String mem_no) {
		List<Friend> list = new ArrayList<>();
		Friend friend = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_FRIEND);
			
			pstmt.setString(1, mem_no);
			pstmt.setString(2, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend = new Friend();
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
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
		return list;
	}

	@Override
	public void updateStatus(String mem1_no, String mem2_no, String status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STATUS);
			pstmt.setString(1, status);
			pstmt.setString(2, mem1_no);
			pstmt.setString(3, mem2_no);
			pstmt.setString(4, mem2_no);
			pstmt.setString(5, mem1_no);
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
	public void updateRelationship(String mem1_no, String mem2_no, String relationship) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_RELATIONSHIP);
			pstmt.setString(1, relationship);
			pstmt.setString(2, mem1_no);
			pstmt.setString(3, mem2_no);
			pstmt.setString(4, mem2_no);
			pstmt.setString(5, mem1_no);
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
	public List<Friend> findMyPossibleFriend(String mem_no) {
		List<Friend> list = new ArrayList<>();
		Friend friend = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_POSSIBLE_FRIEND);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend = new Friend();
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
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
		return list;
	}

	@Override
	public List<Friend> findWhoAddMe(String mem_no) {
		List<Friend> list = new ArrayList<>();
		Friend friend = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_WHO_ADD_ME);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend = new Friend();
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
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
		return list;
	}

	@Override
	public List<Friend> findAll() {
		List<Friend> list = new ArrayList<>();
		Friend friend = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_ALL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend = new Friend();
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
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
		return list;
	}
}
