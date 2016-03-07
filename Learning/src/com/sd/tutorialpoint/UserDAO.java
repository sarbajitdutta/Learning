package com.sd.tutorialpoint;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

import com.sd.db.DBConnectionManager;
import com.sd.properties.ConfigurationParam;



public class UserDAO extends HttpServlet {
	
	
	
	
	@SuppressWarnings("null")
	public List<User> getAllUsers(){
		
		List<User> userList = new ArrayList<User>();
		try {
			
			//DBConnectionManager conManager = (DBConnectionManager)getServletContext().getAttribute("dbPool");
			//System.out.println(conManager);
			//Connection con = conManager.getConnectionfromPool();
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@pl-dv-emtr-db1.dev.psegliny:1521:COBRA", "DTS", "DTS");
			PreparedStatement ps = con.prepareStatement("select id,username,accesslevel from tblusernames");
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				User user = new User(rs.getInt(1), rs.getString(2), rs.getString(3));
				userList.add(user);
			}
			rs.close();
			ps.close();
			con.close();
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			
		}
		return userList;
	}
	
	public User getUser(int id) {
		List<User> users = getAllUsers();
		
		Iterator<User> iter = users.iterator();
		
		while(iter.hasNext()) {
			User u = iter.next();
			if(u.getId() == id)
				return u;
		}
		return null;
	}
	
	
	

}
