package com.pro_detail_prom.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class Pro_detail_promJDBCDAO implements Pro_detail_prom_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "test";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INSERT = "Insert into PRO_DETAIL_PROM(PROM_PROJECT_ID,PRO_NO,PRO_SALE) values (?,?,?)";
	//修改
	private static final String UPDATE = "UPDATE PRO_DETAIL_PROM SET PROM_PROJECT_ID = ? ,PRO_NO = ? ,PRO_SALE = ? WHERE PROM_PROJECT_ID = ?";
	//刪除
	private static final String DELETE = "Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?";
	//單筆查詢以促銷專案編號
	private static final String SELECT_FINDBYPK_PROM = "SELECT * FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?";
	//單筆查詢以商品編號
	private static final String SELECT_FINDBYPK_PRO = "SELECT * FROM PRO_DETAIL_PROM WHERE PRO_NO = ?";
	//全部查詢
	private static final String SELECT_ALL = "SELECT * FROM PRO_DETAIL_PROM";
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//新增
	@Override
	public int insert(Pro_detail_promVO pro_detail_promVO) {
		int count = 0;
		Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(INSERT);
			
			ps.setString(1, pro_detail_promVO.getProm_project_id());
			ps.setString(2, pro_detail_promVO.getPro_no());
			ps.setInt(3, pro_detail_promVO.getPro_sale());
			
			count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
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
    //更新
	@Override
	public int updata(Pro_detail_promVO pro_detail_promVO) {
		int count = 0;
		Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(UPDATE);
			
			ps.setString(1, pro_detail_promVO.getProm_project_id());
			ps.setString(2, pro_detail_promVO.getPro_no());
			ps.setInt(3, pro_detail_promVO.getPro_sale());
			ps.setString(4, pro_detail_promVO.getProm_project_id());
			
			count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
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
	public int delete(String prom_project_id) {
		int count = 0;
        Connection con = null; 
		PreparedStatement ps = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(DELETE);
			
			ps.setString(1, prom_project_id);		    
		    count = ps.executeUpdate();
		    
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally { 
			if (ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (con != null) {
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
    //單筆查詢以促銷專案編號
	@Override
	public Pro_detail_promVO findByPK(String prom_project_id) {
		Pro_detail_promVO pro_detail_promVO = null;
        Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK_PROM);
			ps.setString(1, prom_project_id);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				pro_detail_promVO = new Pro_detail_promVO();
				pro_detail_promVO.setProm_project_id(rs.getString("PROM_PROJECT_ID"));
				pro_detail_promVO.setPro_no(rs.getString("PRO_NO"));
				pro_detail_promVO.setPro_sale(rs.getInt("PRO_SALE"));
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
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
		return pro_detail_promVO;
	}
    //全部查詢
	@Override
	public List<Pro_detail_promVO> getAll() {
		List<Pro_detail_promVO> pro_detail_promVOList = new ArrayList();
        Connection con = null; 
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_ALL);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				Pro_detail_promVO pro_detail_promVO = new Pro_detail_promVO();
				pro_detail_promVO.setProm_project_id(rs.getString("PROM_PROJECT_ID"));
				pro_detail_promVO.setPro_no(rs.getString("PRO_NO"));
				pro_detail_promVO.setPro_sale(rs.getInt("PRO_SALE"));
				pro_detail_promVOList.add(pro_detail_promVO);
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			if(rs != null) {
				try {
					rs.close();
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
		return pro_detail_promVOList;
	}

}
