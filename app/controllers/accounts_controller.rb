class AccountsController < ApplicationController
    before_action :authenticate_account! 
    before_action :set_account, only: [:profile] 

    #Feed
    def index
        @posts = Post.all
    end

    #Profile
    def profile
        @posts = @account.posts
    end

    def set_account
        @account = Account.find_by_username(params[:username])
    end
end
