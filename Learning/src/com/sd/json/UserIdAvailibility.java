package com.sd.json;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sd.db.DBConnectionManager;

/**
 * Servlet implementation class UserIdAvailibility
 */
@WebServlet(name="UserIdAvailibility",
		urlPatterns =  {"/useridAvail"})
public class UserIdAvailibility extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserIdAvailibility() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		response.setContentType("text/html;charset=UTF-8");  
        PrintWriter out = response.getWriter(); 
        String uname = request.getParameter("uname");
        /*try {
        String connectionUrl = "jdbc:oracle:thin:@pl-dv-emtr-db1.dev.psegliny:1521:COBRA";
        Connection con = null;
        Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
        con = DriverManager.getConnection(connectionUrl,"DTS","DTS");
        String uname = request.getParameter("uname");
        System.out.println(uname);
        PreparedStatement ps = con.prepareStatement("select username from tblusernames where username = ?");
        ps.setString(1, uname);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {  
            out.println("<font color=green><b>"+uname+"</b> is avaliable</font>");  
        }  
        else{  
        out.println("<font color=red><b>"+uname+"</b> is already in use</font>");  
        }  
        out.println();
        rs.close();
        ps.close();
        con.close();
        }
        catch(Exception e) {
        	out.println("Error ->" + e.getMessage());
        }
        finally {  
        	
        	out.close();  
        }  */
        try {
        DBConnectionManager conManager = (DBConnectionManager)getServletContext().getAttribute("dbPool");
        Connection con = conManager.getConnectionfromPool();
        PreparedStatement ps = con.prepareStatement("select username from tblusernames where username = ?");
        ps.setString(1, uname);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {  
            out.println("<font color=green><b>"+uname+"</b> is avaliable</font>");  
        }  
        else{  
        out.println("<font color=red><b>"+uname+"</b> is already in use</font>");  
        }  
        out.println();
        rs.close();
        ps.close();
        conManager.returnConnectionToPool(con);
        }
        catch(Exception e) {
        	out.println("Error ->" + e.getMessage());
        }
        finally {  
        	
        	out.close();  
        } 
	}

}
