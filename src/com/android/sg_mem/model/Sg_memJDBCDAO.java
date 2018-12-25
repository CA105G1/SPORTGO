package com.android.sg_mem.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Sg_memJDBCDAO implements Sg_memDAO_interface_Android{
	private static final String driver = "oracle.jdbc.driver.OracleDriver";
	private static final String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String user = "CA105G1";
	private static final String psw = "123456";
	
	private static final String INSERT = 
			"INSERT INTO sg_mem VALUES(?,?,default)";
	private static final String UPDATE =
			"UPDATE sg_mem SET ch_status=? where sg_no=? and mem_no=?";
	private static final String DELETE =
			"DELETE FROM sg_mem WHERE sg_no=? and mem_no=?";
	private static final String FIND_BY_SG =
			"SELECT SGM.* , SG_INFO.SG_NAME , M.MEM_NAME FROM SG_MEM SGM LEFT JOIN SG_INFO ON SGM.SG_NO = SG_INFO.SG_NO LEFT JOIN MEMBERLIST M ON SGM.MEM_NO = M.MEM_NO WHERE SGM.SG_NO = ? ORDER BY SGM.MEM_NO";

	
	//連線池版
//	private static DataSource ds = null;
//	
//	static {
//		try {
//			Context ctx = new javax.naming.InitialContext();
//			ds = (DataSource)ctx.lookup("java:comp/env/jdbc/TestDB");
//		} catch (NamingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	//JDBC版
	static {
		try {
			Class.forName(driver);
		}catch(ClassNotFoundException ce) {
			ce.printStackTrace();
		}
	}

	@Override
	public void insert(Sg_memVO_Android sg_memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(INSERT);
			
			pstmt.setString(1, sg_memVO.getSg_no());
			pstmt.setString(2, sg_memVO.getMem_no());
			
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
	public void update(Sg_memVO_Android sg_memVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, sg_memVO.getCh_status());
			pstmt.setString(2, sg_memVO.getSg_no());
			pstmt.setString(3, sg_memVO.getMem_no());
			
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
	public void delete(String sg_no, String mem_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			//連線池版
//		con = ds.getConnection();
			//JDBC版
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, sg_no);
			pstmt.setString(2, mem_no);
			
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
	public List<Sg_mem> findBySG(String sg_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Sg_mem vo = null;
		List<Sg_mem> sgmList = new ArrayList<>();
		
		try {
			
			con = DriverManager.getConnection(url, user, psw);
			pstmt = con.prepareStatement(FIND_BY_SG);
			
			pstmt.setString(1, sg_no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new Sg_mem();
				vo.setSg_no(rs.getString("sg_no"));
				vo.setSg_name("sg_name");
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

//	@Override
//	public List<Sg_mem> getAll() {
//		Connection con = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		Sg_mem vo = null;
//		List<Sg_mem> list = new ArrayList<Sg_mem>();;
//		
//		try {
//			//連線池版
////		con = ds.getConnection();
//			//JDBC版
//			con = DriverManager.getConnection(url, user, psw);
//			pstmt = con.prepareStatement(getAllStmt);
//			
//			rs = pstmt.executeQuery();
//			
//			while(rs.next()) {
//				vo = new Sg_memVO();
//				vo.setSg_no(rs.getString("sg_no"));
//				vo.setMem_no(rs.getString("mem_no"));
//				vo.setCh_status(rs.getString("ch_status"));
//				
//				list.add(vo);
//			}
//			
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}finally {
//			if(rs != null) {
//				try {
//					rs.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			}
//			if(pstmt != null) {
//				try {
//					pstmt.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			}
//			if(con != null) {
//				try {
//					con.close();
//				} catch (SQLException e) {
//					e.printStackTrace();
//				}
//			}
//		}
//		return list;
//	}

}
