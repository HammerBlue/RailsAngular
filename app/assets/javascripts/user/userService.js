/**
 * @author austin.hammer
 */
(function() {
	angular.module('welcomeApp')
		.service('UserService',UserService);
		
	UserService.$inject = ['$resource'];
		
	function UserService($resource) {
		return $resource('/D2/api/users/:userId', {userId: '@ID'},
			{
				'update': {
					method: 'PUT'
				}
			}
		);
	}
})();
