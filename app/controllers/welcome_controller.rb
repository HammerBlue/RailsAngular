class WelcomeController < ApplicationController
	def index
		render layout: "angular"
		Rails.logger.info "Angular page"
		Rails.logger.debug "Should only see this on debug"
	end

	def login
		
	end

end
