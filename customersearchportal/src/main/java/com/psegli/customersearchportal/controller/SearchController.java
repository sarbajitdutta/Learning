package com.psegli.customersearchportal.controller;

import com.google.gson.Gson;
import com.psegli.customersearchportal.dao.LDAPInterface;
import com.psegli.customersearchportal.dao.LDAPInterfaceImpl;
import com.psegli.customersearchportal.model.OUDExtUser;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/searchportal/")
public class SearchController {
	
	
	//Added comments
	


	@RequestMapping(method=RequestMethod.GET,value="searchUser")
	public String searchPage(){
		return "searchUser";
		
	}
	
	
	@RequestMapping(method=RequestMethod.GET,value="index2")
	public String indexPage(){
		return "index2";
		
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
	public boolean deleteUser(@RequestParam(value="userid") String userId) {
		System.out.println("In Delete");
		LDAPInterface ldap = new LDAPInterfaceImpl();
		boolean result=true; //= ldap.deleteEmailUsingUid(userId);
		
		if(result) {
			return true;
			
		}
		else
			return false;
		
	}
	
	@RequestMapping(method=RequestMethod.POST,value="modifyEmail")
	@ResponseBody
	public boolean modifyEmailId(@RequestParam(value="userid") String userId, @RequestParam(value="emailid") String emailId) {
		System.out.println("In Mofidy");
		LDAPInterface ldap = new LDAPInterfaceImpl();
		boolean result = ldap.modifyEmailUsingUid(userId, emailId);
		
		if(result) {
			return true;
			
		}
		else
			return false;
		
	}
	
	@RequestMapping(method=RequestMethod.POST,value="preMigration")
	@ResponseBody
	public boolean toPreMigration(@RequestParam(value="userid") String userId) {
		System.out.println("In Premigration");
		
		LDAPInterface ldap = new LDAPInterfaceImpl();
		boolean result = ldap.toPreMigration(userId);
		
		if(result) {
			return true;
			
		}
		else
			return false;
		
		
	}
	
	@RequestMapping(method=RequestMethod.POST,value="login")
	@ResponseBody
	public boolean verifyCredentials(@RequestParam(value="userid") String userId, @RequestParam(value="password") String password, HttpServletRequest request) {
		System.out.println("In login");
		
		if(userId.equalsIgnoreCase("adminsearch") && password.equals("Admin@U$3r"))
		{
			request.getSession().setAttribute("username", userId);
			request.getSession().setAttribute("role", "admin");
			request.getSession().setMaxInactiveInterval(3600);
			
			return true;
		}
		
		else if(userId.equalsIgnoreCase("repsearch") && password.equals("R3pS3a@ch!"))
		{
			request.getSession().setAttribute("username", userId);
			request.getSession().setAttribute("role", "representative");
			request.getSession().setMaxInactiveInterval(3600);
			
			return true;
		}
		
		else
		{
			return false;
		}
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="logout")
	public String logoutUser(HttpServletRequest request) {
		request.getSession().removeAttribute("username");
		request.getSession().removeAttribute("role");
		request.getSession().invalidate();
		
		return "redirect:/login";
		
	}
	
}
