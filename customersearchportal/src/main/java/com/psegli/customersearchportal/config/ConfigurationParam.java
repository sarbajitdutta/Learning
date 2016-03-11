package com.psegli.customersearchportal.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

public class ConfigurationParam {
	
	private static final Logger log = Logger.getLogger(ConfigurationParam.class);
	
	
	public static String ldapServer;
	public static int ldapPort;
	public static String ldapPassword;
	public static String ldapRoot;
	public static String ldapUser;
	public static String ldapUserSearch;
	public static String emailNotification;
	
	
	public void loadProperties() {
		
		try{
			
			Properties properties = new Properties();
			InputStream in = getClass().getResourceAsStream("ConnectionDetails.conf");
			log.info("Property file ConnectionDetails.conf is about to load.");
			properties.load(in);
			log.info("Property file ConnectionDetails.conf is loaded.");
			
			ldapServer = properties.getProperty("ldap_server");
			ldapPort = Integer.parseInt(properties.getProperty("ldap_port"));
			ldapPassword = properties.getProperty("ldap_password");
			ldapRoot = properties.getProperty("ldap_root");
			ldapUser = properties.getProperty("ldap_user");
			ldapUserSearch = properties.getProperty("ldap_user_search");
			emailNotification = properties.getProperty("email_notification");
			
			log.info("All the properties has been assigned.");
			
			in.close();
		}
		catch(IOException io) {
			log.error("There was an error while loading property file "+io);
			
		}
	}

}
