class UserMailer < ApplicationMailer
	include SendGrid
	default from: "bghmailer@gmail.com"

	def example_email(user)
		@user = user
		mail( :to => @user.email, :subject => 'made a new game!')
	end

	def game_added_email(gametype, current_user)
		@gametype = gametype
		@current_user = current_user
		@users = @gametype.users.where.not(id: @current_user.id)
		mail( :to => (@users.pluck(:email) + @current_user.followers.map(&:email)).uniq,
			  :subject => "New #{@gametype.name} Game!")
	end


end
