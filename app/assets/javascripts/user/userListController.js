/**
 * @author austin.hammer
 */
(function() {
	angular.module('welcomeApp')
		.controller('UserListController',UserListController);

	UserListController.$inject = ['UserService','$location','$scope'];

	function UserListController(UserService,$location,$scope) {
		var controller = this;

		this.userList = [];
		this.loadingData = false;
		this.searchText = '';
		this.predicate = 'ID';
		this.reverse = false;

		$scope.$on('$viewContentLoaded', function() {
			controller.loadUsers();
		});

		this.loadUsers = function() {
			this.loadingData = true;
			UserService.query().$promise.then(function(data) {
				controller.userList = data;
				this.loadingData = false;
			});
		};
		this.selectUser = function(id) {
			$location.path('/edit/'+id);
		}
	}
})();
