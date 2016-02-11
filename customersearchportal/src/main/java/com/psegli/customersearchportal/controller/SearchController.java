package com.psegli.customersearchportal.controller;

import com.google.gson.Gson;
import com.psegli.customersearchportal.dao.LDAPInterface;
import com.psegli.customersearchportal.dao.LDAPInterfaceImpl;
import com.psegli.customersearchportal.model.OUDExtUser;


import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/searchportal/")
public class SearchController {
	
	


	@RequestMapping(method=RequestMethod.GET,value="searchUser")
	public String searchPage(){
		return "searchUser";
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="searchresults")
	public String searchresultsPage(){
		return "searchresults";
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="home")
	public String home(){
		return "home";
		
	}
	
	@RequestMapping(method=RequestMethod.POST,value="search",produces="application/json; charset=utf-8")
	@ResponseBody
	public String searchUser(@RequestParam(value="query") String query){
		System.out.println("In Search Method");
        List<OUDExtUser> result = new ArrayList<OUDExtUser>();
		LDAPInterface ldap = new LDAPInterfaceImpl();
		result = ldap.searchLDAPByUid(query);
		System.out.println(new Gson().toJson(result));
		String output = new Gson().toJson(result);
		return output;
		
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="deleteUser")
	public String deleteUserPage(){
		return "deleteUser";
		
	}
	
	@RequestMapping(method=RequestMethod.POST,value="delete")
	@ResponseBody
	public String deleteUser(@RequestParam(value="userid") String userId) {
		System.out.println("In Delete");
		LDAPInterface ldap = new LDAPInterfaceImpl();
		boolean result = ldap.deleteEmailUsingUid(userId);
		
		if(result) {
			return "Successfully deleted user "+userId;
			
		}
		else
			return "User "+userId+" does not exist";
		
	}
	
	@RequestMapping(method=RequestMethod.POST,value="preMigration")
	@ResponseBody
	public String toPreMigration(@RequestParam(value="userid") String userId) {
		System.out.println("In Premigration");
		
		LDAPInterface ldap = new LDAPInterfaceImpl();
		boolean result = ldap.toPreMigration(userId);
		
		if(result) {
			return "Successfully reverted user "+userId;
			
		}
		else
			return "User "+userId+" could not be reverted back";
		
		
	}
	
}
