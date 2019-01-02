package com.product.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.pro.controller.jdbcUtil_CompositeQuery_Pro;

public class ProductJDBCDAO implements ProductDAO_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INSERT = "Insert into PRODUCT (PRO_NO,PRO_CLASSID,PRO_NAME,PRO_PIC,PRO_PIC_EXT,PRO_FORMAT,PRO_BONUS,PRO_STOCK,PRO_SAFESTOCK,PRO_DETAILS,PRO_SHELVE,PRO_ALL_ASSESS,PRO_ALL_ASSESSMAN) values ('P'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 3, '0'),?,?,?,?,?,?,?,?,?,?,?,?)";
	//修改
	private static final String UPDATE = "UPDATE PRODUCT SET  PRO_CLASSID = ?, PRO_NAME = ?, PRO_PIC = ?, PRO_PIC_EXT = ?, PRO_FORMAT = ?, PRO_BONUS = ?, PRO_STOCK = ?, PRO_SAFESTOCK = ?, PRO_DETAILS = ?, PRO_SHELVE = ?, PRO_ALL_ASSESS = ?, PRO_ALL_ASSESSMAN = ? where PRO_NO = ?";
	//單筆查詢
	private static final String SELECT_FINDBYPK = "select * from product where pro_no = ?";
	//多筆查詢
	private static final String SELECT_ALL = "SELECT * FROM PRODUCT";
	//刪除
	private static final String DELETE_CHILDREN_PROM = "Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?";
	private static final String DELETE_CHILDREN_ORDDETAILS = "Delete FROM ORDDETAILS WHERE ORD_NO = ?";
	private static final String DELETE = "Delete FROM PRODUCT WHERE PRO_NO = ?";
	
	
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
		}
	}
	
	
	
	@Override  //新增
	public int insert(ProductVO proVO) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0 ;
		 try {
				con = DriverManager.getConnection(URL, USER, PASSWORD);
				
		        ps = con.prepareStatement(INSERT);
		        

		        
		        ps.setString(1,proVO.getPro_classid());
		        ps.setString(2, proVO.getPro_name());
		        ps.setBytes(3, proVO.getPro_pic());
		        ps.setString(4, proVO.getPro_pic_ext());
		        ps.setString(5, proVO.getPro_format());
		        ps.setInt(6, proVO.getPro_bonus());
                ps.setInt(7, proVO.getPro_stock());
		        ps.setInt (8,proVO.getPro_safestock());
		    	ps.setString (9,proVO.getPro_details());
		    	ps.setString (10,proVO.getPro_shelve());
		    	ps.setInt (11,proVO.getPro_all_assess());
		    	ps.setInt (12,proVO.getPro_all_assessman());
		    	

		        
		    	count = ps.executeUpdate();
		        
		    } catch (SQLException  e) {
				// TODO Auto-generated catch block
				throw new RuntimeException(e.getMessage());
				
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
    //更新
	@Override
	public int update(ProductVO proVO) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0;
		try {
			
			con = DriverManager.getConnection(URL, USER, PASSWORD);
		    ps = con.prepareStatement(UPDATE);
		    
		    
		    ps.setString(1,proVO.getPro_classid());
	        ps.setString(2, proVO.getPro_name());
	        ps.setBytes(3, proVO.getPro_pic());
	        ps.setString(4, proVO.getPro_pic_ext());
	        ps.setString(5, proVO.getPro_format());
	        ps.setInt(6, proVO.getPro_bonus());
            ps.setInt(7, proVO.getPro_stock());
	        ps.setInt (8,proVO.getPro_safestock());
	    	ps.setString (9,proVO.getPro_details());
	    	ps.setString (10,proVO.getPro_shelve());
	    	ps.setInt (11,proVO.getPro_all_assess());
	    	ps.setInt (12,proVO.getPro_all_assessman());
	    	ps.setString(13, proVO.getPro_no());
	    	
	    	count = ps.executeUpdate();
		    
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e.getMessage());
			
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
		public int delete( String pro_no) {
			Connection con = null;
			PreparedStatement ps = null;
			int count = 0;
			try {				
				con = DriverManager.getConnection(URL, USER, PASSWORD);
				ps = con.prepareStatement(DELETE);
				ps.setString(1, pro_no);
				count = ps.executeUpdate();
				
				
			} catch (SQLException  e) {
				// TODO Auto-generated catch block
				throw new RuntimeException(e.getMessage());
				
			} finally {
				if(ps != null) {
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
    //刪除  多筆刪除
	@Override
	public int delete(String ord_no ,String prom_project_id ,  String pro_no) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0;
//		ResultSet rs = null;
		try {
//			ps = con.prepareStatement(DELETE_CHILDREN_PROM);
//			ps.setString(1,prom_project_id );
//			ps.addBatch();	
//			
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
//			ps = con.prepareStatement(DELETE_CHILDREN_ORDDETAILS);
//			ps.setString(1,ord_no );
//			ps.addBatch();	
//			
//			ps = con.prepareStatement(DELETE_DATA);
//			ps.setString(1, pro_no);
//			ps.addBatch();
//			ps.executeBatch();
			
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(DELETE_CHILDREN_PROM);
			ps.setString(1,prom_project_id );
			ps.executeUpdate();
			
			ps = con.prepareStatement(DELETE_CHILDREN_ORDDETAILS);
			ps.setString(1,ord_no );
			ps.executeUpdate();

			ps = con.prepareStatement(DELETE);
			ps.setString(1, pro_no);
			count = ps.executeUpdate();
			
			
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e.getMessage());
			
		} finally {
			if(ps != null) {
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
    //全部查詢
	@Override
	public List<ProductVO> getAll() {
		List<ProductVO> proVOList = new ArrayList<>();
		ProductVO proVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_ALL);
		    rs = ps.executeQuery();
		    
		    while(rs.next()) {
		    	proVO = new ProductVO();
		    	proVO.setPro_no(rs.getString("PRO_NO"));
		    	proVO.setPro_classid(rs.getString("PRO_CLASSID"));
		    	proVO.setPro_name(rs.getString("PRO_NAME"));
		    	proVO.setPro_pic(rs.getBytes("PRO_PIC"));
		    	proVO.setPro_pic_ext(rs.getString("PRO_PIC_EXT"));
		    	proVO.setPro_format(rs.getString("PRO_FORMAT"));
		    	proVO.setPro_bonus(rs.getInt("PRO_BONUS"));
		    	proVO.setPro_stock(rs.getInt("PRO_STOCK"));
		    	proVO.setPro_safestock(rs.getInt("PRO_SAFESTOCK"));
		    	proVO.setPro_details(rs.getString("PRO_DETAILS"));
		    	proVO.setPro_shelve(rs.getString("PRO_SHELVE"));
		    	proVO.setPro_all_assess(rs.getInt("PRO_ALL_ASSESS"));
		    	proVO.setPro_all_assessman(rs.getInt("PRO_ALL_ASSESSMAN"));
		    	proVOList.add(proVO);
		    }
			
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e.getMessage());
			
		} finally {
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
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return proVOList;
	}
    //單次查詢
	@Override
	public ProductVO findByPK (String pro_no) {
		ProductVO proVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con =  DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK);
			
			ps.setString(1, pro_no);
			rs = ps.executeQuery();
		
			while (rs.next()) {
				proVO = new ProductVO();
				proVO.setPro_no(rs.getString("PRO_NO"));
				proVO.setPro_classid(rs.getString("PRO_CLASSID"));
				proVO.setPro_name(rs.getString("PRO_NAME"));
				proVO.setPro_pic(rs.getBytes("PRO_PIC"));
				proVO.setPro_pic_ext(rs.getString("PRO_PIC_EXT"));
				proVO.setPro_format(rs.getString("PRO_FORMAT"));
				proVO.setPro_bonus(rs.getInt("PRO_BONUS"));
				proVO.setPro_stock(rs.getInt("PRO_STOCK"));
				proVO.setPro_safestock(rs.getInt("PRO_SAFESTOCK"));
				proVO.setPro_details(rs.getString("PRO_DETAILS"));
				proVO.setPro_shelve(rs.getString("PRO_SHELVE"));
				proVO.setPro_all_assess(rs.getInt("PRO_ALL_ASSESS"));
				proVO.setPro_all_assessman(rs.getInt("PRO_ALL_ASSESSMAN"));
				
			}
			
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e.getMessage());
			
		} finally {
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
		
		return proVO;
	}
	
	//複合查詢
	@Override
	public List<ProductVO> getAll(Map<String, String[]> map) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO proVO = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con =  DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK);
			
			String finalSQL = "select * from product "
			          + jdbcUtil_CompositeQuery_Pro.get_WhereCondition(map)
			          + "order by pro_no";
			ps = con.prepareStatement(finalSQL);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				proVO = new ProductVO();
				proVO.setPro_no(rs.getString("PRO_NO"));
				proVO.setPro_classid(rs.getString("PRO_CLASSID"));
				proVO.setPro_name(rs.getString("PRO_NAME"));
				proVO.setPro_pic(rs.getBytes("PRO_PIC"));
				proVO.setPro_pic_ext(rs.getString("PRO_PIC_EXT"));
				proVO.setPro_format(rs.getString("PRO_FORMAT"));
				proVO.setPro_bonus(rs.getInt("PRO_BONUS"));
				proVO.setPro_stock(rs.getInt("PRO_STOCK"));
				proVO.setPro_safestock(rs.getInt("PRO_SAFESTOCK"));
				proVO.setPro_details(rs.getString("PRO_DETAILS"));
				proVO.setPro_shelve(rs.getString("PRO_SHELVE"));
				proVO.setPro_all_assess(rs.getInt("PRO_ALL_ASSESS"));
				proVO.setPro_all_assessman(rs.getInt("PRO_ALL_ASSESSMAN"));
				list.add(proVO);
			}
			
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
			throw new RuntimeException(e.getMessage());
			
		} finally {
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
		
		
		return list;
	}
	

	

	

}
