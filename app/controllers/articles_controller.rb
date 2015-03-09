class ArticlesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, only: [:destroy]

  class ArticlesWithComments
    attr_accessor :article, :comments
  end
  # check user first!

  respond_to :json
  def index
    respond_to do |format|
      format.html {@articles = Article.all}
      format.json {render :json => Article.all}
    end
  end

  def new
    @article = Article.new
  end

  def edit
    respond_to do |format|
      format.html {@article = Article.find(params[:id])}
      format.json {render :json => Article.find(params[:id])}
    end

  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
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

    if @article.save
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
end
