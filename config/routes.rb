Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth'
  ActiveAdmin.routes(self)
  root 'application#index'

  get 'api/get_cards', to: 'application#get_cards'
  get 'api/get_non_randomizers', to: 'application#get_non_randomizers'

  namespace :api do
    namespace :v1 do
      resources :kingdoms
      scope :u do
        scope ":username" do
          resources :favorites, only: [:create, :destroy]
        end
      end
    end
  end
end
