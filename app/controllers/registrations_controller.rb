class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    '/user/json/update'
  end

  def after_sign_up_path_for(resource)
    '/user/json/signUp'
  end
end