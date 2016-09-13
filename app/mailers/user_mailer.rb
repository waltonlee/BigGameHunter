class UserMailer < ActionMailer::Base
	include Resque::Mailer
	#include SendGrid
	default from: "bghmailer@gmail.com"

	# def example_email(user)
	# 	@user = user
	# 	mail( :to => @user.email, :subject => 'made a new game!')
	# end

	def single_game_email(userid, gameid, current_userid)
		@user = User.find(userid)
		@game = Game.find(gameid)
		@current_user = User.find(current_userid)
		mail( :to => @user.email, :subject => "New #{@game.gametype.name} Game!")
	end


end
