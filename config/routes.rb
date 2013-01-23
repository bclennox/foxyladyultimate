Ultimate::Application.routes.draw do
  resources :games do
    collection do
      post :schedule
    end
  end

  resources :players, except: :show
  root to: 'players#index'
end
