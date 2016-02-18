package com.psegli.customersearchportal.dao;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;




import com.psegli.customersearchportal.model.OUDExtUser;

import netscape.ldap.LDAPAttribute;
import netscape.ldap.LDAPConnection;
import netscape.ldap.LDAPEntry;
import netscape.ldap.LDAPException;
import netscape.ldap.LDAPModification;
import netscape.ldap.LDAPSearchResults;

public class LDAPInterfaceImpl implements LDAPInterface {
	
	public LDAPInterfaceImpl() {
		super();
	}
	
	
	
	public  List<OUDExtUser> searchLDAPByUid(String userId) {
	
		LDAPConnection ld = null;
		String uid = "";
		String givenName = "";
		String mail = "";
		
		List<OUDExtUser> users = new ArrayList<OUDExtUser>();
		
		try {
			
			ld = new LDAPConnection();
			
			/* Connect to the OUD Server */
			ld.connect("gcolqaidm3.dev.psegliny", 1389);
			ld.authenticate("cn=Directory Manager", "qat@dm1n");
			
			/* Search for the user from the userid that was supplied */
			String SEARCH_FILTER = "uid=" + userId+"*";
			String SEARCH_BASE = "cn=users" + "," + "dc=dev,dc=psegliny";
			LDAPSearchResults results = ld.search(SEARCH_BASE, LDAPConnection.SCOPE_SUB, SEARCH_FILTER, null, false);
			
			
			
			while(results.hasMoreElements()) {
				OUDExtUser user = new OUDExtUser();
				LDAPEntry entry = (LDAPEntry)results.nextElement();
				if(entry.getAttribute("uid")!=null){
					LDAPAttribute attr = entry.getAttribute("uid");
					if(attr!=null) {
						Enumeration enumVals = attr.getStringValues();
						if(enumVals != null) {
							while(enumVals.hasMoreElements()) {
								uid = (String)enumVals.nextElement();
								user.setUserId(uid);
							}
						}
					}
				}
				if(entry.getAttribute("givenName")!=null){
					LDAPAttribute attr = entry.getAttribute("givenName");
					if(attr!=null) {
						Enumeration enumVals = attr.getStringValues();
						if(enumVals != null) {
							while(enumVals.hasMoreElements()) {
								givenName = (String)enumVals.nextElement();
								user.setGivenName(givenName);
							}
						}
					}
				}
				if(entry.getAttribute("mail")!=null ){
					LDAPAttribute attr = entry.getAttribute("mail");
					if(attr!=null) {
						Enumeration enumVals = attr.getStringValues();
						if(enumVals != null) {
							while(enumVals.hasMoreElements()) {
								mail = (String)enumVals.nextElement();
								user.setMail(mail);
							}
						}
					}
				}
				
				/* Migration status check */
				
				if(entry.getAttribute("challengeQuestion1")==null && entry.getAttribute("challengeQuestion2")==null
						&& entry.getAttribute("challengeQuestion3")==null && entry.getAttribute("challengeAnswer1")==null && entry.getAttribute("challengeAnswer2")==null
						&& entry.getAttribute("challengeAnswer3")==null){
						user.setPreMigrationFlag(true);
					
				}
				else
				{
					user.setPreMigrationFlag(false);
				}
				
				users.add(user);
			}
			ld.disconnect();
			
			for (OUDExtUser oudExtUser : users) {
				if(oudExtUser.getUserId().equals("0"))
					System.out.println("skip");
				System.out.println("UID "+oudExtUser.getUserId());
				System.out.println("Given Name "+oudExtUser.getGivenName());
				System.out.println("Mail "+oudExtUser.getMail());
				System.out.println("Pre-Migration Flag "+oudExtUser.getPreMigrationFlag());
				System.out.println("-------------------------------------");
			}
			
			
		}
		catch(LDAPException e) {
			e.printStackTrace();
			users=null;
			return users;
			
		}
		return users;
	}
	
