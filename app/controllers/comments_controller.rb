class CommentsController < ApplicationController
    before_action :authenticate_account!
  
    def create
      @comment = Comment.new(comment_params)
      @comment.account_id = current_account.id if account_signed_in?
  
      if @comment.save
        return_url = params[:comment][:return_to].present? ? post_path(@comment.post_id) : feed_path
        redirect_to return_url, flash: { success: "Comment was created"}
      else
        redirect_to feed_path, flash: { danger: "Comment was not created"}
      end
    end

    def unfollow
      current_account.unfollow(params[:follow_id])
      redirect_to account_path(params[:follow_id])
    end
  
    def show
        @posts = Post.all
    end
  
    private
    def comment_params
      params.require(:comment).permit(:comment, :post_id, :return_to)
    end
  end
    