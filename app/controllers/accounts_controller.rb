class AccountsController < ApplicationController
    before_action :authenticate_account! 
    before_action :set_account, only: [:profile] 

    def index
        @posts = Post.all
        @comment = Comment.new

        following_ids = Follower.where(follower_id: current_account.id).map(&:following_id)
        following_ids << current_account.id
        
        @follower_suggestions = Account.where.not(id: following_ids)
    end

    def profile
        @posts = @account.posts
    end

    def followers
        @account = Account.find_by_username(params[:username])
        @followers = @account.followers
    end

    def following
        @account = Account.find_by_username(params[:username])
        @following = @account.following
    end

    def follow_account
        follower_id = params[:follow_id]
        if Follower.create!(follower_id: current_account.id, following_id: follower_id)
           flash[:success] = "Now following user" 
        else
            flash[:danger] = "Something wrong"
        end

        redirect_to profile_path(Account.find(follower_id).username)
    end

    def unfollow
        follow = Follower.find_by(follower_id: current_account.id, following_id: params[:id])
        if follow
          follow.destroy
          flash[:success] = "You have unfollowed the user"
        else
          flash[:danger] = "Something went wrong"
        end
        redirect_to profile_path(Account.find(params[:id]).username)
    end      

    def set_account
        @account = Account.find_by_username(params[:username])
    end
end
