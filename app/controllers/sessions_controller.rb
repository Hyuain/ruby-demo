class SessionsController < ApplicationController
  def create
    session = Session.new create_params
    session.validate
    render_resource session
  end

  def destroy

  end

  def create_params
    params.permit(:email, :password)
  end
end
