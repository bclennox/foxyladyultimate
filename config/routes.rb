Rails.application.routes.draw do
  devise_for :users, skip: :registrations

  resource :profile, only: [:edit, :update]
  resource :password, only: [:edit, :update]

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
      post :schedule
    end

    member do
      get :respond
      post :override
      post :remind
      post :cancel
      post :reschedule
    end
  end

  resources :quips, except: [:show, :destroy]

  resource :push_subscription, only: [:create, :destroy]

  authenticate :user, -> (user) { Authorizer.new(user: user).admin? } do
    mount GoodJob::Engine => 'good_job'
  end

  get "manifest" => "manifest#show", as: :manifest, defaults: { format: :json }

  root to: 'games#next'
end
