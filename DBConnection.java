package com.company.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {
	
	public static Connection getConnection()
	{
		try
		{
			// Create an object of Properties class to access the properties from a db.properties file 
			Properties props = new Properties();
			// based on builder design pattern in core java 
//			to get the details from the db.properties file
			InputStream input = DBConnection.class
								.getClassLoader()
								.getResourceAsStream("db.properties");
			
			props.load(input); 
			return DriverManager.getConnection(props.getProperty("url"),
					                           props.getProperty("username"),
					                           props.getProperty("password")
					);
					
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

}
