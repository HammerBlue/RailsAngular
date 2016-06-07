/**
 * @author austin.hammer
 */
(function() {
	angular.module('welcomeApp')
		.controller('UserEditController',UserEditController);

	UserEditController.$inject = ['UserService','$routeParams','$filter','$scope','$location'];

	function UserEditController(UserService,$routeParams,$filter,$scope,$location) {
		var controller = this;

		this.currentUserId = $routeParams.id;
		this.user = new UserService();
		this.isAdminOptions = [
			{display: 'True', value: true},
			{display: 'False', value: false}
		];
		this.loadingData = false;

		$scope.$watch(function(){return controller.currentUserId}, function(newVal, oldVal) {
			controller.loadUser();
		});

		this.loadUser = function() {
			UserService.get({userId:controller.currentUserId}).$promise
				.then(function(data) {
					controller.user = data;
				});
		};
		this.saveUser = function() {
			controller.user.$update();
		};
		this.cancelEdit = function() {
			$location.path('/list');
		};
	}
})();
