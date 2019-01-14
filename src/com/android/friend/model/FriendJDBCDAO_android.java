package com.android.friend.model;

import java.util.*;
import java.sql.*;

public class FriendJDBCDAO_android implements FriendDAO_interface{

	public FriendJDBCDAO_android() {
	}

	private String driver = "oracle.jdbc.driver.OracleDriver";
	private String url = "jdbc:oracle:thin:@10.37.129.3:1521:xe";
	private String user = "AARON";
	private String password = "123456";
	
	private static final String INSERT = 
			"INSERT INTO FRIEND (MEM1_NO,MEM2_NO) VALUES (?,?)";
	
	//DELETE FROM FRIEND WHERE (mem1_no='M001' AND mem2_no='M002')
	//or (mem1_no='M002' AND mem2_no='M001');
	private static final String DELETE = 
			"DELETE FROM FRIEND WHERE (mem1_no=? AND mem2_no=?)"
			+"or (mem1_no=? AND mem2_no=?)";
	private static final String FIND_FRIEND = 
			"SELECT * FROM FRIEND WHERE (MEM1_NO = ? OR MEM2_NO = ?) AND FRIEND_STATUS = '好友'";
	private static final String FIND_POSSIBLE_FRIEND = 
			"SELECT * FROM FRIEND WHERE (MEM1_NO = ? OR MEM2_NO = ?) AND FRIEND_STATUS = '申請中'";
	private static final String FIND_WHO_ADD_ME = 
			"SELECT * FROM FRIEND WHERE MEM2_NO = ? AND FRIEND_STATUS = '申請中'";
	private static final String FIND_ALL = 
			"SELECT * FROM FRIEND ";
	
	//UPDATE FRIEND SET friend_status='好友' WHERE (mem1_no='M001' AND mem2_no='M002') 
	//or (mem1_no='M002' AND mem2_no='M001');
	private static final String UPDATE_STATUS = 
			"UPDATE FRIEND SET friend_status=? WHERE (mem1_no=? AND mem2_no=?) "
			+ "or (mem1_no=? AND mem2_no=?)";
	
	private static final String UPDATE_RELATIONSHIP = 
			"UPDATE FRIEND SET friend_status=? WHERE (mem1_no=? AND mem2_no=?) "
			+ "or (mem1_no=? AND mem2_no=?)";
	
	@Override
	public void insert(String mem1_no, String mem2_no) {
		Connection con = null;
		PreparedStatement pstmt =null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(INSERT);
			pstmt.setString(1, mem1_no);
			pstmt.setString(2, mem2_no);
			
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setString(1, mem1_no);
			pstmt.setString(2, mem2_no);
			pstmt.setString(3, mem2_no);
			pstmt.setString(4, mem1_no);
			
			pstmt.executeUpdate();
			} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
		Friend friend = new Friend();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_FRIEND);
			
			pstmt.setString(1, mem_no);
			pstmt.setString(2, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
			}
				
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver"
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_STATUS);
			pstmt.setString(1, status);
			pstmt.setString(2, mem1_no);
			pstmt.setString(3, mem2_no);
			pstmt.setString(4, mem2_no);
			pstmt.setString(5, mem1_no);
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(UPDATE_RELATIONSHIP);
			pstmt.setString(1, relationship);
			pstmt.setString(2, mem1_no);
			pstmt.setString(3, mem2_no);
			pstmt.setString(4, mem2_no);
			pstmt.setString(5, mem1_no);
			pstmt.executeUpdate();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver. "
														+e.getMessage());
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
	public static void main(String[] args) {
		Friend friend = new Friend();
		friend.setMem1_no("M003");
		friend.setMem2_no("M001");
		friend.setFriend_status("好友");
		FriendJDBCDAO_android jdbc = new FriendJDBCDAO_android();
		jdbc.updateStatus("M001","M003","好友");
		System.out.println("update completed.");
	}

	@Override
	public List<Friend> findMyPossibleFriend(String mem_no) {
		List<Friend> list = new ArrayList<>();
		Friend friend = new Friend();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_POSSIBLE_FRIEND);
			
			pstmt.setString(1, mem_no);
			pstmt.setString(2, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
			}
				
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver"
														+e.getMessage());
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
		Friend friend = new Friend();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_WHO_ADD_ME);
			
			pstmt.setString(1, mem_no);
			pstmt.setString(2, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
			}
				
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver"
														+e.getMessage());
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
		Friend friend = new Friend();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
			pstmt = con.prepareStatement(FIND_ALL);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				friend.setMem1_no(rs.getString("mem1_no"));
				friend.setMem2_no(rs.getString("mem2_no"));
				friend.setFriend_status(rs.getString("friend_status"));
				friend.setRelationship(rs.getString("relationship"));
				friend.setMem_chat(rs.getString("mem_chat"));
				list.add(friend);
			}
				
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load the database driver"
														+e.getMessage());
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
