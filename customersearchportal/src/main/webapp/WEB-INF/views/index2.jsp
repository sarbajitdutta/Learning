<!DOCTYPE html>
<html>
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script>
$(document).ready(function(){  
                            	  var contextPath ="http://localhost:8080/customersearchportal"
                  var uname = 'jeff';
                  var ajaxurl = contextPath+"/searchportal/search";
                  if(uname.length >= 3 && uname.length <= 10){  
                       $.ajax({  
                          type: "POST",  
                          url: ajaxurl,  
                          data: "query="+ uname,  
                          success: function(response){  
                           console.log(response);
                               $resp = response;
                          //  console.log($scope[0].userId);
                          }  
                      });   
                  }  
                  else{  
                       if(uname.length <3){
                       	
                    	   $(".status").html("<font color=red>Username should be atleast <b>3</b> character long.</font>");
                       }
                       
                  }  
                    
              });  
          
          
</script>

<script>
angular.module('myApp', []).controller('userCtrl', function($scope,$http) {


$http.post('http://localhost:8080/customersearchportal/searchportal/search?query=jeff')
         .success(function (data) {
            // $scope.list = data.GetAllCustomersResult;
            console.log(data);
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
         });
$scope.users =

[{"userId":"jeffreysills","givenName":"test","mail":"nmohamed@mythics.com","preMigrationFlag":false},
{"userId":"jeffreysill1","givenName":"Jeffrey","mail":"jeffrey.sills@pseg.com","preMigrationFlag":true},
{"userId":"jefftest","givenName":"Jeffrey","mail":"jeffrey.sills@pseg.com","preMigrationFlag":true},
{"userId":"jeffsills","givenName":"Jeffrey","mail":"jeffrey.sills@pseg.com","preMigrationFlag":false},
{"userId":"jeffsills3","givenName":"Jeffrey","mail":"jeffrey.sills@pseg.com","preMigrationFlag":false}]

/*
{id:1, fName:'Hege', lName:"Pege" },
{id:2, fName:'Kim',  lName:"Pim" },
{id:3, fName:'Sal',  lName:"Smith" },
{id:4, fName:'Jack', lName:"Jones" },
{id:5, fName:'John', lName:"Doe" },
{id:6, fName:'Peter',lName:"Pan" }
]; */
$scope.edit = true;
$scope.error = false;
$scope.incomplete = false; 
$scope.hideform = true; 
$scope.editUser = function(id) {
  $scope.hideform = false;
  // (id == 'new') {
    $scope.edit = true;
    $scope.incomplete = true;
    $scope.email = $scope.users[userId].email;
 //   } else {
  //  $scope.edit = false;
  //  $scope.email = $scope.users[userId].email;
     
  
};

$scope.$watch('email',function() {$scope.test();});


$scope.test = function() {
  if ($scope.passw1 !== $scope.passw2) {
    $scope.error = true;
    } else {
    $scope.error = false;
  }
  $scope.incomplete = false;
  if ($scope.edit && (!$scope.fName.length ||
  !$scope.lName.length ||
  !$scope.passw1.length || !$scope.passw2.length)) {
     $scope.incomplete = true;
  }
}; 

}); 
</script>
<body ng-app="myApp" ng-controller="userCtrl" >

<div class="w3-container">

<h3>Users</h3>

<table class="w3-table w3-bordered w3-striped">
  <tr>
    <th>Edit</th>
    <th>User ID</th>
    <th>givenName</th>
    <th>mail</th>
    <th> Migration Flag </th>
  </tr>
  <tr ng-repeat="user in users">
    <td>
      <button class="w3-btn w3-ripple" ng-click="editUser(user.userId)">&#9998; Edit</button>
    </td>
    <td>{{ user.userId }}</td>
    <td>{{ user.givenName }} </td>
    <td>{{ user.mail}} </td>
    <td> {{user.preMigrationFlag}} </td>
  </tr>
</table>
<br>

<form ng-hide="hideform">
  <h3 ng-hide="edit">Edit User:</h3>
    <label>Email ID:</label>
    <input class="w3-input w3-border" type="text" ng-model="email" ng-disabled="!edit" placeholder="New Email ID">
  <br>
   
<button class="w3-btn w3-green w3-ripple" ng-disabled="error || incomplete">&#10004; Save Changes</button>
</form>

</div>


</body>
</html>