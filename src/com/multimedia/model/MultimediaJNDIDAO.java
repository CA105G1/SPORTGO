package com.multimedia.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;
import javax.sql.DataSource;

public class MultimediaJNDIDAO implements MultimediaDAO_interface{

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
			"INSERT INTO multimedia"
			+ "(media_no, file_extension, media_content, "
			+ "club_no, mem_no, media_releasedate, media_title) "
			+ "VALUES("
			+ "'ME'||LPAD(TO_CHAR(multimedia_seq.NEXTVAL),5,'0'),?,?,"
			+ "?,?,?,?)";
	private static final String UPDATE_SQL = 
			"UPDATE multimedia SET file_extension=?, media_content=?,"
			+ "club_no=?, mem_no=?, media_releasedate=?, media_title=? "
			+ "WHERE media_no=?";
	private static final String DELETE_BY_PK_SQL= 
			"DELETE FROM multimedia WHERE media_no=?";
	private static final String FIND_BY_PK_SQL = 
			"SELECT * FROM multimedia WHERE media_no=?";
	private static final String GET_ALL_MEDIAIN_CLUB_SQL = 
			"SELECT * FROM multimedia where club_no=? ORDER BY media_releasedate ASC";
	private static final String GET_ALL_MEDIA_IN_CLUB_BY_TITLE_SQL = 
			"SELECT * FROM multimedia WHERE club_no=? and MEDIA_TITLE LIKE UPPER('%'||?||'%')";

	
	
	@Override
	public void insert(MultimediaVO multimediaVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = dataSource.getConnection();
			
			String[] cols = {"media_no"};
			
			pstmt = con.prepareStatement(INSERT_SQL,cols);
			pstmt.setString(1, multimediaVO.getFile_extension());;
			pstmt.setBytes(2, multimediaVO.getMedia_content());
			pstmt.setString(3, multimediaVO.getClub_no());
			pstmt.setString(4, multimediaVO.getMem_no());
			pstmt.setTimestamp(5, multimediaVO.getMedia_releasedate());
			if(multimediaVO.getMedia_title()!=null) {
				multimediaVO.setMedia_title(multimediaVO.getMedia_title().toUpperCase());
			}
			pstmt.setString(6, multimediaVO.getMedia_title());
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---輸入成功---");
			}else {
				System.out.println("---輸入失敗---");
			}
			
			rs = pstmt.getGeneratedKeys();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			if(rs.next()) {
				do {
					for(int i =1 ; i <= columnCount ; i++) {
						multimediaVO.setMedia_no(rs.getString(i));
						System.out.println("自增主鍵值 = " + multimediaVO.getMedia_no() +"(剛新增成功的Media_no)");
					}
				}while(rs.next());
			}else {
				System.out.println("NO KEYS WERE GENERATED.");
			}
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
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
	}
	
	@Override
	public void update(MultimediaVO multimediaVO) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = dataSource.getConnection();
			
			preparedStatement = connection.prepareStatement(UPDATE_SQL);
			preparedStatement.setString(1, multimediaVO.getFile_extension());
			preparedStatement.setBytes(2, multimediaVO.getMedia_content());
			preparedStatement.setString(3, multimediaVO.getClub_no());
			preparedStatement.setString(4, multimediaVO.getMem_no());
			preparedStatement.setTimestamp(5, multimediaVO.getMedia_releasedate());
			multimediaVO.setMedia_title(multimediaVO.getMedia_title().toUpperCase());
			preparedStatement.setString(6, multimediaVO.getMedia_title());
			preparedStatement.setString(7, multimediaVO.getMedia_no());
			
			if(preparedStatement.executeUpdate()==1) {
				System.out.println("---成功更新---");
			}else {
				System.out.println("---更新失敗---");
			}
		} catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if(preparedStatement != null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!= null) {
				try {
					connection.close();
				} catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	@Override
	public void delete(String media_no) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(DELETE_BY_PK_SQL);
			preparedStatement.setString(1, media_no);
			if(preparedStatement.executeUpdate()==1) {
				System.out.println("---成功刪除---編號 : "+media_no);
			}else {
				System.out.println("---刪除失敗---編號 : "+media_no);
			}
			
		}catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(connection!= null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	@Override
	public MultimediaVO findByPrimaryKey(String media_no) {
		MultimediaVO multimediaVO = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(FIND_BY_PK_SQL);
			preparedStatement.setString(1, media_no);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				multimediaVO = new MultimediaVO();
				multimediaVO.setMedia_no(resultSet.getString("media_no"));
				multimediaVO.setFile_extension(resultSet.getString("file_extension"));
				multimediaVO.setMedia_content(resultSet.getBytes("media_content"));
				multimediaVO.setClub_no(resultSet.getString("club_no"));
				multimediaVO.setMem_no(resultSet.getString("mem_no"));
				multimediaVO.setMedia_releasedate(resultSet.getTimestamp("media_releasedate"));
				multimediaVO.setMedia_title(resultSet.getString("media_title"));
			}
		}catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}			
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			
		}
		return multimediaVO;
	}
	
	@Override
	public List<MultimediaVO> getAllMediaInClub(String club_no) {
		List<MultimediaVO> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(GET_ALL_MEDIAIN_CLUB_SQL);
			preparedStatement.setString(1, club_no);
			resultSet = preparedStatement.executeQuery();
			list = collectMutimediaVO(resultSet);	
		} catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!= null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	@Override
	public List<MultimediaVO> getAllMediaInClubByTitle(String club_no, String media_title) {
		List<MultimediaVO> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(GET_ALL_MEDIA_IN_CLUB_BY_TITLE_SQL);
			preparedStatement.setString(1, club_no);
			preparedStatement.setString(2, media_title);
			resultSet =preparedStatement.executeQuery();
			list = collectMutimediaVO(resultSet);
		} catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if( preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			if( connection!= null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	           
	private List<MultimediaVO> collectMutimediaVO(ResultSet resultSet) throws SQLException{
		List<MultimediaVO> list = new ArrayList<>();
		while(resultSet.next()) {
			MultimediaVO multimediaVO = new MultimediaVO();
			multimediaVO.setMedia_no(resultSet.getString("media_no"));
			multimediaVO.setFile_extension(resultSet.getString("file_extension"));
			multimediaVO.setMedia_content(resultSet.getBytes("media_content"));
			multimediaVO.setClub_no(resultSet.getString("club_no"));
			multimediaVO.setMem_no(resultSet.getString("mem_no"));
			multimediaVO.setMedia_releasedate(resultSet.getTimestamp("media_releasedate"));
			multimediaVO.setMedia_title(resultSet.getString("media_title"));
			list.add(multimediaVO);
		}
		return list;
	}
		
}              

