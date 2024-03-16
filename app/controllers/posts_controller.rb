class PostsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_post, only: [:show]
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.account_id = current_account.id if account_signed_in?

    if @post.save
      redirect_to feed_path, flash: { success: "Post was created"}
    else
      redirect_to new_post_path, flash: { danger: "Post was not created"}
      puts @post.errors.full_messages
    end
  end

  def show
    @comment = Comment.new
  end

  private

  def set_post
    @post = Post.find(params[:id]) if params[:id].present?
  end

  def post_params
    params.require(:post).permit(:description, :caption, :image)
  end
end
  