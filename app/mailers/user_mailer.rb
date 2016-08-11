class UserMailer < ApplicationMailer
	#include SendGrid
	default from: "bghmailer@gmail.com"

	def example_email(user)
		@user = user
		mail( :to => @user.email, :subject => 'made a new game!')
	end

	def single_game_email(user, game, current_user)
		@user = user
		@game = game
		@current_user = current_user
		mail( :to => user.email, :subject => "New #{@game.gametype.name} Game!")
	end


end
