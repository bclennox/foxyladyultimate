Ultimate::Application.routes.draw do
  resources :responses

  resources :games do
    resources :players
    collection do
      post :schedule
    end
  end

  resources :players, except: :show
  root to: 'players#index'
end
