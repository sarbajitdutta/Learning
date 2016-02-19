<!DOCTYPE html>
<html>
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script>
angular.module('myApp', []).controller('userCtrl', function($scope,$http) {

$scope.user = {};
$scope.edit = true;
$scope.error = false;
$scope.incomplete = false; 
$scope.hideform = true; 
$scope.tabledata=true;

$scope.searchUser=function(){
console.log('clicked');
$scope.users = null;
 $http.post('http://localhost:8080/customersearchportal/searchportal/search?query='+$scope.user.username)
         .success(function (data) {
           console.log(angular.toJson(data));
           $scope.tabledata = false;
                       $scope.users=data;
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
         });

}


$scope.editUser = function(id) {
console.log(id);
$scope.hideform=false;
//$scope.editemail =$scope.users[]
$scope.user.useridedit = $scope.users[id].userId;
$scope.user.nameedit = $scope.users[id].givenName;
$scope.user.emailedit=$scope.users[id].mail;
console.log($scope.user.emailedit);
};

$scope.editUserSave = function(id,email) {
console.log('inside edit'+id);
console.log($scope.user.email);
$http.post('http://localhost:8080/customersearchportal/searchportal/modifyEmail?userid='+$scope.user.useridedit+'&emailid='+$scope.user.emailedit)
         .success(function (data) {
          console.log(data);
            
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
         });

} 


}); 
</script>
<body ng-app="myApp" ng-controller="userCtrl" >

  <form ng-submit="searchUser()">
    <input class="w3-input w3-border" type="text" ng-model="user.username" ng-disabled="!edit" placeholder="Search for user">
        <button type="submit" class="btn btn-primary">Submit</button>
    
</form>

<div class="w3-container">

<h3>Users</h3>

<table class="w3-table w3-bordered w3-striped" ng-hide="tabledata">
  <tr>
    <th>Edit</th>
    <th>User ID</th>
    <th>givenName</th>
    <th>mail</th>
    <th> Migration Flag </th>
  </tr>
  <tr ng-repeat="user in users ">
    <td>
      <button class="w3-btn w3-ripple" ng-click="editUser(user.id)">&#9998; Edit</button>
    </td>
    <td>{{ user.userId }}</td>
    <td>{{ user.givenName }} </td>
    <td>{{ user.mail}} </td>
    <td> {{user.preMigrationFlag}} </td>
  </tr>
</table>
<br>



<form ng-hide="hideform" ng-submit=editUserSave()>
  <h3 ng-hide="edit">Edit User:</h3>
   <label>User ID</label>
    <input class="w3-input w3-border" type="text" ng-model="user.useridedit" ng-disabled="edit" placeholder="New Email ID">
  <br>
   <label>Given Name</label>
    <input class="w3-input w3-border" type="text" ng-model="user.nameedit" ng-disabled="edit" placeholder="New Email ID">
  <br>
    <label>Email ID</label>
    <input class="w3-input w3-border" type="text" ng-model="user.emailedit" ng-disabled="!edit" placeholder="New Email ID">
  <br>
   
<button type="submit" class="w3-btn w3-green w3-ripple" ng-disabled="error || incomplete">&#10004; Save Changes</button>
</form>

</div>


</body>
</html>