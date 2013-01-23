Ultimate::Application.routes.draw do
  resources :games
  resources :players, except: :show
  root to: 'players#index'
end
