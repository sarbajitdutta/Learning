package com.sd.tutorialpoint;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RestAuthenticationFilter implements javax.servlet.Filter {
	public static final String AUTHENTICATION_HEADER = "Authorization";
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filter) throws ServletException, IOException {
		if(request instanceof HttpServletRequest) {
			HttpServletRequest httpServletRequest = (HttpServletRequest) request;
			String authCredentials = httpServletRequest.getHeader(AUTHENTICATION_HEADER);
			System.out.println(authCredentials);
			AuthenticationService a = new AuthenticationService();
			boolean authenStatus = a.authenticate(authCredentials);
			
			if(authenStatus) {
				filter.doFilter(request, response);
			}
			
			else {
				if (response instanceof HttpServletResponse) {
					HttpServletResponse httpServletResponse = (HttpServletResponse) response;
					httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
					PrintWriter out = httpServletResponse.getWriter();
					out.println("<font color = red><b>You are not authorized!!</b></font>");
				}
			}
			
		}
	}
	
	@Override
	public void destroy() {
		
	}
	@Override
	public void init(FilterConfig arg0) throws ServletException {
		
	}

}
