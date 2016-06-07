/**
 * @author austin.hammer
 */
(function() {
	angular.module('sharedFilters', [])
		.filter('bitToBoolean', function () {
		return function (bitValue) {
			if(bitValue == 0) {
				return "False";
			}
			return "True";
		};
	});
})();
