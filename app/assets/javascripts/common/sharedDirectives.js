/**
 * @author austin.hammer
 */
(function() {
	angular.module('sharedDirectives',[])
	.directive('inlineEdit', function() {
		return function(scope, element, attrs) {
			element.bind('click', function() {
				event.preventDefault();
				event.stopImmediatePropagation();
			});
			element.bind('keypress', function(event) {
				if(event.which === 13) {
					jQuery(element).blur();
				}
			});
		}
	})
	.directive('listFilter', function() {
		return {
			restrict: 'AE',
			replace: true,
			templateUrl: '/templates/common/listFilterDirective.html',
			scope: {
				searchText: "="
			},
			controller: function() {

			},
			link: function($scope, element, attrs) {
				element.bind('keyup', function() {
					if(event.keyCode == 27) { // escape key
						element.val('');
						$scope.searchText = '';
						$scope.$apply();
					}
				});
			}
		}
	});
})();
