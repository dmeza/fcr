class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "sitebootstrapper"
  
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :first_name, :last_name, :indentifier, :city_id, :phone, :mobile, :birth_date, :motivation, :history, :password, :password_confirmation, :contact_me, :has_institution_induction)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:email, :first_name, :last_name, :indentifier, :city_id, :phone, :mobile, :birth_date, :motivation, :history, :password, :password_confirmation, :contact_me, :has_institution_induction, :remember_me, :current_password)
    end
    #devise_parameter_sanitizer.for(:invite).concat [:role_id, :company_id]
    #devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name]
  end
end
