class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin

  def index
    @messages = Rpush::Gcm::Notification.all
  end

  def show
    @message = Rpush::Gcm::Notification.find(params[:id])
  end
end
