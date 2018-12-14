class Users::OmniauthCallbacksController < ApplicationController
  # Devise::OmniauthCallbacksController ? no es necesario??
  
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted? # existe el usuario en la bd?
      @user.remember_me = true # sesion persistente, asi se cierre el navegador
      sign_in_and_redirect @user, event: :authentication
      # return ??
    else
      # se guarda la información en una sesión, asi se puede utilizar en otros métodos
      session["devise.auth"] = request.env["omniauth.auth"]

      render :edit  
    end
  end

  def custom_sign_up
    @user = User.from_omniauth(session["devise.auth"])

    if @user.update(user_params) # hash
      sign_in_and_redirect @user, event: :authentication
    else
      render :edit
    end
  end

  def failure
    #redirect_to new_user_session_path, notice: "Hubo un error con el login, intenta de nuevo"
    redirect_to new_user_session_path, notice:"Error: #{params[:error_description]}, Motivo: #{params[:error_reason]} "
  end

  # update({email: "codigo@facilito.com"}) # Actualizar
  # new ({}) # instanciar
  # create ({}) # instanciar y guardar

  # params # Hash {id: , email: "", authenticity_token: ""}
  # params # Hash {authenticity_token: "", user: {email: "", username: "", name: "" }]
  private
  def user_params # strong params
    params.require(:user).permit(:name, :username, :email)
  end
end
