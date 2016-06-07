/**
 * @author austin.hammer
 */
(function initializeWelcomeApp($) {
	angular.module('welcomeApp', ['sharedFilters','sharedDirectives','ngRoute','ngResource'])
	.config(function ($httpProvider) {
  		$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
	});
})(jQuery);
