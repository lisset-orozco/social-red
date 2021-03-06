class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #, prepend: true
  layout :set_layout
  # before_action :authenticate_user! # valida la sesion, si no redirecciona al login
  before_action :configurar_strong_params, if: :devise_controller?

  protected
    def set_layout
      "application"
    end

    def configurar_strong_params
      devise_parameter_sanitizer.permit(:sign_up,keys: [:username])
    end
end

