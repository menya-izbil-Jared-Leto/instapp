class PostsController < ApplicationController
  
    def new
      @post = Post.new
    end
  
    def create
      @post = Post.new(post_params)
      @post.account_id = current_account.id if account_signed_in?

      if @post.save
        redirect_to feed_path, flash: { success: "Post was created"}
      else
        render 'new', flash: { danger: "Post was not created"}
        puts @post.errors.full_messages
      end
    end
  
    def show
        @posts = Post.all
    end

    private
    def post_params
      params.require(:post).permit(:description, :caption, :image)
    end
  end
  