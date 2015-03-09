class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, if: :json_request?
#  before_action :configure_permitted_parameters, if: :devise_controller?

  def require_admin
    unless current_user && current_user.role == 'admin'
      flash[:error] = "You are not an admin"
      redirect_to root_path
    end
  end



  class ResJSON
    attr_accessor :title, :id, :date, :content
  end

  class UserJSON
    attr_accessor :email, :name, :session
  end

  protected
  def gen_res_message(title, time, msgType, msgContent)
    res = ResJSON.new
    res.title = title
    res.id = msgType
    res.date = time
    res.content = msgContent
    res.to_json
  end

=begin
  def after_sign_out_path_for(resource_or_scope)
    '/user/json/signOut'
  end
=end

  def json_request?
    request.format.json?
  end

=begin
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :device_token << :server << :name
    devise_parameter_sanitizer.for(:account_update) << :device_token << :server << :name
  end
=end

end
