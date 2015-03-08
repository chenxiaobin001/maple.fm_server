class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:jsonUpdate, :jsonSignUp]
  after_action :verify_authorized, except: [:messages, :jsonUpdate, :jsonSignUp]
  before_filter :require_admin, only: [:messages]

  def index
    @users = User.all
    authorize User
  end



  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      @msg = gen_res_message("User update", Time.now.to_date, MsgType[:user_suc], "successfully updated user's information")
#      redirect_to users_path, :notice => "User updated."
       render plain: @msg
    else
      @msg = gen_res_message("Unable to update user", Time.now.to_date, MsgType[:user_err], "failed to update user's information")
#      redirect_to users_path, :alert => "Unable to update user."
      render plain: @msg
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end


  def messages
    @user_messages = UserMessage.where(:user_id => params[:id])
    ids = []
    @user_messages.each do |message|
      ids << message.message_id
    end
    @messages = Rpush::Gcm::Notification.where(id: ids)
    puts @messages.size
    render 'messages'
  end




#jsons

  def jsonUpdate
    @msg = gen_res_message("User update", Time.now.to_date, MsgType[:user_suc], "successfully updated user's information")
    render plain:@msg
  end

  def jsonSignUp
    @msg = gen_res_message("User signUp", Time.now.to_date, MsgType[:user_suc], session['session_id'])
    render plain:@msg
  end

  def jsonSignUpFail
    @msg = gen_res_message("User signUp", Time.now.to_date, MsgType[:user_suc], "signUp failed")
    render plain:@msg
  end





  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
