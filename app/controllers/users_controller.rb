class UsersController < ApplicationController
	#params.require(:user).permit(:name, gametype_ids:[])

	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		set_user
	    @games = @user.games.paginate(page: params[:page])
	end

	def follow
	  @user = User.find(params[:id])

	  if current_user
	    if current_user == @user
	      flash[:error] = "You cannot follow yourself."
	    else
	      current_user.follow(@user)
	      #RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
	      flash[:notice] = "You are now following #{@user.name}."
	    end
	  else
	    flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.name}.".html_safe
	  end
	  redirect_to @user
	end

	def unfollow
	  @user = User.find(params[:id])

	  if current_user
	    current_user.stop_following(@user)
	    flash[:notice] = "You are no longer following #{@user.name}."
	  else
	    flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.name}.".html_safe
	  end
	  redirect_to @user
	end


	private
    # Use callbacks to share common setup or constraints between actions.
    	def set_user
      		@user = User.find(params[:id])
    	end
end
