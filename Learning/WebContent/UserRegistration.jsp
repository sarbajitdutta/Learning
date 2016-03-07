<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Username Availability</title>  
<style type="text/css">  
.flable {  
 color: gray;  
}  
  
.status {  
 font-family: verdana;  
 font-size: 12px;  
}  
  
.uname {  
 color: blue;  
}  
</style>  
<script src="jquery.js" type="text/javascript"></script>  
 <script type="text/javascript">  
          $(document).ready(function(){  
              $(".uname").change(function(){  
                  var uname = $(this).val();
                  var ajaxurl = "http://localhost:8080/Learning/useridAvail";
                  if(uname.length >= 3 && uname.length <= 10){  
                      $(".status").html("<img src='images/loading.gif'><font color=gray> Checking availability...</font>");  
                       $.ajax({  
                          type: "POST",  
                          url: ajaxurl,  
                          data: "uname="+ uname,  
                          success: function(msg){  
  
                              $(".status").ajaxComplete(function(event, request, settings){  
                                     
                                  $(".status").html(msg);  
  
                              });  
                          }  
                      });   
                  }  
                  else{  
                       if(uname.length >10){
                    	   $(".status").html("<font color=red>Username should be atmost <b>10</b> character long.</font>");
                       }
                       else{
                      			$(".status").html("<font color=red>Username should be <b>3</b> character long.</font>");
                       }
                  }  
                    
              });  
          });  
        </script>  
</head>
<body>

<div>  
  <label class="flable">User Name :</label> <input class="uname" type="text"> <span class="status"></span>  
 </div> 


</body>
</html>