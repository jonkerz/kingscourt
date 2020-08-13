Rails.application.routes.draw do
  root "application#index"

  devise_for :users, path: "the_court"
  scope "the_court" do
    get "/", to: "court#index", as: "the_court"
    scope "admin" do
      ActiveAdmin.routes(self)
      get "/", to: "admin/dashboard#index"
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

  # Super ugly, tests only.
  if Rails.env.test?
    scope :cards do
      cards_used_in_tests = %w[cellar chapel moat chancellor village
        woodcutter workshop bureaucrat feast gardens
        courtyard pawn secret_chamber great_hall masquerade
        shanty_town steward swindler wishing_well baron]
      cards_used_in_tests.each do |card|
        get "#{card}.jpg", to: "application#card_image_not_found"
        get "small/#{card}.jpg", to: "application#card_image_not_found"
      end
    end
  end
end
