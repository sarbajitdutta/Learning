
	<style media="screen" type="text/css">

body {
	margin:0;
	padding:0;
}

/* Start of Column CSS */
#container2 {
	clear:left;
	float:left;
	width:100%;
	overflow:hidden;
	background:#ffa7a7; /* column 2 background colour */
}
#container1 {
	float:left;
	width:100%;
	position:relative;
	right:50%;
	background:#fff689; /* column 1 background colour */
}
#col1 {
	float:left;
	width:60%;
	position:relative;
	left:52%;
	overflow:hidden;
}
#col2 {
	float:left;
	width:40%;
	position:relative;
	left:56%;
	overflow:hidden;
}

    </style>
</head>
<body id="active2">
<!-- ng-app="searchusers" ng-controller="searchCtrl" > -->
<div ng-app="searchusers" ng-controller="searchCtrl" style="width: 35%;margin-top: 20px;">
  <form ng-submit="searchUser()" >
    <input class="w3-input w3-border" type="text" ng-model="user.username" ng-disabled="!edit" placeholder="Search for user">
        <button type="submit" class="btn btn-primary">Submit</button>
   

<div id="container2">
	<div id="container1">
		<div id="col1">
			<!-- Column one start -->
			<div class="tablecontents col1" ng-hide="tabledata" >
<h3> Users</h3>
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
      <p ng-switch-when="false"> <button class="w3-btn w3-ripple" ng-click="changeFlag(user.id)" > Change</button> </p>
    </td>
  </tr>
</table>
<br>


</div>

			<!-- Column one end -->
		</div>
		<div id="col2">
			<!-- Column two start -->
			
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
			
			<!-- Column two end -->
		</div>
	</div>
</div>


</body>
