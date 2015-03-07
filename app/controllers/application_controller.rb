class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
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

=begin
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :device_token << :server << :name
    devise_parameter_sanitizer.for(:account_update) << :device_token << :server << :name
  end
=end

end
