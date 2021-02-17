class ApplicationController < ActionController::API
  def current_user
    # 如果找不到，会返回 nil，ruby 这样会默认返回 current_user
    @current_user ||= User.find_by_id session[:current_user_id]
    # 如果找不到，会报错
    # User.find user_id
  end

  def render_resource(resource)
    return head 404 if resource.nil?
    if resource.errors.empty?
      render json: { resource: resource }, status: 200
    else
      render json: { errors: resource.errors }, status: 400
    end
  end
end
