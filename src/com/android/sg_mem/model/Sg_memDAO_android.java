package com.android.sg_mem.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Sg_memDAO_android implements Sg_memDAO_interface_android{
	
	private static final String INSERT = 
			"INSERT INTO sg_mem VALUES(?,?,default)";
	private static final String UPDATE =
			"UPDATE sg_mem SET ch_status= '已報到' where sg_no=? and mem_no=?";
	private static final String DELETE =
			"DELETE FROM SG_MEM WHERE SG_NO=? and MEM_NO=?";
	private static final String FIND_BY_SG =
			"SELECT SGM.* , SG.SG_NAME , M.MEM_NAME FROM SG_MEM SGM LEFT JOIN SG_INFO SG ON SGM.SG_NO = SG.SG_NO LEFT JOIN MEMBERLIST M ON SGM.MEM_NO = M.MEM_NO WHERE SGM.SG_NO =? ORDER BY SGM.MEM_NO";
	private static final String FIND_BY_MEM =
			"SELECT SGM.* , SG.SG_NAME , M.MEM_NAME FROM SG_MEM SGM LEFT JOIN SG_INFO SG ON SGM.SG_NO = SG.SG_NO LEFT JOIN MEMBERLIST M ON SGM.MEM_NO = M.MEM_NO WHERE SGM.MEM_NO =? ORDER BY SGM.SG_NO";

	private static DataSource ds = null;
	
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/CA105G1DB");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void insert(Sg_memVO_android sg_memVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, sg_memVO.getSg_no());
			pstmt.setString(2, sg_memVO.getMem_no());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			throw e;
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
	public void update(String sg_no, String mem_no) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, sg_no);
			pstmt.setString(2, mem_no);
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			throw e;
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
	public void delete(String sg_no, String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, sg_no);
			pstmt.setString(2, mem_no);
			
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
	public List<SGMember> findBySG(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<SGMember> sgmList = new ArrayList<>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_SG);
			
			pstmt.setString(1, sg_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SGMember vo = new SGMember();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setCh_status(rs.getString("ch_status"));
				
				sgmList.add(vo);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		return sgmList;
	}
	
	@Override
	public List<SGMember> findByMem(String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<SGMember> sgmList = new ArrayList<>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_MEM);
			
			pstmt.setString(1, mem_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SGMember vo = new SGMember();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setMem_name(rs.getString("mem_name"));
				vo.setCh_status(rs.getString("ch_status"));
				
				sgmList.add(vo);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		return sgmList;
	}

}
