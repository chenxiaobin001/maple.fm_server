class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin, only: [:destroy]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end