package com.psegli.customersearchportal.dao;

import java.util.List;

import com.psegli.customersearchportal.model.OUDExtUser;

public interface LDAPInterface {
	
	//This method is to search for the user from LDAP
	public  List<OUDExtUser> searchLDAPByUid(String userId);
	
	//This method is to modify email address for a particular user
	public boolean modifyEmailUsingUid(String userId, String email);
	
	public boolean deleteEmailUsingUid(String userId);
	
	public boolean toPreMigration(String userId);
	
	

}
