$(document).ready(function(){  
              $(".uname").change(function(){ 
              	  var contextPath ="http://localhost:8080/customersearchportal"
                  var uname = 'sarb';
                  var ajaxurl = contextPath+"/searchportal/search";
                  if(uname.length >= 3 && uname.length <= 10){  
                       $.ajax({  
                          type: "POST",  
                          url: ajaxurl,  
                          data: "query="+ uname,  
                          success: function(response){  
                           console.log(response);
  								
                               
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
