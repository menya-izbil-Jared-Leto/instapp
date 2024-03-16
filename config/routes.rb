Rails.application.routes.draw do
  devise_for :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #get '/webfonts/:font_file', to: redirect('/assets/webfonts/%{font_file}')
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "/feed" => "accounts#index"
  get "/profile/:username" => "accounts#profile", as: :profile
  #get "post/like/:post_id" => "likes#save", as: :save_like
  post "follow/account" => "accounts#follow_account", as: :follow_account

  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create]

  resources :accounts do
    post 'unfollow', on: :member
  end

  root to: "home#homepage"

  resources :posts
  get 'posts/new'
  get 'posts/index'
  get 'posts/feed'

end
