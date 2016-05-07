Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'application#index'

  get 'api/get_cards', to: 'application#get_cards'

  namespace :api do
    namespace :v1 do
      resources :kingdoms
    end
  end
end
