Rails.application.routes.draw do
  #Ruta para registro desde otras plataformas 
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  #Ruta por defecto para usuarios logueados
  authenticated :user do
    root to: 'main#index', as: :authenticated_root
  end

  #Ruta por defecto para usuarios no logueados
  unauthenticated :user do
    devise_scope :user do
      root to: 'devise/sessions#new' 
    end
  end

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
