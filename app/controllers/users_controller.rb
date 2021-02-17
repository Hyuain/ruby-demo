class UsersController < ApplicationController
  def create
    user = User.create create_params
    render_resource user
    UserMailer.welcome_email(user).deliver_later if user.errors.empty?
  end

  def me
    render_resource current_user
  end

  def create_params
    params.permit(:email, :password, :password_confirmation)
  end
end
