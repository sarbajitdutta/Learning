package com.psegli.customersearchportal.controller;

import com.google.gson.Gson;
import com.psegli.customersearchportal.dao.LDAPInterface;
import com.psegli.customersearchportal.dao.LDAPInterfaceImpl;
import com.psegli.customersearchportal.model.OUDExtUser;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/searchportal/")
public class SearchController {
	
	
	//Added comments
	
	private static final Logger log = Logger.getLogger(SearchController.class);
	


	@RequestMapping(method=RequestMethod.GET,value="searchUser")
	public String searchPage(){
		log.info("In SearchUser method");
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
	
	@RequestMapping(method=RequestMethod.GET,value="index")
	public String index(){
		return "index";
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="login")
	public String login(){
		return "login";
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="search/index")
	public String searchindex(){
		return "search/index";
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="search/")
	public String searchdefault(){
		return "search/index";
		
	}
	
	
	@RequestMapping(method=RequestMethod.GET,value="search/login")
	public String loginpage(){
		return "search/login";
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="search/searchpage")
	public String searchlogin(){
		return "search/searchpage";
		
	}
	
	
	
	
	
	@RequestMapping(method=RequestMethod.POST,value="search",produces="application/json; charset=utf-8")
	@ResponseBody
	public String searchUser(@RequestParam(value="query") String query, HttpServletRequest request){
		log.info(request.getRemoteAddr()+" Searching for user "+query);
        List<OUDExtUser> result = new ArrayList<OUDExtUser>();
		LDAPInterface ldap = new LDAPInterfaceImpl();
		result = ldap.searchLDAPByUid(query);
		if(!result.isEmpty()){
			log.info(request.getRemoteAddr()+" The search result for query string "+query+" contains "+result.size()+" results");
		}
		
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
	public boolean modifyEmailId(@RequestParam(value="userid") String userId, @RequestParam(value="emailid") String emailId, HttpServletRequest request) {
		log.info("To modify email of user - "+userId+" with new email - "+emailId);
		LDAPInterface ldap = new LDAPInterfaceImpl();
		boolean result = ldap.modifyEmailUsingUid(userId, emailId);
		
		if(result) {
			log.info("Successfully modified email for user "+userId);
			return true;
			
			
		}
		else {
			log.info("There was some problem in modifying email for user "+userId);
			return false;
		}
		
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
		log.info("Logging with user "+userId);
		
		if(userId.equalsIgnoreCase("adminsearch") && password.equals("Admin@U$3r"))
		{
			request.getSession().setAttribute("username", userId);
			request.getSession().setAttribute("role", "admin");
			request.getSession().setMaxInactiveInterval(3600);
			log.info("Successfully authenticated user "+userId+ " with admin role");
			
			return true;
		}
		
		else if(userId.equalsIgnoreCase("repsearch") && password.equals("R3pS3a@ch!"))
		{
			request.getSession().setAttribute("username", userId);
			request.getSession().setAttribute("role", "representative");
			request.getSession().setMaxInactiveInterval(3600);
			log.info("Successfully authenticated user "+userId+ " with representative role");
			
			return true;
		}
		
		else
		{	
			log.info("Authentication failure for user "+userId);
			return false;
		}
		
	}
	
	@RequestMapping(method=RequestMethod.GET,value="logout")
	public String logoutUser(HttpServletRequest request) {
		String userId = (String)request.getSession().getAttribute("username");
		request.getSession().removeAttribute("username");
		request.getSession().removeAttribute("role");
		request.getSession().invalidate();
		log.info("Logged out user "+userId);
		
		return "redirect:/login";
		
	}
	
}
