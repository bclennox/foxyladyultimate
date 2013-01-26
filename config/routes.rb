Ultimate::Application.routes.draw do
  resources :players, except: :show
  resources :games do
    collection do
      get :next
      get :schedule
    end

    member do
      get :respond
    end
  end
  resource :schedule

  root to: 'games#next'
end
