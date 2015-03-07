class GcmAppController < ApplicationController
  def index
    @apps = Rpush::Gcm::App.all
  end
end
