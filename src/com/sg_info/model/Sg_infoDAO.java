package com.sg_info.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Sg_infoDAO implements Sg_infoDAO_interface{
	
	private static final String insertStmt = 
			"INSERT INTO sg_info VALUES('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, ?, ?, ?, ?)";
	private static final String updateClientStmt =
			"UPDATE sg_info SET sg_name=?, sg_date=?, apl_start=?, apl_end=?, sg_fee=?, sg_pic=?, sg_pic_ext=?, sg_per=?, sport_no=?, venue_no=?, sg_maxno=?, sg_minno=?, sg_extrainfo=?, loc_start_lat=?, loc_start_lng=?, loc_end_lat=?, loc_end_lng=? WHERE sg_no=?";
	private static final String deleteStmt =
			"DELETE FROM sg_info WHERE sg_no=?";
	private static final String findByPkStmt =
			"SELECT * FROM sg_info WHERE sg_no=?";
	private static final String getAllStmt =
			"SELECT * FROM sg_info ORDER BY sg_no";
	
	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new javax.naming.InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/TestDB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void insert(Sg_infoVO sg_infoVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Sg_infoVO sg_infoVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(deleteStmt);
			
			pstmt.setString(1, sg_no);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
	public Sg_infoVO findByPk(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_infoVO vo = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(findByPkStmt);
			
			pstmt.setString(1, sg_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo.setSg_no(sg_no);
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setApl_start(rs.getTimestamp("apl_start"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSport_no(rs.getString("sport_no"));
				vo.setVenue_no(rs.getString("venue_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start_lat(rs.getDouble("loc_start_lat"));
				vo.setLoc_start_lng(rs.getDouble("loc_start_lng"));
				vo.setLoc_end_lat(rs.getDouble("loc_end_lat"));
				vo.setLoc_end_lng(rs.getDouble("loc_end_lng"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
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
	public List<Sg_infoVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_infoVO vo = null;
		List<Sg_infoVO> list = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(getAllStmt);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setApl_start(rs.getTimestamp("apl_start"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSport_no(rs.getString("sport_no"));
				vo.setVenue_no(rs.getString("venue_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start_lat(rs.getDouble("loc_start_lat"));
				vo.setLoc_start_lng(rs.getDouble("loc_start_lng"));
				vo.setLoc_end_lat(rs.getDouble("loc_end_lat"));
				vo.setLoc_end_lng(rs.getDouble("loc_end_lng"));
				list.add(vo);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
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
