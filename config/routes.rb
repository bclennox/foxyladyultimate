Ultimate::Application.routes.draw do
  resources :responses

  resources :games do
    collection do
      get :next
      post :schedule
    end
  end

  resources :players, except: :show
  root to: 'games#next'
end
