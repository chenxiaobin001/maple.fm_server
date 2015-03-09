class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  before_filter :require_admin, :except => [:index]

  respond_to :json

  def index1
    @notifications = Notification.all
    render 'index1'
  end

  def index
    @date = Time.now
    @notifications = Notification.all
    respond_to do |format|
      format.html # show.html.erb
      format.json {
        tmp = ResJSON.new
        notification = @notifications.last
        render json: gen_res_message(notification.title, notification.created_at.to_date, notification.ntype, notification.text)
=begin
        render json: .map{|notification| { :id => notification.ntype, :date =>  notification.created_at, :content => notification.text} }
=end
      }

    end
  end

  def new
    @notification = Notification.new
  end

  def update
    @notification = Notification.find(params[:id])

    if @notification.update(notification_params)
      redirect_to @notification
    else
      render 'edit'
    end
  end

  def edit
    @notification = Notification.find(params[:id])
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      redirect_to @notification
    else
      render 'new'
    end
  end

  def show
    @notification = Notification.find(params[:id])
  end

  private
  def notification_params
    params.require(:notification).permit(:title, :text, :ntype)
  end

end
