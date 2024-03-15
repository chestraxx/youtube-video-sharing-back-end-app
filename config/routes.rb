Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :registration, only: [:create]
    
      get :logged_in, to: "sessions#logged_in"
      delete :logout, to: "sessions#logout"

    end
  end
end
