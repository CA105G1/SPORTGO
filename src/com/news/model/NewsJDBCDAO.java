package com.news.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class NewsJDBCDAO implements NewsDAO_interface{

	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	private static final String INSERT_SQL = 
			"INSERT INTO news"
			+ "(news_no, newstype_no, news_script, "
			+ "pic_extension, news_picture, news_stutas, "
			+ "news_release_date, news_last_date) "
			+ "VALUES('N'||LPAD(TO_CHAR(news_seq.NEXTVAL),3,'0'),?,?,"
			+ "?,?,?,"
			+ "?,?)";

	private static final String UPDATE_SQL =
			"UPDATE news SET newstype_no=?, news_script=?, "
			+ "pic_exetension=?, news_picture=?, news_stutas=?, "
			+ "news_release_date=?, news_last_date=? WHERE news_no=?";
	private static final String UPDATE_STUTAS_BY_NO_SQL =
			"UPDATE news SET news_stutas=? WHERE news_no=?";
	private static final String DELETE_SQL = 
			"DELETE FROM news WHERE news_no=?";
	
	private static final String FIND_BY_PK_SQL=
	"SELECT * FROM news WHERE news_no=?";
	private static final String GET_ALL = 
			"SELECT * FROM news ORDER BY news_no ASC";
	
	
	private static final String GET_NEWS_BY_NEWSTYPE = 
	"SELECT * FROM news WHERE newstype_no=?";

	@Override
	public void insert(NewsVO newsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			String[] cols = {"news_no"};
			pstmt = con.prepareStatement(INSERT_SQL,cols);
			
			pstmt.setString(1, newsVO.getNewstype_no());
			pstmt.setString(2, newsVO.getNews_script());
			pstmt.setString(3, newsVO.getPic_extension());
			pstmt.setBytes(4, newsVO.getNews_picture());
			pstmt.setString(5, newsVO.getNews_stutas());
			pstmt.setTimestamp(6, newsVO.getNews_release_date());
			pstmt.setTimestamp(7, newsVO.getNews_last_date());
			
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
						newsVO.setNews_no(rs.getString(i));
						System.out.println("自增主鍵值 = " + newsVO.getNews_no() +"(剛新增成功的newstype_no)");
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
	public void update(NewsVO newsVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_SQL);
			
			pstmt.setString(1, newsVO.getNewstype_no());
			pstmt.setString(2, newsVO.getNews_script());
			pstmt.setString(3, newsVO.getPic_extension());
			pstmt.setBytes(4, newsVO.getNews_picture());
			pstmt.setString(5, newsVO.getNews_stutas());
			pstmt.setTimestamp(6, newsVO.getNews_release_date());
			pstmt.setTimestamp(7,newsVO.getNews_last_date());
			pstmt.setString(8, newsVO.getNews_no());
			
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功更新---編號: "+newsVO.getNews_no());
			}else {
				System.out.println("---更新失敗---編號: "+newsVO.getNews_no());
			}
		} catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch(SQLException e) {
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
	public void updateStutasByNewsNo(String news_no ,String news_stutas) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE_STUTAS_BY_NO_SQL);
			pstmt.setString(1, news_stutas);
			pstmt.setString(2, news_no);
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功更新狀態---");
			}else {
				System.out.println("---更新狀態失敗---");
			}
		} catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(pstmt!=null) {
				try {
					pstmt.close();
				}catch(SQLException e) {
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
	public void delete(String news_no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE_SQL);
			pstmt.setString(1, news_no);
			if(pstmt.executeUpdate()==1) {
				System.out.println("---成功刪除---編號 : "+news_no);
			}else {
				System.out.println("---刪除失敗---編號 : "+news_no);
			}
		}catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				}catch(SQLException e) {
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
	public NewsVO findByPrimaryKey(String news_no) {
		NewsVO newsVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_PK_SQL);
			pstmt.setString(1, news_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				newsVO = new NewsVO();
				newsVO.setNews_no(news_no);
				newsVO.setNewstype_no(rs.getString("newstype_no"));
				newsVO.setNews_script(rs.getString("news_script"));
				newsVO.setPic_extension(rs.getString("pic_extension"));
				newsVO.setNews_picture(rs.getBytes("news_picture"));
				newsVO.setNews_stutas(rs.getString("news_stutas"));
				newsVO.setNews_release_date(rs.getTimestamp("news_release_date"));
				newsVO.setNews_last_date(rs.getTimestamp("news_last_date"));
			}
			
		} catch(SQLException e){
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
		return newsVO;
	}

	@Override
	public List<NewsVO> getAll() {
		List<NewsVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();
			list = collectNewsVO(rs);			
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
		return list;
	}
	
	@Override
	public List<NewsVO> getAll(Map<String, String[]> map) {
		List<NewsVO> list = new ArrayList<NewsVO>();
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			String finalSQL = "Select * from news "
					+ Util_JDBC_CompositeQuery_News.get_WhereCondition(map)
					+ " order by news_no";
			
			preparedStatement = connection.prepareStatement(finalSQL);
			System.out.println("+++FinalSQL(by JDBCDAO) = "+finalSQL);
			resultSet = preparedStatement.executeQuery();
			list = collectNewsVO(resultSet);
			
			
		}catch (SQLException e) {
			list = new ArrayList<>();
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
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	@Override
	public List<NewsVO> getNewsByNewtype(String newstype_no) {
		List<NewsVO> list = new ArrayList<>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_NEWS_BY_NEWSTYPE);
			pstmt.setString(1, newstype_no);
			rs = pstmt.executeQuery();
			list = collectNewsVO(rs);
		} catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(rs!=null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(pstmt!= null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(con!= null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	private static final String GET_RELEASE_NEWS_SQL = ""
			+ "Select * from news where ? "
			+ " between news_release_date and news_last_date "
			+ " and news_stutas='發布中' "
			+ " order by news_release_date DESC";
	
	@Override
	public List<NewsVO> getReleaseNews(Timestamp nowTime) {
		List<NewsVO> list = new ArrayList<NewsVO>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_RELEASE_NEWS_SQL);
			preparedStatement.setTimestamp(1, nowTime);
			resultSet = preparedStatement.executeQuery();
			list = collectNewsVO(resultSet);
		} catch(SQLException e) {
			list = new ArrayList<>();
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!= null) {
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
		return list;
	}
	
	private static final String GET_DEFAULT_NEWS_SQL = ""
			+ "Select * from  news "
			+ " where NewsType_no = ("
			+ "Select newstype_no from newstype where newstype_name = '公告'"
			+ ") order by news_release_date DESC";
	
	@Override
	public List<NewsVO> getDefaultNews(){
		List<NewsVO> list = new ArrayList<NewsVO>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_DEFAULT_NEWS_SQL);
			resultSet = preparedStatement.executeQuery();
			list = collectNewsVO(resultSet);
		} catch(SQLException e) {
			list = new ArrayList<>();
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!= null) {
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
		return list;
	}

	
	private static final String GET_NEED_TO_RELEASE_LIST_NEWS_SQL = ""
			+ " Select * from news " + 
			" where sysdate " + 
			" between news_release_date and news_last_date " + 
			" or (news_release_date <=sysdate and news_last_date is null) " + 
			" or (news_last_date >=sysdate and news_release_date is null) ";

	@Override
	public List<NewsVO> getNeedToReleaseListNews() {
		List<NewsVO> list = new ArrayList<NewsVO>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_NEED_TO_RELEASE_LIST_NEWS_SQL);
			resultSet = preparedStatement.executeQuery();
			list = collectNewsVO(resultSet);
		} catch(SQLException e) {
			list = new ArrayList<>();
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!= null) {
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
		return list;
		
	}

	private static final String GET_NEED_TO_DISCONTINUE_LIST_NEWS_SQL = ""
			+ " Select * from news where news_last_date < sysdate";
	
	@Override
	public List<NewsVO> getNeedToDiscontinueListNews() {
		List<NewsVO> list = new ArrayList<NewsVO>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_NEED_TO_DISCONTINUE_LIST_NEWS_SQL);
			resultSet = preparedStatement.executeQuery();
			list = collectNewsVO(resultSet);
		} catch(SQLException e) {
			list = new ArrayList<>();
			throw new RuntimeException("A database error occured. "+e.getMessage());
		} finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(preparedStatement!= null) {
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
		return list;
		
	}

	private List<NewsVO> collectNewsVO(ResultSet rs) throws SQLException {
		List<NewsVO> list = new ArrayList<>();
		while(rs.next()) {
			NewsVO newsVO = new NewsVO();
			newsVO.setNews_no(rs.getString("news_no"));
			newsVO.setNewstype_no(rs.getString("newstype_no"));
			newsVO.setNews_script(rs.getString("news_script"));
			newsVO.setPic_extension(rs.getString("pic_extension"));
			newsVO.setNews_picture(rs.getBytes("news_picture"));
			newsVO.setNews_stutas(rs.getString("news_stutas"));
			newsVO.setNews_release_date(rs.getTimestamp("news_release_date"));
			newsVO.setNews_last_date(rs.getTimestamp("news_last_date"));
			list.add(newsVO);
		}
		return list;
	}
	
}
