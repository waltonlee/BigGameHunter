class UsersController < ApplicationController
	before_action :set_user, only: [:show]

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
	    @games = @user.games.paginate(page: params[:page])
	    @attending = @user.attended_events.paginate(page: params[:page])
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    	def set_user
      		@user = User.find(params[:id])
    	end
end
