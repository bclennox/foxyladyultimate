Ultimate::Application.routes.draw do
  resources :players, except: :show
  root to: 'players#index'
end
