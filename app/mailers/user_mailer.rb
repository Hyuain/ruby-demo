class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://hais-teatime.com'
    mail(to: @user.mail, subject: '欢迎来到 RailsDemo')
  end
end
