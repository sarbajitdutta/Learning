<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>First Jstl</title>
</head>
<body>

<script language="javascript" type="text/javascript">
var ajaxRequest = new XMLHttpRequest();

ajaxRequest.onreadystatechange = function(){
	if(ajaxRequest.readyState==4 && ajaxRequest.status == 200){
		myFunction(ajaxRequest.responseText);
	}
}
	ajaxRequest.open("POST","http://localhost:8080/Learning/JsonImpl",true);
	ajaxRequest.send();
	
	function myFunction(response){
		

		var employee = JSON.parse(response);
		console.log(employee);
		var out ="<table>";
		var i;
		for(i=0;i<employee.length;i++){
			out +="<tr><td>"+
			employee[i].name+
			"</td><td>"+
			employee[i].age+
			"</td></tr>"
		}
		out+="</table>"
			document.getElementById("ajax").innerHTML = out;
		 
	}





</script>

<c:forEach var="i" begin="1" end="10" step="1">
	<c:out value="${i}" />
<br/>
</c:forEach>

<c:set var="name" value="${pageContext.request.contextPath}" scope="application" ></c:set>


<c:if test="${applicationScope.name == '8080' }" var = "res" scope="request">

<c:out value="${applicationScope.name} <b>Good</b>" escapeXml="false"></c:out><br/>
<c:out value="${requestScope.res }" />
</c:if>

<c:if test="${applicationScope.name!='8080' }">

<c:out value="${applicationScope.name} <b>Good</b>" escapeXml="false"></c:out><br/>

<c:out value="You are not local" escapeXml="false"></c:out>

</c:if>


<sql:setDataSource var="snapshot" driver="oracle.jdbc.driver.OracleDriver" 
url = "jdbc:oracle:thin:@pl-dv-emtr-db1.dev.psegliny:1521:COBRA"
user="DTS"
password="DTS"
scope="application"
/>

<sql:query var="userlist" dataSource="${snapshot}">
SELECT chuserid from tbluser where rownum<=5
</sql:query>


<table border ="1" width = "30%">
	<tr>
		<th>User ID</th>
	</tr>
	<c:forEach var="row" items="${userlist.rows}">
	<tr>
		<td><c:out value="${row.chuserid }"></c:out></td>
	<tr>
	</c:forEach>


</table>


<a href="Display.jsp">Display</a>
<input type='button'  value = "Click me" onclick='ajaxFunction()' />
<div id = "ajax"></div>

<br/>

<br/>

<c:set var="xmltext">
<employees>
	<employee>
		<name>Sarbajit Dutta</name>
		<age>25</age>
	</employee>
	<employee>
		<name>Sandeep TNVS</name>
		<age>26</age>
	</employee>
</employees>

</c:set>


<x:parse xml="${xmltext}" var="emp" />
	<b>The first Employee Name</b>
<%-- 	<x:out select="$emp/employees/employee[1]/name" /> --%>

<%-- <c:url value="/JsonImpl" var="url" /> --%>
<!-- <form name = "json" action = "JsonImpl" method="post"> -->
<!-- Name: -->
<!-- <input type = "text" name="name" /> -->
<!-- Age: -->
<!-- <input type = "text" name="age" /> -->

<!-- <input type="submit" value="Submit"/> -->

<!-- </form> -->



</body>
</html>