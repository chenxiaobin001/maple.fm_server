class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin

  def index
    @messages = Rpush::Gcm::Notification.all
  end

  def show
    @message = Rpush::Gcm::Notification.find(params[:id])
  end

  def push

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("maple.fm")
    n.registration_ids = ["APA91bGaf5el8b5KNlJvKWFGk5m22Ak1sbi5iRIbWuoKCy92FYyQ4dL32P5aPCIhe_h7Hhgmy2kQjDIj6t9feFuagaRu7mk-xSz6bFuL6jNavy_eJFrViw8-a5P-NIIKVGGx2xjEntK3PyEmc4r_A4Ssp05oGvKbJw"]
    n.data = { message: "hi mom!" }
    ret = n.save

    if ret
      user_message = UserMessage.new
      user_message.user_id = 2
      user_message.message_id = n.id
      user_message.save!
      respond_to do |format|
        format.html {
          render plain: gen_success_message(user_message.created_at.to_date)
        }
 #       format.json render json: gen_success_message(user_message.created_at.to_date)
      end
    else
      respond_to do |format|
        format.html {
          render plain: gen_error_message(n.created_at.to_date)
        }
 #       format.json render json: gen_error_message(n.created_at.to_date)
      end
    end


  end

  private

  def gen_error_message(time)
    res = ResJSON.new
    res.id = "mapleMsgError"
    res.date = time
    res.content = "failed to send"
    res.to_json
  end

  def gen_success_message(time)
    res = ResJSON.new
    res.id = "mapleMsgSuc"
    res.date = time
    res.content = "success"
    res.to_json
  end

end