	public synchronized boolean modifyEmailUsingUid(String userId, String email) {
		
		try {
				LDAPConnection ld = new LDAPConnection();
				/* Connect to the OUD Server */
				ld.connect("gcolqaidm3.dev.psegliny", 1389);
				
				
				String myDN = "uid=" + userId + "," + "cn=users" + "," + "dc=dev,dc=psegliny";
				LDAPAttribute attrEmail = new LDAPAttribute("mail", email);
				LDAPModification emailChange = new LDAPModification(LDAPModification.REPLACE, attrEmail);
				
				
				ld.authenticate("cn=Directory Manager", "qat@dm1n");
				
				ld.modify(myDN, emailChange);
				
				ld.disconnect();
				
				System.out.println("Successfully modifed email for userID " +userId);
				return true;
			}
		catch(LDAPException le) {
			System.out.println("Error Changing password" +le);
			return false;
		}
			
				
		
	}
	
	
public synchronized boolean deleteEmailUsingUid(String userId) {
		
		try {
				LDAPConnection ld = new LDAPConnection();
				/* Connect to the OUD Server */
				ld.connect("gcolqaidm3.dev.psegliny", 1389);
				
				
				String myDN = "uid=" + userId + "," + "cn=users" + "," + "dc=dev,dc=psegliny";
				ld.authenticate("cn=Directory Manager", "qat@dm1n");
				
				String SEARCH_FILTER = "uid=" + userId;
				String SEARCH_BASE = "cn=users" + "," + "dc=dev,dc=psegliny";
				LDAPSearchResults results = ld.search(SEARCH_BASE, LDAPConnection.SCOPE_SUB, SEARCH_FILTER, null, false);
				
				if(!results.hasMoreElements()) {
					System.out.println("The user "+userId+" does not exist");
					return false;
				}
				
				else {
				
					ld.delete(myDN);
					ld.disconnect();
					
					System.out.println("Successfully deleted user " +userId);
					return true;
				}
			}
		catch(LDAPException le) {
			System.out.println("Error deleting user" +le);
			return false;
		}
			
				
		
	}


	public synchronized boolean toPreMigration(String userId) {
		try {
			LDAPConnection ld = new LDAPConnection();
			/* Connect to the OUD Server */
			ld.connect("gcolqaidm3.dev.psegliny", 1389);
			
			
			String myDN = "uid=" + userId + "," + "cn=users" + "," + "dc=dev,dc=psegliny";
			ld.authenticate("cn=Directory Manager", "qat@dm1n");
			
			String SEARCH_FILTER = "uid=" + userId;
			String SEARCH_BASE = "cn=users" + "," + "dc=dev,dc=psegliny";
			LDAPSearchResults results = ld.search(SEARCH_BASE, LDAPConnection.SCOPE_SUB, SEARCH_FILTER, null, false);
			
			
			if(results.hasMoreElements()) {
				
				LDAPEntry entry = (LDAPEntry)results.nextElement();
				if(entry.getAttribute("addFlag")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("addFlag"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("challengeAnswer1")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("challengeAnswer1"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("challengeAnswer2")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("challengeAnswer2"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("challengeAnswer3")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("challengeAnswer3"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("challengeQuestion1")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("challengeQuestion1"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("challengeQuestion2")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("challengeQuestion2"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("challengeQuestion3")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("challengeQuestion3"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("postalCode")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("postalCode"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("ssnIdentifier")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("ssnIdentifier"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("userPassword")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("userPassword"));
					ld.modify(myDN, mod);
				}
				if(entry.getAttribute("passwordResetRetryAttempts")!=null){
					LDAPModification mod = new LDAPModification(LDAPModification.DELETE, new LDAPAttribute("passwordResetRetryAttempts"));
					ld.modify(myDN, mod);
				}
				
				
			}
			return true;
		}
		catch(LDAPException le) {
			System.out.println("Error reverting to pre-migration state user" +le);
			return false;
		}
		
	}

}
