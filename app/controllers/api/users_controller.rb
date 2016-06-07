class Api::UsersController < ApplicationController
	before_filter :fetch_user, :except => [:index, :create]

	def fetch_user
		@user = User.find_by_ID(params[:id])
	end

	def index
		@users = User.where(nil)
		@users = @users.filter(params.slice(:LoginName)) #as we add new filters we need to add them here in the slice method
		@users = @users.limit(100)
		respond_to do |format|
			format.json { render json: @users, except: [:Password] }
		end
	end

	def show
		respond_to do |format|
			format.json { render json: @user, except: [:Password] }
		end
	end

	def create
		respond_to do |format|
			format.json { render json: "Not implemented" }
		end
	end

	def update
		respond_to do |format|
			if @user.update_attributes(user_params)
				format.json { head :no_content, status: :ok }
			else
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		respond_to do |format|
			format.json { render json: "Ya, not so much" }
		end
	end
	
	private
	
	def user_params
		params.require(:user).permit(:LoginName, :CanAccessTools)
	end
end