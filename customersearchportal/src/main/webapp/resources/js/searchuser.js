var searchusers = angular.module('searchusers',['ngRoute']);

searchusers.config(function($routeProvider){
	$routeProvider
	
	.when('/index',{
		templateUrl :'index',
			controller: 'indexCtrl',
			access: {
					//authen
				
			}
	})
	
	.when ('/searchpage',{
		templateUrl: 'searchpage',
			controller: 'searchCtrl'
	} )
	
	$routeProvider.otherwise({redirectTo: '/searchpage'});


	
});

searchusers.run(function(authentication, $rootScope, $location) {
	  $rootScope.$on('$routeChangeStart', function(evt) {
	    if(authentication.isAuthenticated){ 
	      $location.url("searchpage");
	    }
	    event.preventDefault();
	  });
	})

searchusers.controller('indexCtrl',function($scope,$http,$location, authentication){
	console.log('auth is'+ authentication.isAuthenticated)
		$scope.message = 'Welcome to homepage';
		$scope.templates =
		  [
		  	{ url: 'login' },
		  	{ url: 'searchpage' }
		  ];
		if (!authentication.isAuthenticated){
			console.log('auth is1'+ authentication.isAuthenticated)

		    $scope.template = $scope.templates[0];
		  $scope.login = function (username, password) {
$http.post('http://localhost:8001/customersearchportal/searchportal/login?userid='+username+'&password='+password)
		        .success(function (data) {
		         console.log(data);
		         if ( data == true) {
		        	 authentication.isAuthenticated = true;
		 			console.log('auth done'+ authentication.isAuthenticated)

		   		$scope.template = $scope.templates[1];
		   		} else {
		   			$scope.template = $scope.templates[0];}
	        })
		        .error(function (data, status, headers, config) {
		            //  Do some error handling here
		        	console.log('invalid login');
		        });
		  }; 
		} else {
			console.log('auth is2'+ authentication.isAuthenticated)

   			$scope.template = $scope.templates[1];}
				
});


searchusers.controller('searchCtrl',function($scope,$http){
console.log('entered');
	$scope.user = {};
	$scope.edit = true;
	$scope.error = false;
	$scope.incomplete = false; 
	$scope.hideform = true; 
	$scope.tabledata=true;
	console.log($scope.tabledata);


	$scope.searchUser=function(){
	console.log('clicked');
	$scope.users = null;
	 $http.post('http://localhost:8001/customersearchportal/searchportal/search?query='+$scope.user.username)
	         .success(function (data) {
	        	 console.log('returned data');

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
	
	
})


searchusers.factory('authentication', function() {
  return {
    isAuthenticated: false,
    user: null
  }
});




searchusers.directive('ngConfirmMessage', [function () {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            element.on('click', function (e) {
                var message = attrs.ngConfirmMessage || "Are you sure ?";
                if (!confirm(message)) {
                    e.stopImmediatePropagation();
                }
            });
        }
    }
}]);