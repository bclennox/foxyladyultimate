Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users' => 'devise/registrations#update', as: 'user_registration'
  end

  resources :players, except: :show do
    collection do
      get :ranked
    end
  end
  resources :removals, only: [:new, :create]

  resource :schedule, only: [:edit, :update]

  resources :games do
    collection do
      get :next
      get :schedule
    end

    member do
      get :respond
      post :override
      post :remind
      post :cancel
      post :reschedule
    end
  end

  root to: 'games#next'
end
