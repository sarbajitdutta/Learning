<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search User</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<style>
.box{
    display: none;
    width: 100%;
}

a:hover + .box,.box:hover{
    display: block;
    position: relative;
    z-index: 100;
}

</style>

<script type="text/javascript">  
          $(document).ready(function(){  
              $(".uname").change(function(){ 
              	  var contextPath ="<%=request.getContextPath()%>";
                  var uname = $(this).val();
                  var ajaxurl = contextPath+"/searchportal/search";
                  if(uname.length >= 3 && uname.length <= 10){  
                      $(".status").html("<img src='"+contextPath+"/resources/images/loading.gif'><font color=gray> Checking availability...</font>");  
                       $.ajax({  
                          type: "POST",  
                          url: ajaxurl,  
                          data: "query="+ uname,  
                          success: function(response){  
                              var i,out;
                              out="<table>";
                              for(i=0;i<response.length;i++){
								out +="<tr><td>"+
								response[i].userId+
								"</td><td>"+
								response[i].givenName+
								"</td><td>"+
								response[i].mail+
								"</td>"+
								"<td>"+
								response[i].preMigrationFlag+
								"</td><td>"+
								"<a href="+contextPath+"/searchportal/home>Modify</a><div class=box><iframe src=http://10.1.90.243:8080/customersearchportal/searchportal/home width=250px height=150px></iframe></div>"
								+"</td></tr>";
							}
								out+="</table>";
								if(response.length<1){
									$(".status").html("<font color=red>No Search Result.</font>");
								}
								
                              $(".result").html(out);
                              
  								
                               
                          }  
                      });   
                  }  
                  else{  
                       if(uname.length <3){
                       	
                    	   $(".status").html("<font color=red>Username should be atleast <b>3</b> character long.</font>");
                       }
                       
                  }  
                    
              });  
          });  
</script>

</head>
<body>
Search for users: <input type="text" class="uname"/> <span class="status"></span>
<div class="result">
</div>

</body>
</html>