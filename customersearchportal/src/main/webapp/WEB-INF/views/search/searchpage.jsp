<div ng-app="searchusers" ng-controller="indexCtrl"  >
<center>
  <form ng-submit="searchUser()" name="searchForm" >
    <input name="searchField" style="width: 35%;margin-top: 20px;" class="w3-input w3-border" required="true" ng-minlength="4" type="text" ng-model="user.username" ng-disabled="!edit" placeholder="Search for user">
      </br>  <button type="submit" class="w3-btn w3-green w3-ripple" ng-disabled="searchForm.$invalid">Submit</button>
   
<!--      <pre>searchForm.searchField.$error = {{ searchForm.searchField.$error | json }}</pre> -->
   
  <div ng-messages="searchForm.searchField.$error" style="color:maroon" role="alert">
    <div ng-message="minlength">Please enter atleast 4 characters to perform a search</div>
  </div>
   
</form>
</center>

<div id="w3-container" ng-switch="tablemsg">

        <center ng-switch-when=0> </br></br>No users found for the search term <b>{{user.username}}</b>  !</center>

<div class="w3-row"  ng-switch-when=1 >
<hr>

			<!-- Column one start -->
			<div class="tablecontents w3-col l8" ng-hide="tabledata" style="padding-left: 10px;overflow-y:scroll;height: 440px;">
<table class="w3-table w3-bordered w3-striped " ng-table="tables"  >

  <tr>
  
    <th>User ID</th>
    <th>Given Name</th>
    <th>E-mail</th>
    <th> Migration Flag </th>
      <%if(request.getSession().getAttribute("role").equals("admin")) { %><th>Edit</th><%}else {}%>
    <%if(request.getSession().getAttribute("role").equals("admin")) { %><th> Delete </th><%}else {}%>
    <th> Change Migration Status </th>
  </tr>
  <tr ng-repeat="user in users track by $index ">
    
    <td>{{ user.userId }}</td>
    <td>{{ user.givenName }} </td>
    <td>{{ user.mail}} </td>
    <td ng-model="user.preMigrationFlag" ng-switch="user.preMigrationFlag">
    <p ng-switch-when="true">Pre Migration</p> <p ng-switch-when="false"> Post Migration </p> </td>
    <%if(request.getSession().getAttribute("role").equals("admin")) { %><td>
      <button class="w3-btn w3-ripple" ng-click="editUser(user.id)"> &#9998; Edit </button> 
    </td><%}else {}%>
    <%if(request.getSession().getAttribute("role").equals("admin")) { %>
     <td>
      <button class="w3-btn w3-ripple" ng-click="removeRow(user.id)"  > Delete</button>
    </td>
    <%}else {}%> 
        <td ng-model="user.preMigrationFlag" ng-switch="user.preMigrationFlag">
      <p ng-switch-when="false"> <button class="w3-btn w3-ripple" ng-click="changeFlag(user.id)"> Change</button> </p>
    </td>
  </tr>
</table>
<br>


</div>

<div class="w3-col l3" style="padding-left: 30px;">
			<form ng-hide="hideform" name="myForm">
  <h3 ng-hide="edit">Edit User:</h3>
   <label>User ID</label>
    <input class="w3-input w3-border" type="text" ng-model="user.useridedit" ng-disabled="edit" placeholder="User ID">
  <br>
   <label>Given Name</label>
    <input class="w3-input w3-border" type="text" ng-model="user.nameedit" ng-disabled="edit" placeholder="Given Name">
  <br>
    <label class>Email ID</label>
    <input type="email" required="true" class="w3-input w3-border "   ng-model="user.emailedit" ng-disabled="!edit" placeholder="New Email ID">
  
   
  <br>
   
<md-button type="submit" class="w3-btn w3-green w3-ripple " ng-disabled="myForm.$invalid" ng-click=editUserSave($event)  >&#10004; Save Changes</md-button>
</form>
</div>
			
			<!-- Column two end -->
	
</div>
</div>
</div>

</body>

