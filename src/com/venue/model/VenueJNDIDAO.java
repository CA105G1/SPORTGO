package com.venue.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.NamingException;
import javax.sql.DataSource;



public class VenueJNDIDAO implements VenueDAO_interface {

	private static DataSource dataSource = null;
	static {
		try {
			javax.naming.Context context = new javax.naming.InitialContext();
			dataSource = (DataSource)context.lookup(com.util.lang.Util.JNDI_DATABASE_NAME);
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT=""
			+ "INSERT INTO venue "
			+ "(v_no, v_name, v_weburl, v_parktype, v_introduction, "
			+ " vt_no, v_inout, reg_no, v_address, v_phoneno, v_lat, v_long, "
			+ " v_fitall, v_fitinter, "
			+ " open_state, open_time, "
			+ " openday_mon, openday_tue, openday_wed, openday_thu, "
			+ " openday_fri, openday_sat, openday_sun, "
			+ " v_photo1, v_photo1_ext, "
			+ " v_photo2, v_photo2_ext) "
			+ " VALUES ('V'||LPAD(venue_seq.NEXTVAL,6,'0'), ?, ?, ?, ?, "
			+ " ?, ?, ?, ?, ?, ?, ?, "
			+ " ?, ?, "
			+ " ?, ?, "
			+ " ?, ?, ?, ?, "
			+ " ?, ?, ?, "
			+ " ?, ?,"
			+ " ?, ?)"
			+ "";
	private static final String GET_ALL_STMT=""
			+ "SELECT "
			+ "(v_no, v_name, v_weburl, v_parktype, v_introduction, "
			+ " vt_no, v_inout, reg_n, v_address, v_phoneno, v_lat, v_long, "
			+ " v_fitall, v_fitinter, "
			+ " open_state, open_time, "
			+ " openday_mon, openday_tue, openday_wed, openday_thu, "
			+ " openday_fri, openday_sat, openday_sun, "
			+ " v_photo1, v_photo1_ext, "
			+ " v_photo2, v_photo2_ext) "
			+ " FROM venue ORDER BY v_no ASC";
	private static final String GET_ONE_STMT=""
			+ "SELECT "
			+ "(v_no, v_name, v_weburl, v_parktype, v_introduction, "
			+ " vt_no, v_inout, reg_n, v_address, v_phoneno, v_lat, v_long, "
			+ " v_fitall, v_fitinter, "
			+ " open_state, open_time, "
			+ " openday_mon, openday_tue, openday_wed, openday_thu, "
			+ " openday_fri, openday_sat, openday_sun, "
			+ " v_photo1, v_photo1_ext, "
			+ " v_photo2, v_photo2_ext) "
			+ " FROM venue where v_no=? ";;
	private static final String DELETE=""
			+ "DELETE FROM venue WHERE v_no=?";
	private static final String UPDATE=""
			+ "UPDATE venue SET "
			+ " v_name=?, v_weburl=?, v_parktype=?, v_introduction=?, "
			+ " vt_no=?, v_inout=?, reg_no=?, v_address=?, v_phoneno=?, v_lat=?, v_long=?, "
			+ " v_fitall=?, v_fitinter=?,"
			+ " open_state=?, open_time=?, "
			+ " openday_mon=?, openday_tue=?, , openday_wed=?, openday_thu=?, "
			+ "	openday_fri=?, openday_sat=?, openday_sun=?, "
			+ " v_photo1=?, v_photo1_ext=?, v_photo2=?, v_photo2_ext=? "
			+ " WHERE v_no=?";
	
	
	
	@Override
	public void insert(VenueVO venueVO) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			String[] cols = {"v_no"};	
			preparedStatement = connection.prepareStatement(INSERT,cols);
			preparedStatement.setString(1, venueVO.getV_name());
			preparedStatement.setString(2, venueVO.getV_weburl());
			preparedStatement.setString(3, venueVO.getV_patktype());
			preparedStatement.setString(4, venueVO.getV_introduction());
			preparedStatement.setString(5, venueVO.getVt_no());
			preparedStatement.setString(6, venueVO.getV_inout());
			preparedStatement.setInt(7, venueVO.getReg_no());
			preparedStatement.setString(8, venueVO.getV_address());
			preparedStatement.setString(9, venueVO.getV_phoneno());
			preparedStatement.setDouble(10, venueVO.getV_lat());
			preparedStatement.setDouble(11, venueVO.getV_long());
//			preparedStatement.setString(12, venueVO.getV_public_transport());
			preparedStatement.setString(12, venueVO.getV_fitall());
			preparedStatement.setString(13, venueVO.getV_fitinter());
			preparedStatement.setString(14, venueVO.getOpen_state());
			preparedStatement.setString(15, venueVO.getOpen_time());
			preparedStatement.setString(16, venueVO.getOpenday_mon());
			preparedStatement.setString(17, venueVO.getOpenday_tue());
			preparedStatement.setString(18, venueVO.getOpenday_wed());
			preparedStatement.setString(19, venueVO.getOpenday_thu());
			preparedStatement.setString(20, venueVO.getOpenday_fri());
			preparedStatement.setString(21, venueVO.getOpenday_sat());
			preparedStatement.setString(22, venueVO.getOpenday_sun());
			preparedStatement.setBytes(23, venueVO.getV_photo1());
			preparedStatement.setString(24, venueVO.getV_photo1_ext());
			preparedStatement.setBytes(25, venueVO.getV_photo2());
			preparedStatement.setString(26, venueVO.getV_photo2_ext());
			
			preparedStatement.executeUpdate();
			
			resultSet = preparedStatement.getGeneratedKeys();
			ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
			int columnCount = resultSetMetaData.getColumnCount();
			if(resultSet.next()) {
				do {
					for(int i = 1 ; i <= columnCount ; i++) {
						venueVO.setV_no(resultSet.getString(i));
					}
				}while(resultSet.next());
			}
		}catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if(resultSet!=null) {
				try {
					resultSet.close();
				}catch (SQLException e) {
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
	}

	@Override
	public void update(VenueVO venueVO) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(UPDATE);
			preparedStatement.setString(1, venueVO.getV_name());
			preparedStatement.setString(2, venueVO.getV_weburl());
			preparedStatement.setString(3, venueVO.getV_patktype());
			preparedStatement.setString(4, venueVO.getV_introduction());
			preparedStatement.setString(5, venueVO.getVt_no());
			preparedStatement.setString(6, venueVO.getV_inout());
			preparedStatement.setInt(7, venueVO.getReg_no());
			preparedStatement.setString(8, venueVO.getV_address());
			preparedStatement.setString(9, venueVO.getV_phoneno());
			preparedStatement.setDouble(10, venueVO.getV_lat());
			preparedStatement.setDouble(11, venueVO.getV_long());
//			preparedStatement.setString(12, venueVO.getV_public_transport());
			preparedStatement.setString(12, venueVO.getV_fitall());
			preparedStatement.setString(13, venueVO.getV_fitinter());
			preparedStatement.setString(14, venueVO.getOpen_state());
			preparedStatement.setString(15, venueVO.getOpen_time());
			preparedStatement.setString(16, venueVO.getOpenday_mon());
			preparedStatement.setString(17, venueVO.getOpenday_tue());
			preparedStatement.setString(18, venueVO.getOpenday_wed());
			preparedStatement.setString(19, venueVO.getOpenday_thu());
			preparedStatement.setString(20, venueVO.getOpenday_fri());
			preparedStatement.setString(21, venueVO.getOpenday_sat());
			preparedStatement.setString(22, venueVO.getOpenday_sun());
			preparedStatement.setBytes(23, venueVO.getV_photo1());
			preparedStatement.setString(24, venueVO.getV_photo1_ext());
			preparedStatement.setBytes(25, venueVO.getV_photo2());
			preparedStatement.setString(26, venueVO.getV_photo2_ext());
			preparedStatement.setString(27, venueVO.getV_no());
			
			preparedStatement.executeUpdate();
			
		}catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
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
	}

