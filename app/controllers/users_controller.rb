class UsersController < ApplicationController

	skip_before_action :authenticate_user!, :only => [:index, :show]
	
	def index
		@users = User.paginate(page: params[:page])
	end

	def show
		set_user
	    @games = @user.games.where("end >= ?", Time.now).paginate(page: params[:page])
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

  def following
    #@title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    #@title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.user_followers.paginate(page: params[:page])
    render 'show_follow'
  end


	private
    # Use callbacks to share common setup or constraints between actions.
    	def set_user
      		@user = User.find(params[:id])
    	end
end
