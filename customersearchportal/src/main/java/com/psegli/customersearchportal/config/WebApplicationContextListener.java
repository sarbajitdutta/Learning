package com.psegli.customersearchportal.config;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import com.psegli.customersearchportal.dao.LDAPInterfaceImpl;


public class WebApplicationContextListener implements ServletContextListener {
	
	private static final Logger log = Logger.getLogger(WebApplicationContextListener.class);
	
	
	public void contextInitialized(ServletContextEvent sce) { 
		
		log.info("The context has initialized.");
		log.info("Initializing property file");
		
		ConfigurationParam cparam = new ConfigurationParam();
		cparam.loadProperties();
		
		
	}
	
	
	public void contextDestroyed(ServletContextEvent sce) {
		log.info("Context is destroyed");
	}

}
