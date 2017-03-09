class CollectController < ApplicationController

	def landing_page
  end

  def save_mail
  	email = params[:email]
  	redirect_to action: "register_volunteer_form", volunteer_email: email
  end

  def register_volunteer_form
  	@volunteer_email = params[:volunteer_email]
  end

  def register_volunteer_save
  	@volunteer = params[:user]
  	@volunteer.save
  end

   def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
