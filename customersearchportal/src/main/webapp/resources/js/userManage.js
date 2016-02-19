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
console.log($scope.user.mail);
$http.post('http://localhost:8080/customersearchportal/searchportal/modifyEmail?userid='+$scope.user.useridedit+'&emailid='+$scope.user.emailedit)
         .success(function (data) {
          console.log(data);
            
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
         });

} 

$scope.removeRow = function(id) {
console.log('inside delete'+id);
//console.log($scope.users[id].userId);
$http.post('http://localhost:8080/customersearchportal/searchportal/delete?userid='+$scope.users[id].userId)
         .success(function (data) {
          console.log(data);
          //$scope.tables.reload();
            
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
         });

} 

$scope.changeFlag = function(id) {
console.log('inside change'+id);
//console.log($scope.users[id].userId);
$http.post('http://localhost:8080/customersearchportal/searchportal/preMigration?userid='+$scope.users[id].userId)
         .success(function (data) {
          console.log(data);
          $scope.tables.reload();
            
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
         });

} 

}); 
