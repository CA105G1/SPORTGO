package com.respones.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ResponesDAO  implements ResponesDAO_interface{
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1DB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	 
		@Override
	public List<ResponesVO> getAll(Map<String, String[]> map) {
		// TODO Auto-generated method stub
		return null;
	}


		private static final String INSERT_STMT = 
			"INSERT INTO respones (res_no,post_no,mem_no,res_content,res_date) VALUES (('R'||LPAD(to_char(club_seq.NEXTVAL), 4, '0')), ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT res_no,post_no,mem_no,res_content,res_date FROM respones order by res_no";
		private static final String GET_ONE_STMT = 
			"SELECT res_no,post_no,mem_no,res_content,res_date FROM respones where res_no = ?";
		private static final String UPDATE = 
			"UPDATE respones set res_no=?, post_no=?, mem_no=?, res_content=?, res_date=? where res_no = ?";
		private static final String GET_ALL_STMT_FROM_POSTNO = 
			"SELECT * FROM respones where post_no=?";
		private static final String DELETE = 
			"DELETE FROM respones  where res_no = ? AND mem_no = ? ";
		private static final String DELETE_BY_POST_NO = 
			"DELETE FROM respones  where post_no = ?";
		
		@Override
		public void insert(ResponesVO responesVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);
				
				pstmt.setString(1, responesVO.getPost_no());
				pstmt.setString (2, responesVO.getMem_no());
				pstmt.setString(3, responesVO.getRes_content());
				pstmt.setTimestamp(4, responesVO.getRes_date());
				
				pstmt.executeUpdate();
				
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
				
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
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
		}
		
		
		@Override
		public void update(ResponesVO responesVO) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);
				
				pstmt.setString (1, responesVO.getPost_no());
				pstmt.setString(2, responesVO.getMem_no());
				pstmt.setString(3, responesVO.getRes_content());
				pstmt.setTimestamp(4, responesVO.getRes_date());
				
				pstmt.executeUpdate();
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
				// Clean up JDBC resources
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
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
		}
		
			
		
		@Override
		public ResponesVO findByPrimaryKey(String club_no) {

			ResponesVO responesVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);
				pstmt.setString(1, club_no);
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					responesVO = new ResponesVO();
					pstmt.setString(1, responesVO.getRes_no());
					pstmt.setString (2, responesVO.getPost_no());
					pstmt.setString(3, responesVO.getMem_no());
					pstmt.setString(4, responesVO.getRes_content());
					pstmt.setTimestamp(5, responesVO.getRes_date());
				
				}
				
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			} finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
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
			return responesVO;
		}
		
		
		@Override
		public List<ResponesVO> getAll() {
			List<ResponesVO> list = new ArrayList<ResponesVO>();
			ResponesVO responesVO = null;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();
				list = collectResponesVO(rs);
//				while(rs.next()) {
//					responesVO = new ResponesVO();
//					responesVO.setRes_no(rs.getString("res_no"));
//					responesVO.setPost_no(rs.getString("post_no"));
//					responesVO.setMem_no(rs.getString("mem_no"));
//					responesVO.setRes_content(rs.getString("res_content"));
//					responesVO.setRes_date(rs.getTimestamp("res_date"));
//					list.add(responesVO);
//				}
			
			} catch (SQLException se) {
se.printStackTrace();
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}
			return list;
		}

		private List<ResponesVO> collectResponesVO(ResultSet rs) throws SQLException{
			List<ResponesVO> list = new ArrayList<>();
			while(rs.next()) {
				ResponesVO responesVO = new ResponesVO();
				responesVO.setRes_no(rs.getString("res_no"));
				responesVO.setPost_no(rs.getString("post_no"));
				responesVO.setMem_no(rs.getString("mem_no"));
				responesVO.setRes_content(rs.getString("res_content"));
				responesVO.setRes_date(rs.getTimestamp("res_date"));
				list.add(responesVO);
				
			}
			return list;
		}


		@Override
		public List<ResponesVO> getallfrompost(String post_no) {
			List<ResponesVO> list_respones = new ArrayList<ResponesVO>();
			ResponesVO responesVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT_FROM_POSTNO);
				pstmt.setString(1, post_no);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					responesVO = new ResponesVO();
					responesVO.setRes_no(rs.getString("res_no"));
					responesVO.setPost_no(rs.getString("post_no"));
					responesVO.setMem_no(rs.getString("mem_no"));
					responesVO.setRes_content(rs.getString("res_content"));
					responesVO.setRes_date(rs.getTimestamp("res_date"));
					list_respones.add(responesVO);
				
				}
			
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}
			return list_respones;
		}

		public void delete(String res_no,String mem_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);
				pstmt.setString(1, res_no);
				pstmt.setString(2, mem_no);
				pstmt.executeUpdate();
				
			
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}
		}


		@Override
		public void deleteBypostno(String post_no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE_BY_POST_NO);
				pstmt.setString(1, post_no);
				pstmt.executeUpdate();
				
			
			} catch (SQLException se) {
				throw new RuntimeException("A database error occured. "
						+ se.getMessage());
			}finally {
				if (rs != null) {
					try {
						rs.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException se) {
						se.printStackTrace(System.err);
					}
				}
			}
		}

}
		
		
	

