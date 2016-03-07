package com.sd.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Vector;

import com.sd.properties.ConfigurationParam;

public class DBConnectionManager {
	
	
	
	private Vector<Connection> connectionPool = new Vector<Connection>(); 
	
	
	public DBConnectionManager() {
		initialize();
	}
	
	/*public DBConnectionManager(String url, String username, String password) {
		this.databaseUrl =  url;
		this.userName = username;
		this.password = password;
		initialize();
		
	}*/
	
	private void initialize() {
		initializeConnectionPool();
		
	}
	
	private void initializeConnectionPool() {
		while(!checkIfConnectionPoolIsFull()) {
			System.out.println("Connection pool is not full. Proceeding with adding new connection");
			connectionPool.addElement(createNewConnectionForPool());
		}
		System.out.println("Connection pool is full");
	}
	
	private synchronized boolean checkIfConnectionPoolIsFull() {
		final int MAX_POOL_SIZE = 5;
		if(connectionPool.size()<MAX_POOL_SIZE)
			return false;
		else
			return true;
	}
	
	private Connection createNewConnectionForPool() {
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection(ConfigurationParam.dbUrl, ConfigurationParam.dbUsername, ConfigurationParam.dbPassword);
			System.out.println("Connection"+con);
		}
		catch(SQLException sqle) {
			System.err.println(sqle);
			return null;
		}
		catch(ClassNotFoundException cnfe) {
			System.err.println(cnfe);
			return null;
		}
		return con;
	}
	
	public synchronized Connection getConnectionfromPool(){
		
		Connection con = null;
		if(connectionPool.size()>0){
			con = (Connection)connectionPool.firstElement();
			connectionPool.removeElementAt(0);
		}
		return con;
	}
	
	public synchronized void returnConnectionToPool(Connection connection)
    {
        //Adding the connection from the client back to the connection pool
        connectionPool.addElement(connection);
    }
	
	public void destroyConnectionPool() {
		Enumeration<Connection> e = connectionPool.elements();
		while(e.hasMoreElements()) {
			Connection con = (Connection)e.nextElement();
			try{
			con.close();
			}
			catch(SQLException sqle){
				System.out.println(sqle);
			}
		}
		connectionPool.removeAllElements();
	} 

}
