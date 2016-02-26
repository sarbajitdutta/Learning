<h1>Login Page</h1>
<center>
<form ng-submit="login(username, password)" class="ng-scope ng-pristine ng-valid">
  <label>User name</label>
  <input type="text" ng-model="username" class="ng-pristine ng-valid">
  <label>Password</label>
  <input type="password" ng-model="password" class="ng-pristine ng-valid">
  <br/>
  {{loginError}}  {{loggedUser}}
  <br/><br/>
  <button class="btn btn-success" ng-click="">Submit</button> 
  </form></center>