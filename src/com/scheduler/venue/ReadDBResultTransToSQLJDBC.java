package com.scheduler.venue;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.ResultSetMetaData;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;



public class ReadDBResultTransToSQLJDBC {

	private static final String DRIVER = com.util.lang.Util.DRIVER;
	private static final String URL = com.util.lang.Util.URL;
	private static final String USER = com.util.lang.Util.USER;
	private static final String PASSWORD = com.util.lang.Util.PASSWORD;
	static {
		try {
			Class.forName(DRIVER);
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	private static String SELECT_TABLE_SQL = ""
			+ "SELECT * FROM ?";
	
	private List<String> insertIntoSQLList = new ArrayList<>();
	
	private void queryTableAllData(String tableName) {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		ResultSetMetaData resultSetMetaData = null;
		
		Map<String, List<String>> tableMap = new LinkedHashMap<String, List<String>>();
		List<String> colsValueList = new ArrayList<>();
		Map<Integer, String> colsIndexAndTypeMap =new HashMap<Integer, String>();
		
		try {
			connection = DriverManager.getConnection(URL, USER, PASSWORD);
			preparedStatement = connection.prepareStatement(SELECT_TABLE_SQL);
			preparedStatement.setString(1, tableName);
			resultSet = preparedStatement.executeQuery();
			resultSetMetaData = resultSet.getMetaData();
			
			int numberOfColumns = resultSetMetaData.getColumnCount();
			for(int i = 1 ; i <= numberOfColumns ; i++) {
				String colTypeName = resultSetMetaData.getColumnTypeName(i);
				colsIndexAndTypeMap.put(i, colTypeName);
			}
			
			
			while(resultSet.next()) {
				StringBuffer stringBuffer =new StringBuffer();
				Set<Integer> keySet = colsIndexAndTypeMap.keySet();
				
				for(Integer integer : keySet) {
					String colsType = colsIndexAndTypeMap.get(integer);
					switch (colsType) {
					case "VARCHAR2":
						
						break;
					case "BLOB":
						
						break;

					default:
						break;
					}
					
					
				}
				
				
				
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
	
	
	
}
