package com.venue.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class VenueJDBCDAO implements VenueDAO_interface {
	
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
	
	private static final String INSERT =
			"INSERT INTO venue (v_no ,v_name ,vt_no ,reg_no ,v_lat ,v_long ,v_pic, v_address ,v_phoneno ,v_status ,v_func) VALUES ('V'||LPAD(to_char(VENUE_SEQ.NEXTVAL), 6, '0'),?,?,?,?,?,?,?,?,?,?)";
	private static final String GET_ALL_STMT =
			"SELECT * FROM venue ORDER BY v_no";
	private static final String GET_ONE_STMT =
			"SELECT * FROM venue WHERE v_no = ?";
	private static final String DELETE =
			"DELETE FROM venue WHERE v_no = ?";

	@Override
	public void insert(VenueVO venueVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT);

			pstmt.setString(1, venueVO.getV_name());
			pstmt.setString(2, venueVO.getVt_no());
			pstmt.setInt(3, venueVO.getReg_no());
			pstmt.setDouble(4, venueVO.getV_lat());
			pstmt.setDouble(5, venueVO.getV_long());
			pstmt.setString(6, venueVO.getV_pic());
			pstmt.setString(7, venueVO.getV_address());
			pstmt.setString(8, venueVO.getV_phoneno());
			pstmt.setString(9, venueVO.getV_status());
			pstmt.setString(10, venueVO.getV_func());

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void update(VenueVO venueVO) {
	
		
	}
	

	@Override
	public void delete(String v_no) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setString(1, v_no);

			pstmt.executeUpdate();

			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public VenueVO findByPrimaryKey(String v_no) {

		VenueVO venueVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, v_no);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// vtVo 也稱為 Domain objects
				venueVO = new VenueVO();
				venueVO.setV_no(rs.getString("vt_no"));
				venueVO.setV_name(rs.getString("v_name"));
				venueVO.setVt_no(rs.getString("vt_no"));
				venueVO.setReg_no(rs.getInt("reg_no"));
				venueVO.setV_lat(rs.getDouble("v_lat"));
				venueVO.setV_long(rs.getDouble("v_long"));
				venueVO.setV_pic(rs.getString("v_pic"));
				venueVO.setV_address(rs.getString("v_address"));
				venueVO.setV_phoneno(rs.getString("v_phoneno"));
				venueVO.setV_status(rs.getString("v_status"));
				venueVO.setV_func(rs.getString("v_func"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return venueVO;
	}

	@Override
	public List<VenueVO> getAll() {
		
		List<VenueVO> list = new ArrayList<VenueVO>();
		VenueVO venueVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// vtVo 也稱為 Domain objects
				venueVO = new VenueVO();
				venueVO.setV_no(rs.getString("vt_no"));
				venueVO.setV_name(rs.getString("v_name"));
				venueVO.setVt_no(rs.getString("vt_no"));
				venueVO.setReg_no(rs.getInt("reg_no"));
				venueVO.setV_lat(rs.getDouble("v_lat"));
				venueVO.setV_long(rs.getDouble("v_long"));
				venueVO.setV_pic(rs.getString("v_pic"));
				venueVO.setV_address(rs.getString("v_address"));
				venueVO.setV_phoneno(rs.getString("v_phoneno"));
				venueVO.setV_status(rs.getString("v_status"));
				venueVO.setV_func(rs.getString("v_func"));
			}

			// Handle any driver errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
	
}
