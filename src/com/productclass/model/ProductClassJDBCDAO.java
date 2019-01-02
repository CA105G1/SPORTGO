package com.productclass.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductClassJDBCDAO implements ProductClassDAO_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INSERT = "Insert into PRODUCTCLASS(PRO_CLASSID,PRO_CLASSNAME) values ('PT'||LPAD(to_char(PRODUCTCLASS_SEQ.NEXTVAL), 3, '0'),?)";
	//修改
	private static final String UPDATE = "UPDATE PRODUCTCLASS SET PRO_CLASSNAME = ? WHERE PRO_CLASSID = ?";
	//刪除
	private static final String DELETE_CHILDREN_PROM = "Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?";
	private static final String DELETE_CHILDREN_ORDDETAILS = "Delete FROM ORDDETAILS WHERE ORD_NO = ?";
	private static final String DELETE_CHILDREN_PRODUCT = "Delete From PRODUCT where PRO_NO = ?";
	private static final String DELETE = "Delete FROM PRODUCTCLASS WHERE PRO_CLASSID = ?";
	//單筆查詢
	private static final String SELECT_FINDBYPK = "SELECT * FROM PRODUCTCLASS WHERE PRO_CLASSID = ?";
	//全部查詢
	private static final String SELECT_ALL = "SELECT * FROM PRODUCTCLASS ";
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	//新增
	@Override  
	public int insert(ProductClassVO productClassVO) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(INSERT);
			ps.setString(1, productClassVO.getPro_classname());
			count = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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

    //修改
	@Override
	public int update(ProductClassVO productClassVO) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0 ;
		
		try {	
		con = DriverManager.getConnection(URL, USER, PASSWORD);
		ps = con.prepareStatement(UPDATE);
		ps.setString(1, productClassVO.getPro_classname());
		ps.setString(2, productClassVO.getPro_classid());
		count = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
	
	//刪除
		@Override
		public int delete(String pro_classid) {
			Connection con = null;
			PreparedStatement ps = null;
			int count = 0;
			
			try {
				con = DriverManager.getConnection(URL, USER, PASSWORD);
				ps = con.prepareStatement(DELETE);
				ps.setString(1,pro_classid );
				count = ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
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
			return count ;
		}

    //刪除 多筆刪除
	@Override
	public int delete(String prom_project_id , String ord_no , String pro_no , String pro_classid) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0;
		
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(DELETE_CHILDREN_PROM);
			ps.setString(1,prom_project_id );
			ps.executeUpdate();
			
			ps = con.prepareStatement(DELETE_CHILDREN_ORDDETAILS);
			ps.setString(1, ord_no);
			ps.executeUpdate();
			
			ps = con.prepareStatement(DELETE_CHILDREN_PRODUCT);
			ps.setString(1, pro_no);
			ps.executeUpdate();
			
			ps = con.prepareStatement(DELETE);
			ps.setString(1, pro_classid);
			count = ps.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		return count ;
	}

    //單筆查詢
	@Override
	public ProductClassVO findByPK(String pro_classid) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ProductClassVO productClassVO = null;
		
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK);
			ps.setString(1, pro_classid);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				productClassVO = new ProductClassVO();
				productClassVO.setPro_classid(rs.getString("PRO_CLASSID"));
				productClassVO.setPro_classname(rs.getString("PRO_CLASSNAME"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		return productClassVO;
	}

    //全部查詢
	@Override
	public List<ProductClassVO> getAll() {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ProductClassVO productClassVO = null;
		List<ProductClassVO> productClassList = new ArrayList();
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_ALL);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				productClassVO = new ProductClassVO();
				productClassVO.setPro_classid(rs.getString("PRO_CLASSID"));
				productClassVO.setPro_classname(rs.getString("PRO_CLASSNAME"));
				productClassList.add(productClassVO);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		return productClassList;
	}
	
	

}
