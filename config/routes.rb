Rails.application.routes.draw do
  # Ruta para registro desde otras plataformas
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # Ruta para errores
  
  match '/users', to: 'errors#not_found', via: :all

  # Resto de tus rutas
  resources :posts do
    resources :comments, only: [:create, :destroy]
  
    member do
      patch :upvote
    end
  end

  resources :users do
    member do
      post 'follow', to: 'follows#follow'
      post 'unfollow', to: 'follows#unfollow'
    end
  end
  
  get "/profile/:id", to: "users#profile", as: :profile
  get 'liked_posts', to: 'users#liked_posts'

  get '/para_ti', to: 'posts#para_ti', as: 'para_ti'
  get '/seguidos', to: 'posts#seguidos', as: 'seguidos'
  get 'set_theme', to: 'theme#update'

  resources :users
  resources :posts
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  authenticated :user do
    root to: 'users#index', as: :authenticated_root
  end

  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new' 
    end
  end

  # Ruta comodín para capturar todas las rutas no especificadas
  match '*path', to: 'errors#not_found', via: :all, constraints: lambda { |req| !req.path.starts_with?('/rails/active_storage/') }
  
end
