Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  ActiveAdmin.routes(self)

  root 'application#index'

  namespace :api do
    namespace :v1 do
      resources :kingdoms, only: [:index, :show, :create, :update, :destroy]
      resources :cards, only: [:index]
      resources :expansions, only: [:index]
      scope :u do
        scope ":username" do
          resources :favorites, only: [:create, :destroy]
        end
      end
    end
  end
end
