Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #       end
  # end
  resources :sessions, only: [:create]

  resources :registration, only: [:create]

  delete :logout, to: "sessions#logout"
  get :logged_in, to: "sessions#logged_in"

end
