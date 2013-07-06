Ultimate::Application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  resources :players, except: :show
  resource :schedule, only: [:edit, :update]

  resources :games do
    collection do
      get :next
      get :schedule
    end

    member do
      get :respond
      post :remind
      post :cancel
      post :reschedule
    end
  end

  root to: 'games#next'
end
