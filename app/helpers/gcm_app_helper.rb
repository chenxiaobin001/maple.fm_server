module GcmAppHelper


  def gcm_app_path(app)
    "/config/gcm/" + app.id.to_s
  end

  def edit_gcm_app_path(app)
    "/config/gcm/" + app.id.to_s + "/edit"
  end

end
