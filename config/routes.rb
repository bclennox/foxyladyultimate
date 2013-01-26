Ultimate::Application.routes.draw do
  resources :players, except: :show
  resource :schedule, only: [:edit, :update]

  resources :games do
    collection do
      get :next
      get :schedule
    end

    member do
      get :respond
      post :notify
    end
  end

  root to: 'games#next'
end
