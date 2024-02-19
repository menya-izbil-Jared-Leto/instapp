class AccountsController < ApplicationController
    before_action :authenticate_account! 

    #Feed
    def index
        @posts = Post.all
    end

    #Profile
    def show

    end
end
