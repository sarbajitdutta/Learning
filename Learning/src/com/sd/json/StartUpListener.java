package com.sd.json;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.sd.db.DBConnectionManager;
import com.sd.properties.ConfigurationParam;

@WebListener
public class StartUpListener implements ServletContextListener {
	
	public void contextInitialized(ServletContextEvent sce){
		System.out.println("Context is initialized");
		
		
		//Load Property files
		ConfigurationParam cparam = new ConfigurationParam();
		cparam.loadProperties();
				
				
		DBConnectionManager conManager = new DBConnectionManager();
		sce.getServletContext().setAttribute("dbPool", conManager);
		
		
		
	}
	
	public void contextDestroyed(ServletContextEvent sce) {
		DBConnectionManager conManager = (DBConnectionManager)sce.getServletContext().getAttribute("dbPool");
		conManager.destroyConnectionPool();
		sce.getServletContext().removeAttribute("dbPool");
		System.out.println("All the database connections are closed");
	}

}
