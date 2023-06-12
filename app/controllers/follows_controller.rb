class FollowsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user
   

    def follow
        puts "este es el id"
        puts @user
        current_user.send_follow_request_to(@user)
        @user.accept_follow_request_of(current_user)

        redirect_to request.referrer
    end

    def unfollow 
        current_user.unfollow(@user)
        redirect_to request.referrer
    end

    private 

    def set_user
        @user = User.find(params[:id])
        # Si deseas mostrar un mensaje de error si el usuario no existe, puedes manejarlo de esta manera:
        unless @user
          flash[:error] = "Usuario no encontrado"
          redirect_to root_path
        end
    end

    def follow_params
        params.permit(:id)
    end
end
