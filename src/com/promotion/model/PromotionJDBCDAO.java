package com.promotion.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionJDBCDAO implements PromotionDAO_interface{
	
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "test";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INSERT = "Insert into PROMOTION (PROM_PROJECT_ID,PROM_PROJECT_NAME,PROM_PROJECT_SDATE,PROM_PROJECT_EDATE) values ('PR'||LPAD(to_char(PROMOTION_SEQ.NEXTVAL), 3, '0'),?,?,?)";
	//修改
	private static final String UPDATE = "update PROMOTION SET  PROM_PROJECT_NAME = ? , PROM_PROJECT_SDATE = ? ,  PROM_PROJECT_EDATE = ? WHERE PROM_PROJECT_ID = ?";
	//刪除
	private static final String DELETE_PROM_DET = "Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?";
	private static final String DELETE_PROM = "Delete FROM PROMOTION WHERE PROM_PROJECT_ID = ?";
	//單筆查詢
	private static final String SELECT_FINDBYPK = "SELECT * FROM PROMOTION WHERE PROM_PROJECT_ID = ?";
	//全部查詢
	private static final String SELECT_ALL = "SELECT * FROM PROMOTION ";
	
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
    //新增
	@Override
	public int insert(PromotionVO promotionVO) {
		int count = 0;
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
		    ps = con.prepareStatement(INSERT);
		    
		    ps.setString(1, promotionVO.getProm_project_name());
		    ps.setTimestamp(2, promotionVO.getProm_project_sdate());
		    ps.setTimestamp(3, promotionVO.getProm_project_edate());
		    
		    count = ps.executeUpdate();
		    
		} catch (SQLException e) {		
			e.printStackTrace();
		} finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return count;
	}

	//修改
	@Override
	public int updata(PromotionVO promotionVO) {
		int count = 0 ;
		Connection con = null;
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(UPDATE);
			
			ps.setString(1, promotionVO.getProm_project_name());
			ps.setTimestamp(2, promotionVO.getProm_project_sdate());
			ps.setTimestamp(3, promotionVO.getProm_project_edate());
			ps.setString(4, promotionVO.getProm_project_id());
			
			count = ps.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return count;
	}

	//刪除
	@Override
	public int detele(String prom_project_id) {
		int count = 0;
		Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(DELETE_PROM_DET);
			ps.setString(1, prom_project_id);
		    ps.executeUpdate();
			
		    ps = con.prepareStatement(DELETE_PROM);
		    ps.setString(1, prom_project_id);
		    count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return count;
	}
    //單筆查詢
	@Override
	public PromotionVO findByPK(String prom_project_id) {
		PromotionVO promotionVO = null;
		Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK);
			ps.setString(1, prom_project_id);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				promotionVO = new PromotionVO();
                promotionVO.setProm_project_id(rs.getString("PROM_PROJECT_ID"));
                promotionVO.setProm_project_name(rs.getString("PROM_PROJECT_NAME"));
                promotionVO.setProm_project_sdate(rs.getTimestamp("PROM_PROJECT_SDATE"));
                promotionVO.setProm_project_edate(rs.getTimestamp("PROM_PROJECT_EDATE"));
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return promotionVO;
	}

	@Override
	public List<PromotionVO> getAll() {
		List<PromotionVO> promotionVOList = new ArrayList();
		Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_ALL);
			rs = ps.executeQuery();
		
		    while(rs.next()) {
		    	PromotionVO promotionVO = new PromotionVO();
		    	promotionVO.setProm_project_id(rs.getString("PROM_PROJECT_ID"));
		    	promotionVO.setProm_project_name(rs.getString("PROM_PROJECT_NAME"));
		    	promotionVO.setProm_project_sdate(rs.getTimestamp("PROM_PROJECT_SDATE"));
		    	promotionVO.setProm_project_edate(rs.getTimestamp("PROM_PROJECT_EDATE"));
		    	promotionVOList.add(promotionVO);
		    }
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return promotionVOList;
	}

}
