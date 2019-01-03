package com.newstype.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;
import javax.sql.DataSource;


public class NewstypeJNDIDAO implements NewstypeDAO_interface{

	private static DataSource dataSource = null;
	static {
		try {
			javax.naming.Context context = new javax.naming.InitialContext();
			dataSource = (DataSource)context.lookup(com.util.lang.Util.JNDI_DATABASE_NAME);
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_SQL = 
			"INSERT INTO newstype(newstype_no,newstype_name) "
			+ "VALUES ('NT'||LPAD(TO_CHAR(newstype_seq.NEXTVAL),3,'0'),?)";
	
	private static final String UPDATE_NAME_SQL = 
			"UPDATE newstype SET newstype_name=? WHERE newstype_no=?";
	
	private static final String DELETE_BY_PK_SQL = 
			"DELETE FROM newstype where newstype_no=?";

	private static final String GET_ALL_SQL = 
			"SELECT newstype_no,newstype_name FROM newstype ORDER BY newstype_no ASC";
	
	private static final String FIND_BY_PK_SQL = 
			"SELECT newstype_no, newstype_name FROM newstype where newstype_no=?";

	
	@Override
	public void insert(NewstypeVO newstypeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			
			String[] cols = {"newstype_no"};
			
			pstmt = con.prepareStatement(INSERT_SQL,cols);
			pstmt.setString(1, newstypeVO.getNewstype_name());
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功輸入---");
			}else {
				System.out.println("---輸入失敗---");
			}
			rs = pstmt.getGeneratedKeys();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			if(rs.next()) {
				do {
					for (int i = 1; i <= columnCount; i++) {
						newstypeVO.setNewstype_no(rs.getString(i));
						System.out.println("自增主鍵值 = " + newstypeVO.getNewstype_no() +"(剛新增成功的newstype_no)");
					}
				} while (rs.next());
			} else {
				System.out.println("NO KEYS WERE GENERATED.");
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void update(NewstypeVO newstypeVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();
			
			pstmt = con.prepareStatement(UPDATE_NAME_SQL);
			pstmt.setString(1, newstypeVO.getNewstype_name());
			pstmt.setString(2, newstypeVO.getNewstype_no());
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功更新---");
			}else {
				System.out.println("---更新失敗---");
			}
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public void delete(String newstype_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(DELETE_BY_PK_SQL);
			pstmt.setString(1, newstype_no);
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功刪除---編號 : "+newstype_no);
			}else {
				System.out.println("---刪除失敗---編號 : "+newstype_no);
			}
			
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(con!=null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public NewstypeVO findByPrimaryKey(String newstype_no) {
		NewstypeVO nt = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(FIND_BY_PK_SQL);
			pstmt.setString(1, newstype_no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				nt = new NewstypeVO();
				nt.setNewstype_no(rs.getString("newstype_no"));
				nt.setNewstype_name(rs.getString("newstype_name"));				
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return nt;
	}

	@Override
	public List<NewstypeVO> getAll() {
		List<NewstypeVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(GET_ALL_SQL);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NewstypeVO nt = new NewstypeVO();
				nt.setNewstype_no(rs.getString("newstype_no"));
				nt.setNewstype_name(rs.getString("newstype_name"));
				list.add(nt);
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!=null) {
				try {
					con.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
}
