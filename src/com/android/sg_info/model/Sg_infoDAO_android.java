package com.android.sg_info.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class Sg_infoDAO_android implements Sg_infoDAO_interface_android{

	public Sg_infoDAO_android(){

	}
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/CA105G1DB");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}	
	
	private static final String INSERT = 
			"INSERT INTO sg_info VALUES('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, ?, ?)";
	private static final String UPDATE =
			"UPDATE sg_info SET mem_no=?, sg_name=?, sg_date=?, club_no=?, apl_end=?, sg_fee=?, sg_per=?, sp_no=?, v_no=?, sg_maxno=?, sg_minno=?, sg_ttlapl=?, sg_extrainfo=?, loc_start=?, loc_end=? WHERE sg_no=?";
	private static final String UPDATE_TTLAPL =
			"UPDATE SG_INFO SET SG_TTLAPL = ((SELECT SG_TTLAPL FROM SG_INFO WHERE SG_NO = ? ) + ?) WHERE SG_NO = ?";
	private static final String CANCEL =
			"UPDATE sg_info SET SG_STATUS = '解散'  WHERE sg_no=?";
	private static final String FIND_BY_SP =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM sg_info SG LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SG.SP_NO=? AND SG.APL_END > SYSDATE AND SG.SG_STATUS = '揪團中' ORDER BY SG.APL_END";
	private static final String FIND_BY_PK =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM sg_info SG LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SG.SG_NO=?";
	private static final String FIND_BY_MASTER =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM sg_info SG LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SG.MEM_NO=? AND SG.SG_STATUS != '解散'  ORDER BY SG.SG_DATE DESC"; //主辦的揪團
	private static final String FIND_BY_MEM =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM SG_MEM SGM LEFT JOIN SG_INFO SG ON SGM.SG_NO = SG.SG_NO LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SGM.MEM_NO = ? AND SG.SG_DATE > SYSDATE ORDER BY SG.SG_DATE"; //參加的揪團
	private static final String FIND_BY_LIKE =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM SG_INFO SG LEFT JOIN SG_LIKE SL ON SG.SG_NO = SL.SG_NO LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SL.MEM_NO = ? AND SG.SG_DATE > SYSDATE ORDER BY SG.SG_DATE"; //喜歡的揪團
	private static final String FIND_BY_HIS =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM SG_MEM SGM LEFT JOIN SG_INFO SG ON SGM.SG_NO = SG.SG_NO LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SGM.MEM_NO = ? AND SG.SG_DATE < SYSDATE ORDER BY SG.SG_DATE"; //找出活動時間過的會員揪團
	private static final String GET_ALL =
			"SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM sg_info SG LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO WHERE SG.APL_END > SYSDATE AND SG.SG_STATUS = '揪團中' ORDER BY SG.APL_END"; //找出所有揪團
	private static final String GET_IMAGE =
			"SELECT SG_PIC FROM SG_INFO WHERE SG_NO = ?";
	
	

	@Override
	public void insert(Sg_infoVO_android Sg_infoVO_android) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, Sg_infoVO_android.getMem_no());
			pstmt.setString(2, Sg_infoVO_android.getSg_name());
			pstmt.setTimestamp(3, Sg_infoVO_android.getSg_date());
			pstmt.setString(4, Sg_infoVO_android.getClub_no());
			pstmt.setTimestamp(5, Sg_infoVO_android.getApl_end());
			pstmt.setInt(6, Sg_infoVO_android.getSg_fee());
			pstmt.setString(9, Sg_infoVO_android.getSg_per());
			pstmt.setString(10, Sg_infoVO_android.getSp_no());
			pstmt.setString(11, Sg_infoVO_android.getV_no());
			pstmt.setInt(12, Sg_infoVO_android.getSg_maxno());
			pstmt.setInt(13, Sg_infoVO_android.getSg_minno());
			pstmt.setInt(14, Sg_infoVO_android.getSg_ttlapl());
			pstmt.setInt(15, Sg_infoVO_android.getSg_chkno());
			pstmt.setString(16, Sg_infoVO_android.getSg_extrainfo());
			pstmt.setString(17, Sg_infoVO_android.getLoc_start());
			pstmt.setString(18, Sg_infoVO_android.getLoc_end());
			
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
	public void update(Sg_infoVO_android Sg_infoVO_android) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, Sg_infoVO_android.getMem_no());
			pstmt.setString(2, Sg_infoVO_android.getSg_name());
			pstmt.setTimestamp(3, Sg_infoVO_android.getSg_date());
			pstmt.setString(4, Sg_infoVO_android.getClub_no());
			pstmt.setTimestamp(5, Sg_infoVO_android.getApl_end());
			pstmt.setInt(6, Sg_infoVO_android.getSg_fee());
			pstmt.setString(9, Sg_infoVO_android.getSg_per());
			pstmt.setString(10, Sg_infoVO_android.getSp_no());
			pstmt.setString(11, Sg_infoVO_android.getV_no());
			pstmt.setInt(12, Sg_infoVO_android.getSg_maxno());
			pstmt.setInt(13, Sg_infoVO_android.getSg_minno());
			pstmt.setInt(14, Sg_infoVO_android.getSg_ttlapl());
			pstmt.setString(15, Sg_infoVO_android.getSg_extrainfo());
			pstmt.setString(17, Sg_infoVO_android.getLoc_start());
			pstmt.setString(18, Sg_infoVO_android.getLoc_end());
			pstmt.setString(20, Sg_infoVO_android.getSg_no());
			
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
	public void updateNumber(String sg_no, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_TTLAPL);
			
			pstmt.setString(1, sg_no);
			pstmt.setInt(2, num);
			pstmt.setString(3, sg_no);
			
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
	public void cancel(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(CANCEL);
			
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
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
				
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
	public Sg_info findByPK(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK);
			
			pstmt.setString(1, sg_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
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
	public List<Sg_info> findByMem(String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		List<Sg_info> list = new ArrayList<Sg_info>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_MEM);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
				
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
	public List<Sg_info> findByMaster(String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		List<Sg_info> list = new ArrayList<Sg_info>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_MASTER);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
				
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
	public List<Sg_info> findByLike(String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		List<Sg_info> list = new ArrayList<Sg_info>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_LIKE);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
				
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
	public List<Sg_info> findByHistory(String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		List<Sg_info> list = new ArrayList<Sg_info>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_HIS);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
				
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
	public List<Sg_info> findBySearch(String mem_name, String v_name, String start, String end) {
		
		String time = "";
		
		if (!start.equals("") && !end.equals("")) {
			time = "Sg_Date between to_timestamp('" + start + "','yyyy-mm-dd hh24:mi:ss') and to_timestamp('" + end + "','yyyy-mm-dd hh24:mi:ss') and ";
		} else if (!start.equals("")) {
			time = "SG_DATE > to_timestamp('" + start + "','yyyy-mm-dd hh24:mi:ss') and ";
		} else if (!end.equals("")) {
			time = "SG_DATE < to_timestamp('" + end + "','yyyy-mm-dd hh24:mi:ss') and ";
		}
		
		Map<String, String[]> map = new TreeMap<String, String[]>();
		map.put("mem_name", new String[] { mem_name });
		map.put("v_name", new String[] { v_name });
		map.put("action", new String[] { "getXXX" });
		
		String finalSQL = "SELECT SG.*, SP.sp_name, V.V_Name, M.MEM_NAME , V.V_LAT, V.V_LONG FROM sg_info SG LEFT JOIN SPORT SP on SP.sp_no = SG.sp_no LEFT JOIN VENUE V ON V.V_NO = SG.V_NO LEFT JOIN MEMBERLIST M ON SG.MEM_NO = M.MEM_NO where "
		          + get_WhereCondition(map)
		          + time
		          + "SG.APL_END > SYSDATE ORDER BY SG.APL_END";
		
		System.out.println(finalSQL);
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_info vo = null;
		List<Sg_info> list = new ArrayList<Sg_info>();
			
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(finalSQL);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_info();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
				
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
				vo.setClub_no(rs.getString("club_no"));
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
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
				vo.setV_lat(rs.getDouble("v_lat"));
				vo.setV_long(rs.getDouble("v_long"));
				
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
	
	public static String get_aCondition_For_Oracle(String columnName, String value) {

		String aCondition = null;

		if ("sg_fee".equals(columnName)) // 用於其他
			aCondition = columnName + "=" + value;
		else if ("mem_name".equals(columnName) || "v_name".equals(columnName)) // 用於varchar
			aCondition = columnName + " like '%" + value + "%'";
		
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		for (String key : keys) {
			String value = map.get(key)[0];
			if (value != null && value.trim().length() != 0	&& !"action".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_Oracle(key, value.trim());

				if (count == 1)
					whereCondition.append(aCondition + " and ");
				else
					whereCondition.append(aCondition + " and ");

				System.out.println("有送出查詢資料的欄位數count = " + count);
			}
		}
		
		return whereCondition.toString();
	}

}
