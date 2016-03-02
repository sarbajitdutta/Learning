<h1>Login Page</h1>
<center>
<form name="loginForm" ng-submit="login(username, password)" class="ng-scope ng-pristine ng-valid">
  <label>User name</label>
  <input type="text" ng-model="username" required="true" class="ng-pristine ng-valid">
  <label>Password</label>
  <input type="password" ng-model="password" required="true" class="ng-pristine ng-valid">
  <br/>
  {{loginError}}  {{loggedUser}}
  <br/><br/>
  <button class="w3-btn w3-green w3-ripple" ng-click="" ng-disabled="loginForm.$invalid">Submit</button> 
  </form></center>