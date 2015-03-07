class GcmAppController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin
  def index
    @apps = Rpush::Gcm::App.all
  end

  def show
    @app = Rpush::Gcm::App.find(params[:id])
  end

  def new
    @app = Rpush::Gcm::App.new
  end

  def create
    @app = Rpush::Gcm::App.new(notification_params)
    if @app.save
      redirect_to @app
    else
      render 'new'
    end
  end

  def update
    @app = Rpush::Gcm::App.find(params[:id])

    if @app.update(gcmApp_params)
      redirect_to "/config/gcm/" + @app.id.to_s
    else
      render 'edit'
    end
  end

  def edit
    @app = Rpush::Gcm::App.find(params[:id])
  end


  private
  def gcmApp_params
    params.require(:rpush_client_active_record_gcm_app).permit(:name, :auth_key, :connections)
  end



end
