package com.product.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.pro.controller.jdbcUtil_CompositeQuery_Pro;
import com.pro.controller.jdbcUtil_CompositeQuery_Pro_Back;

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
	//更新狀態
	private static final String UPDATE_PRO_SHELVE = "UPDATE PRODUCT SET   PRO_SHELVE = ? WHERE PRO_NO = ?";
	//查詢全部上架商品
	private static final String SELECT_SHELVE = "SELECT * FROM PRODUCT WHERE PRO_SHELVE = ? and pro_stock > 0";
	//訂單購買數量更動商品庫存
	private static final String UPDATE_STOCK = "UPDATE PRODUCT SET  PRO_STOCK = (PRO_STOCK-?) where PRO_NO = ?";
	//查詢購物車購買數量時庫存數量
	private static final String SELECT_STOCK = "SELECT PRO_NO,PRO_CLASSID,PRO_NAME,PRO_PIC,PRO_PIC_EXT,PRO_FORMAT,PRO_BONUS,pro_stock ?,PRO_SAFESTOCK,PRO_DETAILS,PRO_SHELVE,PRO_ALL_ASSESS,PRO_ALL_ASSESSMAN from product where pro_no = ?";
	//更新評價分數
	private static final String UPDATE_ASSESS = "UPDATE PRODUCT SET   PRO_ALL_ASSESS = PRO_ALL_ASSESS + ?,PRO_ALL_ASSESSMAN = PRO_ALL_ASSESSMAN +1 WHERE PRO_NO = ?";
	//查詢全部商品除後評價
	private static final String SELECT_ASSESS = "SELECT ROWNUM ,TOTASS.* FROM (SELECT PRO_NO,PRO_BONUS,PRO_PIC, NVL(trunc(PRO_ALL_ASSESS /NULLIF(PRO_ALL_ASSESSMAN,0)),0) AS PRO_TRUNC_ASSESS FROM PRODUCT WHERE PRO_SHELVE = '上架中' order by pro_trunc_assess desc ) TOTASS WHERE ROWNUM <=4";
    //查詢全部商品除後評價(類別查詢)
	private static final String SELECT_ASSESSLIKE = "SELECT ROWNUM ,TOTASS.* FROM (SELECT PRO_NO,PRO_BONUS,PRO_PIC, NVL(trunc(PRO_ALL_ASSESS /NULLIF(PRO_ALL_ASSESSMAN,0)),0) AS PRO_TRUNC_ASSESS FROM PRODUCT WHERE PRO_CLASSID = ? order by pro_trunc_assess desc ) TOTASS WHERE ROWNUM <=4";
	
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
	//JDBC版本
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
			    //連線池
			    con = ds.getConnection();
			    //JDBC版
//				con = DriverManager.getConnection(URL, USER, PASSWORD);
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
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
			    //連線池
			    con = ds.getConnection();
			    //JDBC版
