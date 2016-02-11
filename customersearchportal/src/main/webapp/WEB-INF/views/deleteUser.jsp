<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete User</title>

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
                  var ajaxurl = contextPath+"/searchportal/preMigration";
                  if(uname.length >= 3){  
                      $(".status").html("<img src='"+contextPath+"/resources/images/loading.gif'><font color=gray> Checking availability...</font>");  
                       $.ajax({  
                          type: "POST",  
                          url: ajaxurl,  
                          data: "userid="+ uname,  
                          success: function(response){  
								
                              $(".status").html(response);
                              
  								
                               
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