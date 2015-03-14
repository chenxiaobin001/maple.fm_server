class ArticlesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :require_admin, only: [:destroy]

  skip_before_filter :authenticate_user!, if: :json_request?

  acts_as_token_authentication_handler_for User, except: [:index, :show]

  class ArticlesWithComments
    attr_accessor :article, :comments
  end
  # check user first!

  respond_to :json
  def index
    respond_to do |format|
      format.html {@articles = Article.all}
      format.json {
        @articles = Article.all
        ret = []
        @articles.each do |article|
          i = article.comments.size
          article = article.as_json(:root => true)  
          article[:comment] = i
          ret << article
        end
        render :json => ret
      }
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
    unless check_user_authority(current_user.id, @article.id)
      respond_to do |format|
        format.html {redirect_to articles_path}
        format.json { render :json => { :errors => ["not the author!"]}}

      end
      return
    end
    respond_to do |format|
      format.html {@article = Article.find(params[:id])}
      format.json {render :json => Article.find(params[:id])}
    end

  end

  def update
    @article = Article.find(params[:id])
    unless check_user_authority(current_user.id, @article.id)
      respond_to do |format|
        format.html {redirect_to articles_path}
        format.json { render :json => { :errors => ["not the author!"]}}
      end
      return
    end
    if @article.update(article_params)
      @article.touch(:lastEditted)
      respond_to do |format|
        format.html {redirect_to @article}
        format.json {render :json => @article}
      end

    else
      respond_to do |format|
        format.html {render 'edit'}
        format.json { render :json => { :errors => @article.errors.full_messages }}
      end
    end
  end

  def create
    @article = Article.new(article_params)
    user = User.find(current_user.id)
    @article.name = user.name
    if @article.save
      @article.touch(:lastEditted)
      save_user_article_relation(current_user.id, @article.id)
      respond_to do |format|
        format.html {redirect_to @article}
        format.json { render :json => @article}
      end

    else

      respond_to do |format|
        format.html {render 'new'}
        format.json { render :json => { :errors => @article.errors.full_messages }}
      end

    end
  end

  def show
    respond_to do |format|
      format.html {@article = Article.find(params[:id])}
      format.json {@article = Article.find(params[:id])
      tmp = ArticlesWithComments.new
      tmp.article = @article
      tmp.comments = @article.comments
      render :json => tmp}
    end

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

    def save_user_article_relation(user_id, article_id)
      @user_article = UserArticle.new
      @user_article.user_id = user_id
      @user_article.article_id = article_id
      @user_article.save!
    end

    def check_user_authority (user_id, article_id)
#      UserArticle.where("user_id == :start_date AND article_id == :end_date", {start_date: params[:start_date], end_date: params[:end_date]})
       ret = UserArticle.where("user_id = ? AND article_id = ?", user_id, article_id)
       ret.size > 0
    end

end
