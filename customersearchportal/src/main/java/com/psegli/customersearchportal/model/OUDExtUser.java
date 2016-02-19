package com.psegli.customersearchportal.model;

public class OUDExtUser {

	private int id;
	private String userId;
	private String givenName;
	private String mail;
	private boolean preMigrationFlag;
	
	
	public OUDExtUser() {
		
	}
	
	
	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getGivenName() {
		return givenName;
	}
	public void setGivenName(String givenName) {
		this.givenName = givenName;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public boolean getPreMigrationFlag() {
		return preMigrationFlag;
	}
	public void setPreMigrationFlag(boolean migrationFlag) {
		this.preMigrationFlag = migrationFlag;
	}
}

