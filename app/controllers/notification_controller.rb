class NotificationController < ApplicationController
  respond_to :json
  def index
    @date = Time.now
  end
end
