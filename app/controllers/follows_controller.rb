class FollowsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
  
    def follow
      # Envía una solicitud de seguir al usuario
      current_user.send_follow_request_to(@user)
      # Acepta la solicitud de seguir del usuario actual
      @user.accept_follow_request_of(current_user)
  
      # Redirige a la página anterior
      redirect_to request.referrer
    end
  
    def unfollow
      # Deja de seguir al usuario
      current_user.unfollow(@user)
      # Redirige a la página anterior
      redirect_to request.referrer
    end
  
    private
  
    def set_user
      # Encuentra al usuario con el ID proporcionado en los parámetros
      @user = User.find(params[:id])
    end
  
    def follow_params
      # Permite el parámetro ID
      params.permit(:id)
    end
  end
  