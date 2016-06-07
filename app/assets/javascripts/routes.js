/**
 * @author austin.hammer
 */
(function() {
	angular.module('welcomeApp')
		.config(function($routeProvider){
			$routeProvider
				.when('/list', {
					templateUrl: '/templates/user/userList.html',
					controller: 'UserListController',
					controllerAs: 'UserListCtrl'
				})
				.when('/edit/:id', {
					templateUrl: '/templates/user/userEdit.html',
					controller: 'UserEditController',
					controllerAs: 'UserEditCtrl'
				})
				.otherwise({redirectTo: '/list'})
		});
	
})();
