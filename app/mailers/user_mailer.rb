class UserMailer < ApplicationMailer
	include SendGrid
	default from: "bghmailer@gmail.com"

	def example_email(user)
		@user = user
		mail( :to => @user.email, :subject => 'made a new game!')
	end
end
