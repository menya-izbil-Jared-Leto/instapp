Rails.application.routes.draw do
  devise_for :accounts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "/feed" => "accounts#index"
  get "/profile/:username" => "accounts#profile", as: :profile

  root to: "home#homepage"

  resources :posts
  get 'posts/new'
  get 'posts/index'
  get 'posts/feed'

end
