package com.android.sg_rep.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class Sg_repDAO_android implements Sg_repDAO_interface_android{
	
//	private static final String driver = "oracle.jdbc.driver.OracleDriver";
//	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
//	private static final String user = "CA105G1";
//	private static final String psw = "123456";
	
	private static final String INSERT =
			"INSERT INTO sg_rep VALUES('REP' || LPAD(SG_REP_SEQ.nextval, 3, 0), ?,?,?,?,default)";
	private static final String UPDATE =
			"UPDATE sg_rep SET rep_status=? where rep_no=?";
	private static final String DELETE =
			"DELETE FROM sg_rep WHERE rep_no=?";
	private static final String FIND_BY_MEM =
			"SELECT * FROM sg_rep WHERE mem_no=?";
	private static final String GET_ALL =
			"SELECT * FROM sg_rep ORDER BY rep_no";
	
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
	
	//JDBC版
//	static {
//		try {
//			Class.forName(driver);
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		}
//	}
	

	@Override
	public void insert(Sg_repVO_android sg_repVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			//JDBC版
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, sg_repVO.getSg_no());
			pstmt.setString(2, sg_repVO.getMem_no());
			pstmt.setString(3, sg_repVO.getRep_type());
			pstmt.setString(4, sg_repVO.getRep_cont());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					throw e;
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
	public void update(Sg_repVO_android sg_repVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			//JDBC版
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, sg_repVO.getRep_status());
			pstmt.setString(2, sg_repVO.getRep_no());
			
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
	public void delete(String rep_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			//JDBC版
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, rep_no);
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
	public List<Sg_rep> findByMem(String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Sg_rep> list = new ArrayList<>();
		Sg_rep vo = null;
		
		try {
			//連線池版
			con = ds.getConnection();
			//JDBC版
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(FIND_BY_MEM);
			
			pstmt.setString(1, mem_no);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_rep();
				vo.setRep_no(rs.getString("rep_no"));
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setRep_type(rs.getString("rep_type"));
				vo.setRep_cont(rs.getString("rep_cont"));
				vo.setRep_status(rs.getString("rep_status"));
				
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
	public List<Sg_rep> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_rep vo = null;
		List<Sg_rep> list = new ArrayList<Sg_rep>();
		
		try {
			con = ds.getConnection();
//			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_rep();
				vo.setRep_no(rs.getString("rep_no"));
				vo.setSg_no(rs.getString("sg_no"));
				vo.setMem_no(rs.getString("mem_no"));
				vo.setRep_type(rs.getString("rep_type"));
				vo.setRep_cont(rs.getString("rep_cont"));
				vo.setRep_status(rs.getString("rep_status"));
				vo.setSg_name(rs.getString("sg_name"));
				vo.setMem_name(rs.getString("mem_name"));
				
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
