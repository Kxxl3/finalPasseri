class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # Método para iniciar sesión con Facebook
  # def facebook
  #   handle_auth("Facebook")
  # end

  def google_oauth2
    handle_auth("Google")
  end

  # Método comun para iniciar sesión con otra red social
  def handle_auth(kind)
    # Guardamos en una variable los datos que nos retorna Facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    # Si existe el usuario en la base de datos se loguea
    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: kind)
      sign_in_and_redirect @user, event: :authentication
    #si algo dalla lo renderizamos a edit 
    else
      session["devise.auth_data"] = request.env["omniauth.auth"].except('extra')
      render :edit
    end
  end
end
