class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = @current_user
    post = get_post(@comment)
    if @comment.save
      redirect_to post, notice: 'Comment was successfully added.'
    else
      redirect_to post, notice: 'Error saving comment, please add again..'
    end
  end

  def destroy
    post = get_post(@comment)
    if owner?(@comment)
      @comment.destroy
      redirect_to post, notice: 'Comment was successfully deleted.'
    else
      redirect_to post, notice: 'Comment cannot be destroyed.'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.fetch(:comment, {}).permit(:description, :commentable_type, :commentable_id)
  end

  def get_post(comment)
    if comment.commentable.class == Post
      comment.commentable
    else
      get_post(comment.commentable)
    end
  end
end
