var searchusers = angular.module('searchusers', ['ngRoute', 'ngCookies','ngMessages','ngMaterial']);

searchusers.config(['$routeProvider', function($routeProvider) {
    $routeProvider

        .when('/index', {
        templateUrl: 'index',
        controller: 'indexCtrl',

    })

    .when('/searchpage', {
        templateUrl: 'searchpage',
        controller: 'searchCtrl'
    })

    $routeProvider.otherwise({
        redirectTo: '/searchpage'
    });



}]);

searchusers.run(function($rootScope, $location, $cookies) {

    $rootScope.$on('$routeChangeStart', $cookies, function(evt) {

        if ($cookies.get('loggedIn')) {
            $location.path("searchpage");
        } else {
            $location.path("searchpage");
        }
        event.preventDefault();
    });
})

searchusers.controller('indexCtrl', function($scope, $http, $location, $cookies, $window,$mdDialog) {
    $scope.message = 'Welcome to homepage';
    $scope.loggedIn='false';
    $scope.templates = [{
        url: 'login'
    }, {
        url: 'searchpage'
    }];
    if (!$cookies.get('loggedIn')) {
        $scope.template = $scope.templates[0];
        $scope.login = function(username, password) {
            $http.post('http://localhost:8001/customersearchportal/login?userid=' + username + '&password=' + password)
                .success(function(data) {
                    console.log(data);
                    if (data == true) {
                        $cookies.put('loggedIn', 'true');
                        $scope.loggedIn = $cookies.get('loggedIn');
                        $scope.template = $scope.templates[1];
                        $scope.username=username;

                    } else {
                  
                    	   $mdDialog.show(
                    			      $mdDialog.alert()
                    			        .parent(angular.element(document.querySelector('#popupContainer')))
                    			        .clickOutsideToClose(true)
                    			        .title('Customer Management Portal')
                    			        .textContent('The username/password combination is incorrect')
                    			        .ok('Got it!')
                    			    );
                        $scope.template = $scope.templates[0];
                    }
                })
                .error(function(data, status, headers, config) {
                    
                });
        };
    } else {
        $scope.loggedIn = $cookies.get('loggedIn');
        $scope.template = $scope.templates[1];
    }



    
    $scope.user = {};
    $scope.edit = true;
    $scope.error = false;
    $scope.incomplete = false;
    $scope.hideform = true;
    $scope.tabledata = true;
    $scope.user.emailedit =' ';



    $scope.searchUser = function() {
        $scope.users = null;
        $http.post('http://localhost:8001/customersearchportal/search?query=' + $scope.user.username)
            .success(function(data) {
                if(data.length > 0  ) {
               	$scope.tablemsg = 1;
                $scope.tabledata = false;
                $scope.users = data;
                } else {
                	$scope.tablemsg = 0;
                }
            })
            .error(function(data, status, headers, config) {
                console.log('errored');

            });

    }


    $scope.editUser = function(id) {
        $scope.hideform = false;
        $scope.user.useridedit = $scope.users[id].userId;
        $scope.user.nameedit = $scope.users[id].givenName;
        $scope.user.emailedit = $scope.users[id].mail;
    };

    $scope.logOut = function() {
     $cookies.remove('loggedIn');
     $http.post('http://localhost:8001/customersearchportal/logout')
     .success(function(data) {
         
         $scope.template = $scope.templates[0];
         
         $window.location.reload();

         

     })
     .error(function(data, status, headers, config) {
     });

    };
    
    
    $scope.editUserSave = function(id, email,ev) {
    	
    	var confirm = $mdDialog.confirm()
    			  .title('Customer Management Portal')
    			  .textContent('Do you want to make the changes?')
                  .ariaLabel('Lucky day')
                  .targetEvent(ev)
 			      .ok('Got it!')
 			      .cancel('Cancel');
    	
    	$mdDialog.show(confirm).then(function() {
    	      
    		 $http.post('http://localhost:8001/customersearchportal/modifyEmail?userid=' + $scope.user.useridedit + '&emailid=' + $scope.user.emailedit)
             .success(function(data) {
             
             	 $mdDialog.show(
        			      $mdDialog.alert()
        			        .parent(angular.element(document.querySelector('#popupContainer')))
        			        .clickOutsideToClose(true)
        			        .title('Customer Management Portal')
        			        .textContent('Changes have been saved!')
        			        .ok('Got it!')
        			    );
                

             })
             .error(function(data, status, headers, config) {
                 
             });
    	    }, function() {
    	     
    	    });
    	
       

    }

    $scope.removeRow = function(id, ev) {
    	
    	
    	var confirm = $mdDialog.confirm()
		  .title('Customer Management Portal')
		  .textContent('Do you want to delete the user?')
        .ariaLabel('Lucky day')
        .targetEvent(ev)
	      .ok('Got it!')
	      .cancel('Cancel');
    	
    	
    	  $mdDialog.show(confirm).then(function() {
    	    
    		  $http.post('http://localhost:8001/customersearchportal/delete?userid=' + $scope.users[id].userId)
              .success(function(data) {

              	 $mdDialog.show(
         			      $mdDialog.alert()
         			        .parent(angular.element(document.querySelector('#popupContainer')))
         			        .clickOutsideToClose(true)
         			        .title('Customer Management Portal')
         			        .textContent('The userid '+$scope.users[id].userId+' has been deleted!')
         			        .ok('Got it!')
         			    );
                  
              })
              .error(function(data, status, headers, config) {
              });
    	    }, function() {
    	    
    	    });
    	  }

    $scope.changeFlag = function(id, ev) {
    	
    	
    	var confirm = $mdDialog.confirm()
		  .title('Customer Management Portal')
		  .textContent('Do you want to revert the user to pre-migration state?')
      .ariaLabel('Lucky day')
      .targetEvent(ev)
	      .ok('Got it!')
	      .cancel('Cancel');
        
    	
    	$mdDialog.show(confirm).then(function() {
        $http.post('http://localhost:8001/customersearchportal/preMigration?userid=' + $scope.users[id].userId)
            .success(function(data) {
                
                
            	$mdDialog.show(
       			      $mdDialog.alert()
       			        .parent(angular.element(document.querySelector('#popupContainer')))
       			        .clickOutsideToClose(true)
       			        .title('Customer Management Portal')
       			        .textContent('The userid '+$scope.users[id].userId+' has been reverted to pre-migration state!')
       			        .ok('Got it!')
       			    );
                

            })
            .error(function(data, status, headers, config) {
            });
    	 }, function() {
     	    
 	    });

    }
    
   
    
   
})





searchusers.directive('ngConfirmMessage', ['$mdDialog',function($mdDialog) {
    return {
       // restrict: 'A',
        link: function(scope, element, attrs) {
            element.on('click', function(e) {
               var message = attrs.ngConfirmMessage || "Are you sure you want to save the changes ?";
            	
              if (!confirm(message)) {
                  e.stopImmediatePropagation();
                }
            });
        }
    }
}]);