//				con = DriverManager.getConnection(URL, USER, PASSWORD);
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
			
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
			
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
//			con.commit();//測試
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
//			throw new RuntimeException(e.getMessage());
			e.printStackTrace();
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
	
	//複合查詢前端
	@Override
	public List<ProductVO> getAll(Map<String, String[]> map) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO proVO = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
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
	//複合查詢後端
	@Override
	public List<ProductVO> getAll_back(Map<String, String[]> map) {
		List<ProductVO> list = new ArrayList<ProductVO>();
		ProductVO proVO = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK);
			
			String finalSQL = "select * from product "
			          + jdbcUtil_CompositeQuery_Pro_Back.get_WhereCondition(map)
			          + "order by pro_no"; 
			System.out.println(finalSQL);
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
	//更新狀態
	@Override
	public int updateShelve(String pro_no, String pro_shelve) {
		Connection con = null; 
		PreparedStatement ps = null;
		int count = 0;
		
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(UPDATE_PRO_SHELVE);
			System.out.println(pro_no + ":" +pro_shelve);
			ps.setString(1, pro_shelve);
			ps.setString(2, pro_no);
			count = ps.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
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
	
	//查詢最後一筆
	@Override
	public ProductVO getLastVO() {
		ProductVO proVO = null;
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			stmt = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			rs = stmt.executeQuery(SELECT_ALL);
			rs.last();

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
				

//			con.commit();//測試
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
			if(stmt != null) {
				try {
					stmt.close();
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
	
	//查詢全部上架商品
	@Override
	public List<ProductVO> getAllOnShelve() {
		List<ProductVO> proVOList = new ArrayList<>();
		ProductVO proVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_SHELVE);
			ps.setString(1,"上架中");
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
	//訂單購買數量更動商品庫存
	@Override
	public int updateStock(String pro_no, Integer cart_pro_stock) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0;
		ProductService proSvc = new ProductService();
		try {
			 
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
		    ps = con.prepareStatement(UPDATE_STOCK);
//		    Integer pro_stock = proSvc.getProductStock(pro_no, cart_pro_stock).getPro_stock();
//		    System.out.println(pro_stock);
		    ps.setInt(1,cart_pro_stock);
	        ps.setString(2, pro_no);
	       
	    	
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
	//查詢購物車購買數量時庫存數量
	@Override
	public ProductVO getSelectStock(String pro_no, Integer cart_pro_stock) {
		ProductVO proVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELECT_FINDBYPK);
//			int count = cart_pro_stock.intValue();
//			ps.setInt(1, cart_pro_stock);
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
				proVO.setPro_stock(rs.getInt("PRO_STOCK")-cart_pro_stock);
				proVO.setPro_safestock(rs.getInt("PRO_SAFESTOCK"));
				proVO.setPro_details(rs.getString("PRO_DETAILS"));
				proVO.setPro_shelve(rs.getString("PRO_SHELVE"));
				proVO.setPro_all_assess(rs.getInt("PRO_ALL_ASSESS"));
				proVO.setPro_all_assessman(rs.getInt("PRO_ALL_ASSESSMAN"));
			}
//			con.commit();//測試
		} catch (SQLException  e) {
			// TODO Auto-generated catch block
//			throw new RuntimeException(e.getMessage());
			e.printStackTrace();
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
	//更新評價分數
	@Override
	public int updateAssess(String pro_no, Integer pro_all_assess) {
		Connection con = null;
		PreparedStatement ps = null;
		int count = 0;
		ProductService proSvc = new ProductService();
		try {
			 
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
		    ps = con.prepareStatement(UPDATE_ASSESS);
//		    Integer pro_stock = proSvc.getProductStock(pro_no, cart_pro_stock).getPro_stock();
//		    System.out.println(pro_stock);
//		    ps.setInt(1,cart_pro_stock);
		    ps.setInt(1, pro_all_assess);
	        ps.setString(2, pro_no);
	       
	    	
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
	//查詢全部商品除後評價
	@Override
	public List<ProductAssessVO> getAllAssess() {
		List<ProductAssessVO> list = new ArrayList<>();
		ProductAssessVO productAssessVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			 
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
		    ps = con.prepareStatement(SELECT_ASSESS);
		    rs = ps.executeQuery();
		    
		    while(rs.next()) {
		    	productAssessVO = new ProductAssessVO();
		    	productAssessVO.setPro_no(rs.getString("PRO_NO"));
		    	productAssessVO.setPro_trunc_assess(rs.getInt("PRO_TRUNC_ASSESS"));
		    	productAssessVO.setPro_bonus(rs.getInt("PRO_BONUS"));
		    	productAssessVO.setPro_pic(rs.getBytes("PRO_PIC"));
		    	list.add(productAssessVO);
		    }
		    
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
		
		return list;
	}
	//查詢全部商品除後評價(類別查詢)
	@Override
	public List<ProductAssessVO> getAllAssesslike(String pro_classid) {
		List<ProductAssessVO> list = new ArrayList<>();
		ProductAssessVO productAssessVO = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			 
		    //連線池
		    con = ds.getConnection();
		    //JDBC版
//			con = DriverManager.getConnection(URL, USER, PASSWORD);
		    ps = con.prepareStatement(SELECT_ASSESSLIKE);
		    ps.setString(1, pro_classid);
		    rs = ps.executeQuery();
		    
		    while(rs.next()) {
		    	productAssessVO = new ProductAssessVO();
		    	productAssessVO.setPro_no(rs.getString("PRO_NO"));
		    	productAssessVO.setPro_trunc_assess(rs.getInt("PRO_TRUNC_ASSESS"));
		    	productAssessVO.setPro_bonus(rs.getInt("PRO_BONUS"));
		    	productAssessVO.setPro_pic(rs.getBytes("PRO_PIC"));
		    	list.add(productAssessVO);
		    }
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
		return list;
	}

	
	
	

	

	

	

}
