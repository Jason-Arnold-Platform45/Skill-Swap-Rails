Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  authenticated :user do
    root to: "skills#index", as: :authenticated_root
  end

  resources :skills
  resources :matches do
    member do
      patch :accept
      patch :reject
    end
  end

  resources :users, only: [:index, :show]
end
