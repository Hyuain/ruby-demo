class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://hais-teatime.com'
    mail(to: @user.email, subject: '欢迎来到 RailsDemo')
  end
end
