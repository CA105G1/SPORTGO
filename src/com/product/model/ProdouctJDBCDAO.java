package com.product.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdouctJDBCDAO implements ProdouctDAO_interface{
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "test";
	private static final String PASSWORD = "123456";
	//新增
	private static final String INSERT_INTO_DATA = "Insert into PRODUCT (PRO_NO,PRO_CLASSID,PRO_NAME,PRO_PIC,PRO_PIC_EXT,PRO_FORMAT,PRO_BONUS,PRO_STOCK,PRO_SAFESTOCK,PRO_DETAILS,PRO_SHELVE,PRO_ALL_ASSESS,PRO_ALL_ASSESSMAN) values ('PR'||LPAD(to_char(PRODUCT_SEQ.NEXTVAL), 3, '0'),?,?,?,?,?,?,?,?,?,?,?,?)";
	//修改
	private static final String INSERT_UPDATE = "UPDATE PRODUCT SET  PRO_CLASSID = ?, PRO_NAME = ?, PRO_PIC = ?, PRO_PIC_EXT = ?, PRO_FORMAT = ?, PRO_BONUS = ?, PRO_STOCK = ?, PRO_SAFESTOCK = ?, PRO_DETAILS = ?, PRO_SHELVE = ?, PRO_ALL_ASSESS = ?, PRO_ALL_ASSESSMAN = ? where PRO_NO = ?";
	//單筆查詢、多筆查詢
	private static final String SELETE_FINDBYPK = "select * from product where pro_no = ?";
	private static final String SELETE_ALL = "SELECT * FROM PRODUCT";
	//刪除
	private static final String DELETE_CHILDREN_01 = "Delete FROM ORDDETAILS WHERE ORD_NO = ?";
	private static final String DELETE_CHILDERN_02 = "Delete FROM PRO_DETAIL_PROM WHERE PROM_PROJECT_ID = ?";
	private static final String DELETE_DATA = "Delete FROM PRODUCT WHERE PRO_NO = ?";
	
	
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	@Override
	public void insert(ProdouctVO proVO) {
		Connection con = null;
		PreparedStatement ps = null;
		
		 try {
			    

				con = DriverManager.getConnection(URL, USER, PASSWORD);
				
		        ps = con.prepareStatement(INSERT_INTO_DATA);
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
		        
		        ps.executeQuery();
		        
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
		
		
		
	}

	@Override
	public void update(ProdouctVO proVO) {
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			
			con = DriverManager.getConnection(URL, USER, PASSWORD);
		    ps = con.prepareStatement(INSERT_UPDATE);
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
	    	
	    	ps.executeQuery();
		    
		} catch (  SQLException e) {
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
		
		
	}

	@Override
	public void delete(String ord_no ,String prom_project_id ,  String pro_no) {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(DELETE_CHILDREN_01);
			ps.setString(1,ord_no );
			rs = ps.executeQuery();
	
			ps = con.prepareStatement(DELETE_CHILDERN_02);
			ps.setString(1,prom_project_id );
			rs = ps.executeQuery();
			
			ps = con.prepareStatement(DELETE_DATA);
			ps.setString(1, pro_no);
			rs = ps.executeQuery();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public List<ProdouctVO> getAll() {
		List<ProdouctVO> provolist = new ArrayList<>();
		ProdouctVO provo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELETE_ALL);
		    rs = ps.executeQuery();
		    
		    while(rs.next()) {
		    	provo = new ProdouctVO();
		    	provo.setPro_no(rs.getString("PRO_NO"));
				provo.setPro_classid(rs.getString("PRO_CLASSID"));
				provo.setPro_name(rs.getString("PRO_NAME"));
				provo.setPro_pic(rs.getBytes("PRO_PIC"));
				provo.setPro_pic_ext(rs.getString("PRO_PIC_EXT"));
				provo.setPro_format(rs.getString("PRO_FORMAT"));
				provo.setPro_bonus(rs.getInt("PRO_BONUS"));
				provo.setPro_stock(rs.getInt("PRO_STOCK"));
				provo.setPro_safestock(rs.getInt("PRO_SAFESTOCK"));
				provo.setPro_details(rs.getString("PRO_DETAILS"));
				provo.setPro_shelve(rs.getString("PRO_SHELVE"));
				provo.setPro_all_assess(rs.getInt("PRO_ALL_ASSESS"));
				provo.setPro_all_assessman(rs.getInt("PRO_ALL_ASSESSMAN"));
		    	provolist.add(provo);
		    }
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return provolist;
	}

	@Override
	public ProdouctVO findByPK (String pro_no) {
		ProdouctVO provo = null;
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			con =  DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(SELETE_FINDBYPK);
			
			ps.setString(1, pro_no);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				provo = new ProdouctVO();
				provo.setPro_no(rs.getString("PRO_NO"));
				provo.setPro_classid(rs.getString("PRO_CLASSID"));
				provo.setPro_name(rs.getString("PRO_NAME"));
				provo.setPro_pic(rs.getBytes("PRO_PIC"));
				provo.setPro_pic_ext(rs.getString("PRO_PIC_EXT"));
				provo.setPro_format(rs.getString("PRO_FORMAT"));
				provo.setPro_bonus(rs.getInt("PRO_BONUS"));
				provo.setPro_stock(rs.getInt("PRO_STOCK"));
				provo.setPro_safestock(rs.getInt("PRO_SAFESTOCK"));
				provo.setPro_details(rs.getString("PRO_DETAILS"));
				provo.setPro_shelve(rs.getString("PRO_SHELVE"));
				provo.setPro_all_assess(rs.getInt("PRO_ALL_ASSESS"));
				provo.setPro_all_assessman(rs.getInt("PRO_ALL_ASSESSMAN"));
				
			}
			
		} catch (  SQLException e) {
			// TODO Auto-generated catch block
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
		
		return provo;
	}

	

}
