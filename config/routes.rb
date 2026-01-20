Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: "skills#index", as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new"
    end
  end

  resources :skills

  resources :matches, only: [:index, :show, :create] do
    member do
      patch :accept
      patch :reject
    end
  end

  resources :users, only: [:index, :show]
end
