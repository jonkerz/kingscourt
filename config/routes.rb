Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'application#index'

  get 'api/get_cards', to: 'application#get_cards'
end
