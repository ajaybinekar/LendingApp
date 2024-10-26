Rails.application.routes.draw do
  require 'sidekiq/web'
  devise_for :users
  resources :loans do
    member do
      post :repay               # Custom route for repaying a loan
      post :approve             # Custom route for approving a loan
      post :reject              # Custom route for rejecting a loan
      post :adjust              # Custom route for adjusting a loan
      post :accept_adjustment
      post :reject_adjustment
      post :request_readjustment
    end
  end
  root 'loans#index' 
    mount Sidekiq::Web => '/sidekiq'
end
