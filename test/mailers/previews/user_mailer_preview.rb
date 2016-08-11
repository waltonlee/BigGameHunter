# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def welcome
    UserMailer.single_game_email(User.first, Game.first, User.second)
  end
end
