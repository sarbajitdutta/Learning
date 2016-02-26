var searchusers = angular.module('searchusers', ['ngRoute', 'ngCookies']);

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

searchusers.controller('indexCtrl', function($scope, $http, $location, $cookies) {
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
            $http.post('http://localhost:8001/customersearchportal/searchportal/login?userid=' + username + '&password=' + password)
                .success(function(data) {
                    console.log(data);
                    if (data == true) {
                        $cookies.put('loggedIn', 'true');
                        $scope.loggedIn = $cookies.get('loggedIn');
                        console.log("logged in value is "+$scope.loggedIn);
                        $scope.template = $scope.templates[1];
                    } else {
                        $scope.template = $scope.templates[1];
                    }
                })
                .error(function(data, status, headers, config) {
                    console.log('invalid login');
                });
        };
    } else {

        $scope.template = $scope.templates[1];
    }



    console.log('entered');
    console.log($scope.loggedIn);
    $scope.user = {};
    $scope.edit = true;
    $scope.error = false;
    $scope.incomplete = false;
    $scope.hideform = true;
    $scope.tabledata = true;
    console.log($scope.tabledata);


    $scope.searchUser = function() {
        console.log('clicked');
        $scope.users = null;
        $http.post('http://localhost:8001/customersearchportal/searchportal/search?query=' + $scope.user.username)
            .success(function(data) {
                console.log('returned data');

                console.log(angular.toJson(data));
                $scope.tabledata = false;
                $scope.users = data;
            })
            .error(function(data, status, headers, config) {
                console.log('errored');

            });

    }


    $scope.editUser = function(id) {
        console.log(id);
        $scope.hideform = false;
        $scope.user.useridedit = $scope.users[id].userId;
        $scope.user.nameedit = $scope.users[id].givenName;
        $scope.user.emailedit = $scope.users[id].mail;
        console.log($scope.user.emailedit);
    };

    $scope.logOut = function() {
     $cookies.remove('loggedIn');
     $scope.template = $scope.templates[0];

    };
    
    
    $scope.editUserSave = function(id, email) {
        $http.post('http://localhost:8001/customersearchportal/searchportal/modifyEmail?userid=' + $scope.user.useridedit + '&emailid=' + $scope.user.emailedit)
            .success(function(data) {
                console.log(data);

            })
            .error(function(data, status, headers, config) {
                //  Do some error handling here
            });

    }

    $scope.removeRow = function(id) {
        console.log('inside delete' + id);
        $http.post('http://localhost:8001/customersearchportal/searchportal/delete?userid=' + $scope.users[id].userId)
            .success(function(data) {
                console.log(data);

            })
            .error(function(data, status, headers, config) {
            });

    }

    $scope.changeFlag = function(id) {
        console.log('inside change' + id);
        $http.post('http://localhost:8001/customersearchportal/searchportal/preMigration?userid=' + $scope.users[id].userId)
            .success(function(data) {
                console.log(data);
                $scope.tables.reload();

            })
            .error(function(data, status, headers, config) {
            });

    }


})





searchusers.directive('ngConfirmMessage', [function() {
    return {
        restrict: 'A',
        link: function(scope, element, attrs) {
            element.on('click', function(e) {
                var message = attrs.ngConfirmMessage || "Are you sure ?";
                if (!confirm(message)) {
                    e.stopImmediatePropagation();
                }
            });
        }
    }
}]);