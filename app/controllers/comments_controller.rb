class CommentsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :require_admin, only: [:destroy]

  acts_as_token_authentication_handler_for User, except: [:index, :show]

  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
    respond_to do |format|
      format.html {@comments = @article.comments}
      format.json {render :json => @article.comments}
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @comment.id1 = current_user.id
    @comment.id2 = params[:comment_id2]
    @comment.commenter2 = params[:commenter2]
    @comment.save!
    save_user_comment_relation(current_user.id, @comment.id)

    respond_to do |format|
      format.html {redirect_to article_path(@article)}
      format.json {render :json => @article.comments}
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def save_user_comment_relation(user_id, comment_id)
    user_comment = UserComment.new
    user_comment.user_id = user_id
    user_comment.comment_id = comment_id
    user_comment.save!
  end

end
