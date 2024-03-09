class AccountsController < ApplicationController
    before_action :authenticate_account! 
    before_action :set_account, only: [:profile] 

    #Feed
    def index
        @posts = Post.all
        @comment = Comment.new

        following_ids = Follower.where(follower_id: current_account.id).map(&:following_id)
        following_ids << current_account.id
        
        @follower_suggestions = Account.where.not(id: following_ids)
    end

    #Profile
    def profile
        @posts = @account.posts
    end

    def follow_account
        follower_id = params[:follow_id]
        if Follower.create!(follower_id: current_account.id, following_id: follower_id)
           flash[:success] = "Now following user" 
        else
            flash[:danger] = "Something wrong"
        end

        redirect_to feed_path
    end

    def set_account
        @account = Account.find_by_username(params[:username])
    end
end
