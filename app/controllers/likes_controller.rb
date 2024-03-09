class LikesController < ApplicationController
  before_action :authenticate_account!
  
  def create
      @like = current_account.likes.new(like_params)
      if !@like.save
        redirect_to feed_path
      end
  end
  
  def destroy
      @like = current_account.likes.find(params[:id])
      @like.destroy
      redirect_to feed_path
  end
  
  private
  
  def like_params
      params.require(:like).permit(:post_id)
  end
end