	@Override
	public void delete(String v_no) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(DELETE);
			preparedStatement.setString(1, v_no);
			
			preparedStatement.executeUpdate();
			
		}catch(SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if( preparedStatement != null) {
				try {
					preparedStatement.close();
				}catch (SQLException e) {
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
	}

	@Override
	public VenueVO findByPrimaryKey(String v_no) {
		VenueVO venueVO = null;
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(GET_ONE_STMT);
			preparedStatement.setString(1, v_no);
			resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				venueVO = new VenueVO();
				venueVO.getV_no();
				venueVO.getV_name();
				venueVO.getV_weburl();
				venueVO.getV_patktype();
				venueVO.getV_introduction();
				venueVO.getVt_no();
				venueVO.getV_inout();
				venueVO.getReg_no();
				venueVO.getV_address();
				venueVO.getV_phoneno();
				venueVO.getV_lat();
				venueVO.getV_long();
//				venueVO.getV_public_transport();
				venueVO.getV_fitall();
				venueVO.getV_fitinter();
				venueVO.getOpen_state();
				venueVO.getOpen_time();
				venueVO.getOpenday_mon();
				venueVO.getOpenday_tue();
				venueVO.getOpenday_wed();
				venueVO.getOpenday_thu();
				venueVO.getOpenday_fri();
				venueVO.getOpenday_sat();
				venueVO.getOpenday_sun();
				venueVO.getV_photo1();
				venueVO.getV_photo1_ext();
				venueVO.getV_photo2();
				venueVO.getV_photo2_ext();
			}
			
		}catch (SQLException e) {
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
		return venueVO;
	}

	@Override
	public List<VenueVO> getAll() {
		List<VenueVO> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = dataSource.getConnection();
			preparedStatement = connection.prepareStatement(GET_ALL_STMT);
			resultSet = preparedStatement.executeQuery();
			list = collectVenueVO(resultSet);
			
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
	
	private List<VenueVO> collectVenueVO(ResultSet resultSet) throws SQLException {
		List<VenueVO> list = new ArrayList<>();
		while(resultSet.next()) {
			VenueVO venueVO = new VenueVO();
			venueVO.getV_no();
			venueVO.getV_name();
			venueVO.getV_weburl();
			venueVO.getV_patktype();
			venueVO.getV_introduction();
			venueVO.getVt_no();
			venueVO.getV_inout();
			venueVO.getReg_no();
			venueVO.getV_address();
			venueVO.getV_phoneno();
			venueVO.getV_lat();
			venueVO.getV_long();
//			venueVO.getV_public_transport();
			venueVO.getV_fitall();
			venueVO.getV_fitinter();
			venueVO.getOpen_state();
			venueVO.getOpen_time();
			venueVO.getOpenday_mon();
			venueVO.getOpenday_tue();
			venueVO.getOpenday_wed();
			venueVO.getOpenday_thu();
			venueVO.getOpenday_fri();
			venueVO.getOpenday_sat();
			venueVO.getOpenday_sun();
			venueVO.getV_photo1();
			venueVO.getV_photo1_ext();
			venueVO.getV_photo2();
			venueVO.getV_photo2_ext();
			list.add(venueVO);
		}
		return list;
	}	
	
	
	
	
}