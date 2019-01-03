package com.android.sport.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class SportDAO_Android implements SportDAO_interface_Android{

	private static final String insertStmt =
			"INSERT INTO sport VALUES('SP' || LPAD(SPORT_SEQ.nextval, 3, 0), ?)";
	private static final String updateName =
			"UPDATE sport SET sp_name=? where sp_no=?";
	private static final String deleteStmt =
			"DELETE FROM sport WHERE sp_no=?";
	private static final String findByPkStmt =
			"SELECT * FROM sport WHERE sp_no=?";
	private static final String getAllStmt =
			"SELECT * FROM sport ORDER BY sp_no";
	
	//連線池版
	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new javax.naming.InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/CA105G1DB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}	
	
	@Override
	public void insert(SportVO_Android sportVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			pstmt = con.prepareStatement(insertStmt);
			
			pstmt.setString(1, sportVO.getSp_name());
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(SportVO_Android sportVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			pstmt = con.prepareStatement(updateName);
			
			pstmt.setString(1, sportVO.getSp_name());
			pstmt.setString(2, sportVO.getSp_no());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public void delete(String sp_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			pstmt = con.prepareStatement(deleteStmt);
			
			pstmt.setString(1, sp_no);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public SportVO_Android findByPk(String sp_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SportVO_Android vo = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			pstmt = con.prepareStatement(findByPkStmt);
			
			pstmt.setString(1, sp_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new SportVO_Android();
				vo.setSp_no(rs.getString("sp_no"));
				vo.setSp_name(rs.getString("sp_name"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return vo;
	}

	@Override
	public List<SportVO_Android> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		SportVO_Android vo = null;
		List<SportVO_Android> list = new ArrayList<SportVO_Android>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(getAllStmt);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new SportVO_Android();
				vo.setSp_no(rs.getString("sp_no"));
				vo.setSp_name(rs.getString("sp_name"));
				
				list.add(vo);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return list;
	}

}
