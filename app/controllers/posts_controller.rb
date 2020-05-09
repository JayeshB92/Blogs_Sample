class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :publish, :archive]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @comment = @post.comments.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = @current_user
    @post.status = :draft

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    notice = 'Post cannot be deleted.'
    if owner? @post
      @post.destroy
      notice = 'Post was successfully destroyed.'
    end

    redirect_to posts_url, notice: notice
  end

  def publish
    notice = 'Post was already published.'
    unless @post.published?
      @post.published!
      notice = 'Post was successfully published.'
      EmailWorker.perform_later(@post.user.id, notice)
    end
    redirect_to posts_path, notice: notice
  end

  def archive
    notice = 'Post was already archived.'
    unless @post.archived?
      @post.archived!
      notice = 'Post was successfully archived.'
      EmailWorker.perform_later(@post.user.id, notice)
    end
    redirect_to posts_path, notice: notice
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.fetch(:post, {}).permit(:title, :body)
  end
end
