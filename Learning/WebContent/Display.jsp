<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<c:if test="${applicationScope.snapshot==null }">
<c:out value="Could not connect to DB"></c:out><br/>

<c:out value="${requestScope.name} Found"></c:out>

</c:if>

<c:if test="${applicationScope.snapshot!=null }">

<sql:query var="userlist" dataSource="${applicationScope.snapshot}">
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
</c:if>
</body>
</html>