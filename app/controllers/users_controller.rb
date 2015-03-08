class UsersController < ApplicationController
  before_filter :authenticate_user!
  after_action :verify_authorized, except: [:messages]
  before_filter :require_admin, only: [:messages]

  def index

  end

  def index1
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
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
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

  private

  def secure_params
    params.require(:user).permit(:role)
  end

end
