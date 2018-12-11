package com.newstype.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

public class NewstypeDAO implements NewstypeDAO_interface{

	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER = "CA105G1";
	private static final String PASSWORD = "123456";
	
	private static final String INSERT_SQL = "insert into ";
	
	
	@Override
	public void insert(NewstypeVO newstypeVO) {
		Connection con = null;
		
		
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL,USER,PASSWORD);
			//con.prepareStatement(sql)
			
			
			
			
			
			
			
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
			
			
			
			
			if(con!=null) {
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
	public void update(NewstypeVO newstypeVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Integer newstype_no) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public NewstypeVO findByPrimaryKey(Integer newstype_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<NewstypeVO> getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<NewstypeVO> getNewstypeByDeptno(Integer newstype_no) {
		// TODO Auto-generated method stub
		return null;
	}

}
