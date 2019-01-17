package com.sg_info.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Sg_infoDAO implements Sg_infoDAO_interface{
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String user = "CA105G1";
	private static final String psw = "123456";
	
	private static final String insertStmt = 
			"INSERT INTO sg_info VALUES('S' || LPAD(SG_INFO_SEQ.nextval, 3, 0), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, default, ?, ?)";
	private static final String updateClientStmt =
			"UPDATE sg_info SET mem_no=?, sg_name=?, sg_date=?, club_no=?, apl_end=?, sg_fee=?, sg_pic=?, sg_pic_ext=?, sg_per=?, sp_no=?, v_no=?, sg_maxno=?, sg_minno=?, sg_extrainfo=?, loc_start=?, loc_end=? WHERE sg_no=?";
			//sg_chkno, sg_status還沒設定進去，mem_no不能改
	private static final String updateStatusStmt = 
			"UPDATE sg_info SET sg_status=? WHERE sg_no=?";
	private static final String updateTtlaplStmt =
			"UPDATE sg_info SET sg_ttlapl=? WHERE sg_no=?";
	private static final String deleteStmt =
			"DELETE FROM sg_info WHERE sg_no=?";
	private static final String findByPkStmt =
			"SELECT * FROM sg_info WHERE sg_no=?";
	private static final String getAllStmt =
			"SELECT * FROM sg_info ORDER BY sg_date DESC";
	private static final String getAllForPublic =
			"SELECT * FROM sg_info WHERE (sg_status='揪團中' or sg_status='成團' or sg_status='流團') AND sg_per='公開' ORDER BY sg_date DESC";
	private static final String getAllForClub =
			"SELECT * FROM sg_info WHERE (sg_status='揪團中' or sg_status='成團' or sg_status='流團') AND sg_per='限社團' AND club_no=? ORDER BY sg_date DESC";
	
	
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
//	static {
//		try {
//			Class.forName(driver);
//		}catch(ClassNotFoundException ce) {
//			ce.printStackTrace();
//		}
//	}
	
	

	@Override
	public void insert(Sg_infoVO sg_infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			//JDBC版
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(insertStmt);
			
			pstmt.setString(1, sg_infoVO.getMem_no());
			pstmt.setString(2, sg_infoVO.getSg_name());
			pstmt.setTimestamp(3, sg_infoVO.getSg_date());
			pstmt.setString(4, sg_infoVO.getClub_no());
			pstmt.setTimestamp(5, sg_infoVO.getApl_end());
			pstmt.setInt(6, sg_infoVO.getSg_fee());
			pstmt.setBytes(7, sg_infoVO.getSg_pic());
			pstmt.setString(8, sg_infoVO.getSg_pic_ext());
			pstmt.setString(9, sg_infoVO.getSg_per());
			pstmt.setString(10, sg_infoVO.getSp_no());
			pstmt.setString(11, sg_infoVO.getV_no());
			pstmt.setInt(12, sg_infoVO.getSg_maxno());
			pstmt.setInt(13, sg_infoVO.getSg_minno());
			pstmt.setInt(14, sg_infoVO.getSg_ttlapl());
			pstmt.setInt(15, sg_infoVO.getSg_chkno());
			pstmt.setString(16, sg_infoVO.getSg_extrainfo());
			pstmt.setString(17, sg_infoVO.getLoc_start());
			pstmt.setString(18, sg_infoVO.getLoc_end());
			
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
	public void update(Sg_infoVO sg_infoVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(updateClientStmt);
			
			pstmt.setString(1, sg_infoVO.getMem_no());
			pstmt.setString(2, sg_infoVO.getSg_name());
			pstmt.setTimestamp(3, sg_infoVO.getSg_date());
			pstmt.setString(4, sg_infoVO.getClub_no());
			pstmt.setTimestamp(5, sg_infoVO.getApl_end());
			pstmt.setInt(6, sg_infoVO.getSg_fee());
			pstmt.setBytes(7, sg_infoVO.getSg_pic());
			pstmt.setString(8, sg_infoVO.getSg_pic_ext());
			pstmt.setString(9, sg_infoVO.getSg_per());
			pstmt.setString(10, sg_infoVO.getSp_no());
			pstmt.setString(11, sg_infoVO.getV_no());
			pstmt.setInt(12, sg_infoVO.getSg_maxno());
			pstmt.setInt(13, sg_infoVO.getSg_minno());
			pstmt.setString(14, sg_infoVO.getSg_extrainfo());
			pstmt.setString(15, sg_infoVO.getLoc_start());
			pstmt.setString(16, sg_infoVO.getLoc_end());
			pstmt.setString(17, sg_infoVO.getSg_no());
			
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
	public void delete(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
//			con = DriverManager.getConnection(url, user, psw);
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
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(findByPkStmt);
			
			pstmt.setString(1, sg_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_infoVO();
				vo.setSg_no(sg_no);
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setV_no(rs.getString("v_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));
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
		List<Sg_infoVO> list = new ArrayList<Sg_infoVO>();
		
		try {
			con = ds.getConnection();
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(getAllStmt);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_infoVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setV_no(rs.getString("v_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));

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

	@Override
	public List<Sg_infoVO> getAll(Map<String, String[]> map) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_infoVO vo = null;
		List<Sg_infoVO> list = new ArrayList<Sg_infoVO>();
		
		try {
			con = ds.getConnection();
//			con = DriverManager.getConnection(url, user, psw);
			String sqlStr = "SELECT * FROM (select * from sg_info left outer join venue on sg_info.v_no = venue.v_no) sgV left outer join region on sgV.reg_no = region.reg_no "
			+ "WHERE (sgV.sg_status='揪團中' or sgV.sg_status='成團' or sgV.sg_status='流團')" + CompositeQuery_Sg_info.get_WhereCondition(map)
			+ " ORDER BY sgV.sg_date DESC";
System.out.println("sqlStr="+sqlStr);
			pstmt = con.prepareStatement(sqlStr);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_infoVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setV_no(rs.getString("v_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));

				list.add(vo);
			}
			
			
			
		}catch(Exception e) {
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

	@Override
	public void updateStatus(String sg_no, String sg_status) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(updateStatusStmt);
			
			pstmt.setString(1, sg_status);
			pstmt.setString(2, sg_no);
			pstmt.executeUpdate();
			
		}catch (SQLException e) {
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
	public void updateTtlapl(String sg_no, Integer sg_ttlapl) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(updateTtlaplStmt);
			
			pstmt.setInt(1, sg_ttlapl);
			pstmt.setString(2, sg_no);
			pstmt.executeUpdate();
			
		}catch (SQLException e) {
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
	
	
	public List<Sg_infoVO> getAllForPublic() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_infoVO vo = null;
		List<Sg_infoVO> list = new ArrayList<Sg_infoVO>();
		
		try {
			con = ds.getConnection();
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(getAllForPublic);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_infoVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setV_no(rs.getString("v_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));

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

	@Override
	public List<Sg_infoVO> getAllForClub(String club_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_infoVO vo = null;
		List<Sg_infoVO> list = new ArrayList<Sg_infoVO>();
		
		try {
			con = ds.getConnection();
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(getAllForClub);
			pstmt.setString(1, club_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_infoVO();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setSg_date(rs.getTimestamp("sg_date"));
				vo.setClub_no(rs.getString("club_no"));
				vo.setApl_end(rs.getTimestamp("apl_end"));
				vo.setSg_fee(rs.getInt("sg_fee"));
				vo.setSg_pic(rs.getBytes("sg_pic"));
				vo.setSg_pic_ext(rs.getString("sg_pic_ext"));
				vo.setSg_per(rs.getString("sg_per"));
				vo.setSp_no(rs.getString("sp_no"));
				vo.setV_no(rs.getString("v_no"));
				vo.setSg_maxno(rs.getInt("sg_maxno"));
				vo.setSg_minno(rs.getInt("sg_minno"));
				vo.setSg_ttlapl(rs.getInt("sg_ttlapl"));
				vo.setSg_chkno(rs.getInt("sg_chkno"));
				vo.setSg_extrainfo(rs.getString("sg_extrainfo"));
				vo.setSg_status(rs.getString("sg_status"));
				vo.setLoc_start(rs.getString("loc_start"));
				vo.setLoc_end(rs.getString("loc_end"));

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
