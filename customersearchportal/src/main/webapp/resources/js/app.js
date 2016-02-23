var app = angular.module('myApp', ['ngRoute']);

app.config(function($routeProvider) {
  $routeProvider.when('/index', {
    templateUrl: 'login',
    controller: 'loginCtrl'
  });
  
  $routeProvider.when('/index2', {
	    templateUrl: 'index',
	    controller: 'AppCtrl'
	  });
  $routeProvider.when('/', {
    templateUrl: 'index2',
    controller: 'HomeCtrl'
  });
  $routeProvider.otherwise({ redirectTo: '/index' });
});

app.run(function(authentication, $rootScope, $location) {
  $rootScope.$on('$routeChangeStart', function(evt) {
    if(!authentication.isAuthenticated){ 
      $location.url("/login");
    }
    event.preventDefault();
  });
})

app.controller('loginCtrl', function($scope, $http, $location, authentication) {
  $scope.login = function() {
    if ($scope.username === 'admin' && $scope.password === 'pass') {
      console.log('successful')
      authentication.isAuthenticated = true;
      authentication.user = { name: $scope.username };
      $location.url("/index2");
    } else {
      $scope.loginError = "Invalid username/password combination";
      console.log('Login failed..');
    };
  };
});

app.factory('authentication', function() {
	  return {
	    isAuthenticated: false,
	    user: null
	  }
	});

app.controller('AppCtrl', function($scope, authentication, $http) {
  $scope.templates =
  [
  	{ url: 'login' },
  	{ url: 'index2' }
  ];
    $scope.template = $scope.templates[0];
    
    $scope.login = function ( username, password) {
    	
    	$http.post('http://localhost:8001/customersearchportal/searchportal/login?userid='+username+'&password='+password)
        .success(function (data) {
         console.log(data);
   		$scope.template = $scope.templates[1];

       //  $scope.tables.reload();
           
        })
        .error(function (data, status, headers, config) {
            //  Do some error handling here
        	console.log('invalid login');
        });
    	
    }
    
    /*
   $scope.login = function (username, password) {
    if ( username === 'admin' && password === '1234') {
  		authentication.isAuthenticated = true;
  		$scope.template = $scope.templates[1];
  		//$scope.user = username;
    } else {
  		$scope.loginError = "Invalid username/password combination";
    };
  }; */
  
//});

/*app.controller('HomeCtrl', function($scope, authentication) {
  $scope.user = authentication.user.name;
  
}); */



//angular.module('plunker', []).
//app.controller('HomeCtrl', function($scope,$http) {

$scope.user = {};
$scope.edit = true;
$scope.error = false;
$scope.incomplete = false; 
$scope.hideform = true; 
$scope.tabledata=true;

$scope.searchUser=function(){
console.log('clicked');
$scope.users = null;
 $http.post('http://localhost:8001/customersearchportal/searchportal/search?query='+$scope.user.username)
         .success(function (data) {
        	 console.log('returned');

           console.log(angular.toJson(data));
           $scope.tabledata = false;
                       $scope.users=data;
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
        	 console.log('errored');

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
$http.post('http://localhost:8001/customersearchportal/searchportal/modifyEmail?userid='+$scope.user.useridedit+'&emailid='+$scope.user.emailedit)
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
$http.post('http://localhost:8001/customersearchportal/searchportal/delete?userid='+$scope.users[id].userId)
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
$http.post('http://localhost:8001/customersearchportal/searchportal/preMigration?userid='+$scope.users[id].userId)
         .success(function (data) {
          console.log(data);
          $scope.tables.reload();
            
         })
         .error(function (data, status, headers, config) {
             //  Do some error handling here
         });

} 

}); 
