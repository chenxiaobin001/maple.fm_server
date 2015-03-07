class NotificationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :push]
  before_filter :require_admin, :except => [:index, :push]

  respond_to :json

  def push

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("maple.fm")
    n.registration_ids = ["APA91bGaf5el8b5KNlJvKWFGk5m22Ak1sbi5iRIbWuoKCy92FYyQ4dL32P5aPCIhe_h7Hhgmy2kQjDIj6t9feFuagaRu7mk-xSz6bFuL6jNavy_eJFrViw8-a5P-NIIKVGGx2xjEntK3PyEmc4r_A4Ssp05oGvKbJw"]
    n.data = { message: "hi mom!" }
    n.save!
    render :nothing => true
  end

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
        tmp = TmpJson.new
        notification = @notifications.last
        tmp.id = notification.ntype
        tmp.date = notification.created_at.to_date
        tmp.content = notification.text
        render json: tmp.to_json
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

  class TmpJson
    attr_accessor :id, :date, :content

  end
end
