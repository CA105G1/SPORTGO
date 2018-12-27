package com.android.sg_info.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Sg_infoDAO_Android implements Sg_infoDAO_interface_Android{

	public Sg_infoDAO_Android(){

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
	
	private static final String INSERT = 
			"INSERT INTO sg_info VALUES('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, ?, ?, ?, ?)";
	private static final String UPDATE =
			"UPDATE sg_info SET mem_no=?, sg_name=?, sg_date=?, apl_start=?, apl_end=?, sg_fee=?, sg_per=?, sp_no=?, v_no=?, sg_maxno=?, sg_minno=?, sg_ttlapl=?, sg_extrainfo=?, loc_start_lat=?, loc_start_lng=?, loc_end_lat=?, loc_end_lng=? WHERE sg_no=?";
			//sg_chkno, sg_status還沒設定進去，mem_no不能改
	private static final String DELETE =
			"DELETE FROM sg_info WHERE sg_no=?";
	private static final String FIND_BY_SP =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME FROM sg_info SG LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SG.SP_NO=?";
	private static final String GET_ALL =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME FROM sg_info SG LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO ORDER BY SG_NO";
	private static final String GET_IMAGE =
			"SELECT SG_PIC FROM SG_INFO WHERE SG_NO = ?";
	
	

	@Override
	public void insert(Sg_infoVO_Android Sg_infoVO_Android) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, Sg_infoVO_Android.getMem_no());
			pstmt.setString(2, Sg_infoVO_Android.getSg_name());
			pstmt.setTimestamp(3, Sg_infoVO_Android.getSg_date());
			pstmt.setTimestamp(4, Sg_infoVO_Android.getApl_start());
			pstmt.setTimestamp(5, Sg_infoVO_Android.getApl_end());
			pstmt.setInt(6, Sg_infoVO_Android.getSg_fee());
			pstmt.setString(9, Sg_infoVO_Android.getSg_per());
			pstmt.setString(10, Sg_infoVO_Android.getSp_no());
			pstmt.setString(11, Sg_infoVO_Android.getV_no());
			pstmt.setInt(12, Sg_infoVO_Android.getSg_maxno());
			pstmt.setInt(13, Sg_infoVO_Android.getSg_minno());
			pstmt.setInt(14, Sg_infoVO_Android.getSg_ttlapl());
			pstmt.setInt(15, Sg_infoVO_Android.getSg_chkno());
			pstmt.setString(16, Sg_infoVO_Android.getSg_extrainfo());
			pstmt.setDouble(17, Sg_infoVO_Android.getLoc_start_lat());
			pstmt.setDouble(18, Sg_infoVO_Android.getLoc_start_lng());
			pstmt.setDouble(19, Sg_infoVO_Android.getLoc_end_lat());
			pstmt.setDouble(20, Sg_infoVO_Android.getLoc_end_lng());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
	public void update(Sg_infoVO_Android Sg_infoVO_Android) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, Sg_infoVO_Android.getMem_no());
			pstmt.setString(2, Sg_infoVO_Android.getSg_name());
			pstmt.setTimestamp(3, Sg_infoVO_Android.getSg_date());
			pstmt.setTimestamp(4, Sg_infoVO_Android.getApl_start());
			pstmt.setTimestamp(5, Sg_infoVO_Android.getApl_end());
			pstmt.setInt(6, Sg_infoVO_Android.getSg_fee());
			pstmt.setString(9, Sg_infoVO_Android.getSg_per());
			pstmt.setString(10, Sg_infoVO_Android.getSp_no());
			pstmt.setString(11, Sg_infoVO_Android.getV_no());
			pstmt.setInt(12, Sg_infoVO_Android.getSg_maxno());
			pstmt.setInt(13, Sg_infoVO_Android.getSg_minno());
			pstmt.setInt(14, Sg_infoVO_Android.getSg_ttlapl());
			pstmt.setString(15, Sg_infoVO_Android.getSg_extrainfo());
			pstmt.setDouble(16, Sg_infoVO_Android.getLoc_start_lat());
			pstmt.setDouble(17, Sg_infoVO_Android.getLoc_start_lng());
			pstmt.setDouble(18, Sg_infoVO_Android.getLoc_end_lat());
			pstmt.setDouble(19, Sg_infoVO_Android.getLoc_end_lng());
			pstmt.setString(20, Sg_infoVO_Android.getSg_no());
			
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
	public void delete(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, sg_no);
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
	public List<Sg_info> findBySp(String sp_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		List<Sg_info> list = new ArrayList<Sg_info>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_SP);
			
			pstmt.setString(1, sp_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setApl_start(rs.getTimestamp("apl_start"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setSp_name(rs.getString("sp_name"));
				vo.setV_no(rs.getString("v_no"));
				vo.setV_name(rs.getString("v_name"));
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

	@Override
	public List<Sg_info> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		List<Sg_info> list = new ArrayList<Sg_info>();
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setApl_start(rs.getTimestamp("apl_start"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setSp_name(rs.getString("sp_name"));
				vo.setV_no(rs.getString("v_no"));
				vo.setV_name(rs.getString("v_name"));
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

	@Override
	public byte[] getImage(String sg_no) {
		byte[] sg_pic = null;
		Connection con = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			psmt = con.prepareStatement(GET_IMAGE);
			
			psmt.setString(1, sg_no);
			
			rs = psmt.executeQuery();
			
			if (rs.next()) {
				sg_pic = rs.getBytes(1);
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
		
		return sg_pic;
	}
}
