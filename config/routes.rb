Rails.application.routes.draw do
  root 'angular#index'

  devise_for :users, path: "the_court"
  scope "the_court" do
    get "/", to: 'court#index', as: "the_court"
    scope "admin" do
      ActiveAdmin.routes(self)
      get "/", to: 'admin/dashboard#index'
    end
  end

  namespace :api do
    mount_devise_token_auth_for "User", at: "auth"
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
