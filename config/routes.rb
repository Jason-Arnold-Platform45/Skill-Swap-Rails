Rails.application.routes.draw do
  devise_for :users

  unauthenticated do
    root to: "devise/sessions#new", as: :unauthenticated_root
  end

  authenticated :user do
    root to: "skills#index", as: :authenticated_root
  end

  resources :users, only: [:index, :show]
  resources :skills

  resources :matches do
    member do
      patch :accept
      patch :reject
    end
  end
end
