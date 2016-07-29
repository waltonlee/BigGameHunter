class UsersController < ApplicationController
	before_action :set_user, only: [:show]
	#params.require(:user).permit(:name, gametype_ids:[])

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
	    @games = @user.games.paginate(page: params[:page])
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    	def set_user
      		@user = User.find(params[:id])
    	end
end
