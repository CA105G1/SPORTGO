package com.gym.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class GymDAO implements GymDAO_interface{
	
	public static final String DRIVER = com.util.lang.Util.DRIVER;
	public static final String URL = com.util.lang.Util.URL;
	public static final String USER = com.util.lang.Util.USER;
	public static final String PASSWORD = com.util.lang.Util.PASSWORD;
	
	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_SQL = 
			"INSERT INTO gym(gym_id,gym_name,gym_funclist) VALUES(?,?,?)";
	private static final String GET_ALL_GYMID_SQL = 
			"SELECT gym_id from gym";
	
	
	public void insert(GymVO gymVO) {
		
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		
		try {
			
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement =connection.prepareStatement(INSERT_SQL);
			preparedStatement.setInt(1, gymVO.getGym_id());
			preparedStatement.setString(2, gymVO.getGym_name());
			preparedStatement.setString(3, gymVO.getGym_funclist());
			
			preparedStatement.executeUpdate();
			
		}catch (SQLException e) {
			throw new RuntimeException("A database error occured. "+e.getMessage());
		}finally {
			if(preparedStatement!=null) {
				try {
					preparedStatement.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(connection!=null) {
				try {
					connection.close();
				}catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	public List<Integer> getAllGymID(){
		List<Integer> list = new ArrayList<>();
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(GET_ALL_GYMID_SQL);
			resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				list.add(resultSet.getInt("gym_id"));
			}
			
			
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
			if(connection !=null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			
		}
		return list;
	}
	
	
}
