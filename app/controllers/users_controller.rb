class UsersController < ApplicationController
  def create
    p params[:email]
    p params[:password]
    user = User.new
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.save
    user.errors
  end
end
