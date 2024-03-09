class CommentsController < ApplicationController
    before_action :authenticate_account!
  
    def create
      @comment = Comment.new(comment_params)
      @comment.account_id = current_account.id if account_signed_in?
  
      if @comment.save
        redirect_to feed_path, flash: { success: "Comment was created"}
      else
        redirect_to feed_path, flash: { danger: "Comment was not created"}
      end
    end
  
    def show
        @posts = Post.all
    end
  
    private
    def comment_params
      params.require(:comment).permit(:comment, :post_id)
    end
  end
    