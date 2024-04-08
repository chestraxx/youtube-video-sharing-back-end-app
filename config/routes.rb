Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]

      get :logged_in, to: "sessions#logged_in"
      delete :logout, to: "sessions#logout"

      post :video_info, to: "video#info"
      get :videos, to: "video#index"
    end
  end
end
