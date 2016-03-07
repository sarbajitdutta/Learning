package com.sd.tutorialpoint;

import java.io.IOException;
//import java.util.base64;
import java.util.StringTokenizer;

public class AuthenticationService {
	
	public boolean authenticate(String authCredentials) {
		
		if(null == authCredentials)
			return false;
		
		final String encodedUserPassword = authCredentials.replaceFirst("Basic"+" ", "");
		String usernamePassword = null;
		
		
		/*try{
			
			//byte[] decodedBytes = Base64.getDecoder().decode(encodedUserPassword);
			//usernamePassword = new String(decodedBytes, "UTF-8");
			System.out.println("Hello");
		}
		catch(IOException e){
			e.printStackTrace();
		}*/
		
		final StringTokenizer token = new StringTokenizer(usernamePassword, ":");
		final String username = token.nextToken();
		final String password = token.nextToken();
		
		boolean authenticationStatus = "admin".equals(username)&&"admin".equals(password);
		
		return authenticationStatus;
	}
	

}
