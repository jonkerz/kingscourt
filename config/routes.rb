Rails.application.routes.draw do
  #root to: 'test#index'
  root 'application#index'
  get '*path' => 'application#index'
end
