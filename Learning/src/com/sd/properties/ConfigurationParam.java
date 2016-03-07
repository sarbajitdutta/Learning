package com.sd.properties;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigurationParam {
	
	public static String dbUrl;
	public static String dbUsername;
	public static String dbPassword;
	
	public void loadProperties(){
	
		try {
				Properties properties = new Properties();
				InputStream in = getClass().getResourceAsStream("dbConnection.conf");
				System.out.println("Property file is about to load");
				properties.load(in);
				System.out.println("Property file loaded");
				dbUrl = properties.getProperty("databaseUrl");
				dbUsername = properties.getProperty("databaseUsername");
				dbPassword = properties.getProperty("databasePassword");
				System.out.println("All property assigned.");
				
				in.close();
				
	
		}
		catch(IOException io){
			System.out.println(io.getMessage());
		}
	}
	

}
