<!DOCTYPE html>
<html>
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script src="http://localhost:8080/customersearchportal/resources/js/userManage.js"></script>

<body ng-app="myApp" ng-controller="userCtrl" >

  <form ng-submit="searchUser()">
    <input class="w3-input w3-border" type="text" ng-model="user.username" ng-disabled="!edit" placeholder="Search for user">
        <button type="submit" class="btn btn-primary">Submit</button>
    
</form>

<div class="w3-container">
<div class="tablecontents" ng-hide="tabledata" >
<h3> Users</h3>
<table class="w3-table w3-bordered w3-striped" ng-table="tables" >

  <tr>
  
    <th>User ID</th>
    <th>Given Name</th>
    <th>E-mail</th>
    <th> Migration Flag </th>
      <th>Edit</th>
    <th> Delete </th>
    <th> Change Migration Status </th>
  </tr>
  <tr ng-repeat="user in users ">
    
    <td>{{ user.userId }}</td>
    <td>{{ user.givenName }} </td>
    <td>{{ user.mail}} </td>
    <td ng-model="user.preMigrationFlag" ng-switch="user.preMigrationFlag">
    <p ng-switch-when="true">Pre Migration</p> <p ng-switch-when="false"> Post Migration </p> </td>
    <td>
      <button class="w3-btn w3-ripple" ng-click="editUser(user.id)">&#9998; Edit</button>
    </td>
     <td>
      <button class="w3-btn w3-ripple" ng-click="removeRow(user.id)" > Delete</button>
    </td>
        <td ng-model="user.preMigrationFlag" ng-switch="user.preMigrationFlag">
      <p ng-switch-when="false"> <button class="w3-btn w3-ripple" ng-click="changeFlag(user.id)" > Change</button> </p>
    </td>
  </tr>
</table>
<br>

</div>

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