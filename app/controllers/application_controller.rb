class ApplicationController < ActionController::Base

  include Pundit::Authorization
    protect_from_forgery with: :exception
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
 
 private
    def user_not_authorized
       flash[:notice] = "no tiene permisos para esta accion"
       redirect_to(request.referrer || root_path)
    end
    
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type_document, :document, :first_name, :second_name, :first_last_name, :second_last_name, :phone_number, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:type_document, :document, :first_name, :second_name, :first_last_name, :second_last_name, :phone_number, :email, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:type_document])
  end

end
