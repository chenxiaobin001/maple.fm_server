class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, except: [:push]

  class Msg

    attr_accessor :id, :data, :server
  end
  def index
    @messages = Rpush::Gcm::Notification.all
  end

  def new
    @message = Msg.new
  end


  def show
    @message = Rpush::Gcm::Notification.find(params[:id])
  end

  def push

    name = params[:sender]
    text = params[:text]
    server = params[:server]

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("maple.fm")
    n.registration_ids = ["APA91bGaf5el8b5KNlJvKWFGk5m22Ak1sbi5iRIbWuoKCy92FYyQ4dL32P5aPCIhe_h7Hhgmy2kQjDIj6t9feFuagaRu7mk-xSz6bFuL6jNavy_eJFrViw8-a5P-NIIKVGGx2xjEntK3PyEmc4r_A4Ssp05oGvKbJw"]
    n.data = { message: "name:" + name + text + "server:" + server}
    ret = n.save

    if ret
      user_message = UserMessage.new
      user_message.user_id = 2
      user_message.message_id = n.id
      user_message.save!
      respond_to do |format|
        format.html {
          render plain: gen_res_message(name, user_message.created_at.to_date, MsgType[:msg_suc], "success")
        }
 #       format.json render json: gen_success_message(user_message.created_at.to_date)
      end
    else
      respond_to do |format|
        format.html {
          render plain: gen_res_message(nil, n.created_at.to_date, MsgType[:msg_err], "failed to send")
        }
 #       format.json render json: gen_error_message(n.created_at.to_date)
      end
    end


  end

  private

end
