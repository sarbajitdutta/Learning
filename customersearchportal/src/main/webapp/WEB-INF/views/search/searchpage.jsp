


<!-- ng-app="searchusers" ng-controller="searchCtrl" > -->
<div ng-app="searchusers" ng-controller="searchCtrl" >
<center>
  <form ng-submit="searchUser()" >
    <input style="width: 35%;margin-top: 20px;" class="w3-input w3-border" type="text" ng-model="user.username" ng-disabled="!edit" placeholder="Search for user">
        <button type="submit" class="btn btn-primary">Submit</button>
   
</form>
</center>

<div id="w3-container" >
<div class="w3-row ">
<hr>
			<!-- Column one start -->
			<div class="tablecontents w3-col l7" ng-hide="tabledata" style="padding-left: 10px;overflow-y:scroll;height: 620px;">
<table class="w3-table w3-bordered w3-striped " ng-table="tables" >

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
      <p ng-switch-when="false"> <button class="w3-btn w3-ripple" ng-click="changeFlag(user.id)" ng-confirm-message> Change</button> </p>
    </td>
  </tr>
</table>
<br>


</div>

<div class="w3-col l4" style="padding-left: 30px;">
			<form ng-hide="hideform" ng-submit=editUserSave() >
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
			
			<!-- Column two end -->
	
</div>
</div>
</div>

</body>
